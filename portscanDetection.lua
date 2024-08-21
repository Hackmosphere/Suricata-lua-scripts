--------------------------------------------------------------------
---  portscan.lua
--------------------------------------------------------------------
-- In this setup, nmap -T1 scans and up are detected. -T0 scans are not.
-- Table to track the source IP and destination ports
local portscan = {}
local last_reset_time = nil

function init (args)
    local needs = {}
    needs["packet"] = tostring(true)
    return needs
end

-- Function to clear the portscan table every X seconds
function clear_table()
    portscan = {}
end

-- Helper function to convert time string to seconds
function time_to_seconds(time_str)
    local year, month, day, hour, min, sec, msec = time_str:match("(%d+)/(%d+)/(%d+)-(%d+):(%d+):(%d+).(%d+)")
    return os.time{year=year, month=month, day=day, hour=hour, min=min, sec=sec}
end

-- Start of the real logic
function match(args)
    local pkt = args["packet"]
    
    if pkt == nil then
        return 0
    end

    -- Get the current packet timestamp
    local current_time_str = SCPacketTimeString()
    local current_time = time_to_seconds(current_time_str)

    -- Initialize last_reset_time if it's nil
    if last_reset_time == nil then
        last_reset_time = current_time
    end

    -- Clear the table if more than 120 seconds have passed since the last reset
    if os.difftime(current_time, last_reset_time) > 150 then
        clear_table()
        last_reset_time = current_time
    end


    -- Extract source IP and destination port
    ipver, src_ip, dst_ip, proto, src_port, dst_port = SCPacketTuple()

    if src_ip == nil or dst_port == nil then
        return 0
    end

    if not portscan[src_ip] then
        portscan[src_ip] = {}
    end

    portscan[src_ip][dst_port] = true

    -- Count the number of different destination ports
    local port_count = 0
    for port, _ in pairs(portscan[src_ip]) do
        port_count = port_count + 1
    end

    -- Trigger alert if more than 8 different ports are reach within X seconds
    if port_count > 9 then
        return 1
    end

    return 0
end

