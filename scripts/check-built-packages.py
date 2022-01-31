#!/usr/bin/env python3
##
##  Script for comparing local and remote package versions.
##
##  Copyright 2019 Fredrik Fornwall <fredrik@fornwall.net>
##
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##
##    http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.
##

import urllib.request
from subprocess import Popen, PIPE

version_map = {}
any_error = False

pipe = Popen('./scripts/list-versions.sh', stdout=PIPE)
for line in pipe.stdout:
    (name, version) = line.decode().strip().split('=')
    version_map[name] = version

def check_manifest(arch, manifest):
    current_package = {}
    for line in manifest:
        if line.isspace():
            package_name = current_package['Package']
            package_version = current_package['Version']
            if not package_name in version_map:
                # Skip sub-package
                continue
            latest_version = version_map[package_name]
            if package_version != latest_version:
                print(f'{package_name}@{arch}: Expected {latest_version}, but was {package_version}')
            current_package.clear()
        elif not line.decode().startswith(' '):
            parts = line.decode().split(':', 1)
            current_package[parts[0].strip()] = parts[1].strip()

for arch in ['aarch64', 'arm', 'i686', 'x86_64']:
    manifest_url = f'https://ipfs.io/ipns/k51qzi5uqu5dgu3homski160l4t4bmp52vb6dbgxb5bda90rewnwg64wnkwxj4/dists/x11/main/binary-{arch}/Packages'
    with urllib.request.urlopen(manifest_url) as manifest:
        check_manifest(arch, manifest)
