#!/usr/bin/python
import os, argparse, sys, re, fileinput
parser = argparse.ArgumentParser(description='')
parser.add_argument("-z", "--zone", dest="zone", help="", action="store", required=True)
parser.add_argument("-d", "--domain", dest="domain", help="", action="store", required=True)

args          = parser.parse_args()
v_file        = '/var/centrifydc/kset.zonename'
v_domain_file = '/var/centrifydc/kset.domain'
cent_file     = '/etc/centrifydc/centrifydc.conf'
v_zone        = args.zone
v_domain      = args.domain
v_zone_mig    = 'Unix'
proceed       = False 
cmd_sleep     = "sleep 5"
cmd_leave     = "adleave -f"
cmd_join      = "adjoin --force -u zUnixADJoin -p 't479788a1!' -c ou=Computers,ou=Unix -z %s %s" % (v_zone,v_domain)
ksetexists    = os.path.isfile(v_file)
centexists    = os.path.isfile(cent_file)

if centexists:

  if os.path.isfile(v_domain_file):
    with open(v_domain_file) as editfile:
      v_current_domain = editfile.readline().strip()
      
  # server is joined to zone
  if ksetexists:
    with open(v_file) as editfile:
      v_str         = editfile.readline()
      v_currentzone = v_str.split(',')[0].split('=')[-1] 
              
      if v_currentzone == v_zone_mig:
        print "This server belongs to the migrated zone 'Unix'."
        proceed = False
                
      elif v_currentzone == v_zone and v_current_domain == v_domain:
        proceed = False
        sys.exit(0)
           
      else:
        proceed = True 
         
    if proceed:
      print "Attempting to leave current domain..."
      print ""
      os.system(cmd_leave)
      print ""
      print "Sleeping for a few seconds..."
      print ""
      os.system(cmd_sleep)
      print "Attempting to join intended zone..."
      print ""
      os.system(cmd_join)
    else:
      sys.exit(0)
             
  # Server is not joined to zone
  else:
    os.system(join)
    
 
else:
  print "Is Centrify installed?  Bailing."
  sys.exit(1)
