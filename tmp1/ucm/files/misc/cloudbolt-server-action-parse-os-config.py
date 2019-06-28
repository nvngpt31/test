# Add Python code

import json

REQ_VALUES={
     "limits":["name","user", "hardvalue", "softvalue"],
     "kernelparams":["name","value", "comment"],
     "cronjobs": ["name", "crontab"],
     "directories": ["name", "owner", "group", "mode"],
     "shares":["name", "share", "user", "group"],
     "packages": ["name","state", "version"],
     "commands":["name", "runas","tagname"]
}
PARAM_NAME = 'osConfig'


def run(job, server=None, **kwargs):
     if not server:
         return "FAILURE", "", "parse_osConfig expects a server obj, got none"
     # server = job.server_set.first()
     puppet_obj = {}
     #get the value from the server variable 
     tempConfig = server.get_value_for_custom_field(PARAM_NAME)
     
     #check if the given configuration is empty or declared on the server 
     if not tempConfig or tempConfig.isspace():
         job.set_progress("'{}' is empty or not declared".format(PARAM_NAME))
         #if the variable is empty an it is set to an empty json object
         #if the there is no json object later proccesses will fail
         server.set_value_for_custom_field(PARAM_NAME, """{}""")
         job.set_progress("{} set to an empty json object".format(PARAM_NAME))
         return "SUCCESS", "", ""
     
     else:
         job.set_progress("Config value {} ".format(tempConfig));
         serverConfig = json.loads(tempConfig, strict=False)

    
     for item, list in serverConfig.iteritems():
         
         if(item not in REQ_VALUES) or not bool(list):
             job.set_progress("Error: Key '{}' is not expected or empty".format(item))
             return "FAILURE", "",""
                
         else: 
             job.set_progress("Key '{}' present".format(item))
                
         puppet_obj[item] = {} 
         
         for element in list:
             
             if( type(element) is dict):
                 for key, value in element.iteritems():
                    
                     if (key not in REQ_VALUES[item]) or (not bool(value) and value is not 0):
                         job.set_progress("Error: Key '{}' in '{}' is not excepted or empty.".format(key, item))
                         return "FAILURE", "", ""
                            
                     else: 
                         job.set_progress("Key '{}' is present in '{}'".format(key, item))
                            
                     if key is "tagname" and " " in value:
                         temp = value.replace(" ", "_")
                         element[key] = temp
                         
             else: 
                 message = {
                     "Error":"{} must be in the designated formate to be parsed, as seen in the example provided".format(PARAM_NAME),
                     "Categories of OS":
                         [{
                             "name":"name of config or path",
                             "other":"other parameters"
                         }]
                     ,
                     "More Info" :"https://confluence.associatesys.local/pages/viewpage.action?pageId=15738402"
                 }
                 
                 return "FAILURE", json.dumps(message, indent = True), ""
                
             title  = element["name"]
             del element["name"]
             puppet_obj[item][title] = element
             
     osConfig = json.dumps(puppet_obj, indent = True)
     server.set_value_for_custom_field(PARAM_NAME, osConfig)
     
     return "SUCCESS", "" , ""
