👋 Hi, We are @Hackmosphere

We are a team of ethical Hackers. 🌱 We are not only ethical in our way of working, we also try to minimize our ecological impact to a maximum !

💞️ In this repository, we want to share with you some of the Lua scripts we have created for detection using Suricata 💞️

#How to enable Lua scripts in Suricata 7.X ? 
Lua is disabled by default for use in Suricata rules and must be enabled in the configuration file. 
See the security.lua section of suricata.yaml and enable 'allow-rules' to get something like that :
```yaml
**cat suricata.yml**
    [...] 
  
    security:
    [...] 
        lua:
            allow-rules: true 

    outputs: 
        [...]
        lua: YourCustomScript.lua 
    
    [...]

