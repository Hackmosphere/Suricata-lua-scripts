👋 Hi, We are @Hackmosphere

🌱 We are a team of ethical hacker, not only in our way of working, we also try to minimize our ecological impact to a maximum !

💞️ In this repository, we want to share with you some of the Lua scripts we have created for detection using Suricata 💞️

# Scripts explanation
**local.rules** : Contains the rules to be added to your Suricata rule file 

**portscanDetection.lua** : We couldn't find any Suricata alert that successfully detects portscans (at best they would trigger if X TCP connections were received in a short amount of time, regardless if it was the same port or not). So we created this portscan detector ! More details on its inner working in comments of the file.

# How to enable Lua scripts in Suricata 7.X ? 
Lua is disabled by default for use in Suricata rules and must be enabled in the configuration file. 
See the security.lua section of suricata.yaml and enable 'allow-rules' to get something like that :
```yaml
#cat suricata.yml
    [...] 
  
    security:
    [...] 
        lua:
            allow-rules: true 

    outputs: 
        [...]
        lua: YourCustomScript.lua 
    
    [...]

