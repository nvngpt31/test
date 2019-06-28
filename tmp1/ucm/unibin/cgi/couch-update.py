#!/usr/bin/python

import os, json, requests, argparse, sys, re, fileinput
parser = argparse.ArgumentParser(description='Regex replacer script called specifically by UCM strmod type.')
parser.add_argument("-s", "--server", dest="server", help="The Server to check for in couch.", action="store")
# parser.add_argument("-d", "--dump", dest="dump", help="", action="store")

args            = parser.parse_args()
v_server        = args.server
# v_dump        = args.dump
v_headers       = {'Content-Type': 'application/json'}
v_cachedir      = '/etc/puppetlabs/code/ucm/cache/cgi'
v_jsonfile      = v_cachedir + '/' + v_server + '.saltoutput'
v_api_url_base  = 'http://foreman.associatesys.local:5984/ucmstuff'
v_api_url       = v_api_url_base + '/' + v_server
gotrev          = False
getdata         = requests.get(v_api_url, headers=v_headers)
saltjson_exists = os.path.isfile(v_jsonfile)

if getdata.status_code == 200:

  # SERVER EXISTS AND WE ARE GOING TO POST THE UPDATE VIA THE REV
  getdatastream = json.loads(getdata.content.decode('utf-8'))

  for k, v in getdatastream.items():
    line = '{0}:{1}'.format(k, v)
    if line.startswith('_rev'):
      rev      = line.split(':')[-1]
#      gotrev   = True
      postdata = {"name":v_server,"_rev":rev,"saltjson_exists":saltjson_exists} 
      break

  v_load = postdata.copy()

#  if gotrev:  

  if saltjson_exists:
    with open(v_jsonfile) as json_file:
      v_jsonfromsalt = json.load(json_file)
    v_load.update(v_jsonfromsalt)

  updatedata = requests.put(v_api_url, json=v_load)

  if updatedata.status_code == 201:
    print "Posted data to couch for server:", v_server
  else:
    print "Failed to post data to couch for server:", v_server

#  else:
#    print "Did not find revision for server:", v_server, "in output."

else:
  #  SERVER ENTRY DOES NOT EXIST AND CREATE NEW
  newdata = {"name":v_server,"saltjson_exists":saltjson_exists}
  v_load = newdata.copy()

  if saltjson_exists:
    with open(v_jsonfile) as json_file:
      v_jsonfromsalt = json.load(json_file)
    v_load.update(v_jsonfromsalt)

  createnew = requests.put(v_api_url, headers=v_headers, json=v_load)

  
