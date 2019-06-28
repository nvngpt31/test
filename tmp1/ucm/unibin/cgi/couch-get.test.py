#!/usr/bin/python

import json, requests, argparse, sys, re, fileinput
parser = argparse.ArgumentParser(description='Regex replacer script called specifically by UCM strmod type.')
parser.add_argument("-s", "--server", dest="server", help="The Server to check for in couch.", action="store")
parser.add_argument("-d", "--dump", dest="dump", help="", action="store")

args         = parser.parse_args()
v_server     = args.server
v_dump       = args.dump
v_headers      = {'Content-Type': 'application/json'}
v_cachedir     = '/etc/puppetlabs/code/ucm/cache/cgi'
v_jsonfile     = v_cachedir + '/' + v_server + '.saltoutput'
v_api_url_base = 'http://foreman.associatesys.local:5984/ucmstuff'
v_api_url      = v_api_url_base + '/' + v_server
gotrev       = False
# getdata      = requests.get(v_api_url, headers=v_headers)

datatopost = {"Name":v_server, "Success":"true"}
postdata   = requests.put(v_api_url, headers=v_headers, json=datatopost)

print postdata.status_code


