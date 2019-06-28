#!/usr/bin/python

import argparse, sys, re, fileinput, os
user = 'joshua'
cmd  = "echo %s | tee /tmp/names.txt" % user
print "command is:", cmd
os.system(cmd)


