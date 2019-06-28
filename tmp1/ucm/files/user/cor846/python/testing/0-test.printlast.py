#!/usr/bin/python

import argparse, sys, re, fileinput

line    = 'some=1,text=2,here=3'
linestr = line.split(",")[0] 

print "linestr:", linestr

