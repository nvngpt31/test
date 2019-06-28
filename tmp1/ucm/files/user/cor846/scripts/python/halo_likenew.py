#!/usr/bin/python

import os
import shutil

moddir = '/etc/puppetlabs/code/environments/production/modules/'
rm_dirs = os.listdir(moddir)

rm_softlinks = [
  "/etc/puppetlabs/code/environments/production/hieradata/hieradata",
  "/root/hieradata",
  "/root/modules", ]

rm_files = [
  "/etc/puppetlabs/code/environments/production/hieradata/base.yaml",
  "/etc/puppetlabs/code/environments/production/hieradata/common.yaml",
  "/etc/puppetlabs/code/environments/production/hieradata/hieradata", ]

for x in rm_softlinks:
  link_exists = os.path.exists(x)
  if link_exists:
    print("removing link " + x)
    os.remove(x)

for x in rm_files:
  file_exists = os.path.isfile(x)
  if file_exists:
    print("removing " + x)
    os.remove(x)

for x in rm_dirs:
  remove_dir = moddir + x
  dir_exists = os.path.isdir(remove_dir)
  if dir_exists:
    print("removing " + remove_dir)
    shutil.rmtree(remove_dir)

