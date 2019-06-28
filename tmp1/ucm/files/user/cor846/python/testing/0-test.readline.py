#!/usr/bin/python

import argparse, sys, re, fileinput
f_file = './fruits.txt'

with open(f_file) as editfile:
  line = editfile.readline()

print "line is:", line

