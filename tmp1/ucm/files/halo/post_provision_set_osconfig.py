# Add Python code
import json
from cbhooks.models import ServerAction

#will run the server action with the given name under the given server and provide status of the action in the given job
def main(job, server, actionName, osConucm=None): 
     
     try:
         # if os conucm was given include it as a parameter for the action
         if osConucm:
             result = ServerAction.objects.get(label = actionName).run_hook(server = server, osConucm = osConucm)
             job.set_progress("result of 'run_hook': {}".format(result))
                 
         # run the job 
         else:
             result = ServerAction.objects.get(label = actionName).run_hook(server = server)
             job.set_progress("Result of 'run_hook': {}".format(result))
             
         
        
         #result is the return of the job of the server action that was just ran
    
     except Exception as err:
         job.set_progress("'{}' action called unsuccessfully".format(actionName))
         job.set_progress(str(err))
         return False
         
     else:
         
         if "FAILURE" in result: 
             job.set_progress("'{}' action called unsuccessfully".format(actionName))
             job.set_progress(result)
             return False
             
         else: 
             job.set_progress("'{}' action called successfully".format(actionName))
             job.set_progress(result)
             return True

def run(job, **kwargs):
     job.set_progress("There are the kwargs being passed: {}".format(kwargs))
     server = job.server_set.first()
     job.set_progress('START post_provision_set_osConucm')
     
     param_name = "osConucm"
     
     osConucm = server.get_value_for_custom_field (param_name)
     
     #osConucm not parsed now b/c it was already parsed before the server was provisioned 
     
     #write the parsed 'osConucm' on to the local server
     if not main(job, server, "write_to_Server", server.get_value_for_custom_field(param_name)):
         return "FAILURE", "Failed while writing osConucm to the local server", ""
         
     elif not main(job, server, "Apply HALO Server Conucm"):
         return "FAILURE", "Failed while running Puppet", ""
         
     else:
         return "SUCCESS", "", ""