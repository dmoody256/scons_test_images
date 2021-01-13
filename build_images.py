#!/usr/bin/env python3

import subprocess
import pathlib

exitcode = -1
while exitcode != 0:
    exitcode, output = subprocess.getstatusoutput('docker login')

username = ''
output = subprocess.getoutput('docker system info')
for line in output.splitlines():
    if line.strip().startswith('Username'):
        username = line.strip().split(' ')[1]
        break

for dockerfile in pathlib.Path('.').glob('*.Dockerfile'):
    subprocess.check_call(f'docker build -t {username}/scons_test_image:{dockerfile.with_suffix("")} -f {dockerfile.name} .'.split(' '))
    subprocess.check_call(f'docker push {username}/scons_test_image:{dockerfile.with_suffix("")}'.split(' '))

