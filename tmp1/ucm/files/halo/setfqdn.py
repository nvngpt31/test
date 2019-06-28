import time

def run (job, server, **kwargs):
    fqdn =None
    status="FAILED"
    remote_script = """
    hostname -A
    """
    for t in range(18):
        fqdn = server.execute_script(script_contents=remote_script)
        l = fqdn.split('.')
        if len(l) > 2 and l[0] == server.hostname:
            server.set_value_for_custom_field("FQDN",fqdn)
            status="SUCCESS"
            msg = "Set FQDN to "+fqdn
            break
        time.sleep(10)
    
    if status == "FAILED":
        msg = "Unable to set FQDN to {}".format(fqdn)
    
        
    return status,msg,""
