#!/usr/bin/env python3
##
##  Package uploader for Bintray.
##
##  Leonid Plyushch <leonid.plyushch@gmail.com> (C) 2019
##
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##

import os
import sys
import json

import requests

from requests.auth import HTTPBasicAuth

class PackageMetadata(object):
    def __init__(self, build_script_path):
        if not os.path.exists(build_script_path):
            print(f"[!] File {build_script_path} is not exist.")
            sys.exit(1)

        if os.path.basename(build_script_path) != "build.sh":
            print(f"[!] File '{build_script_path}' is not a build script.")
            sys.exit(1)

        package_name = os.path.basename(os.path.dirname(build_script_path))

        self.name = package_name
        self.desc = None
        self.licenses = None
        self.vcs_url = "https://github.com/termux/x11-packages"
        self.website_url = None
        self.issue_tracker_url = "https://github.com/termux/x11-packages/issues"
        self.github_repo = "termux/x11-packages"
        self.public_download_numbers = False
        self.public_stats = False

        with open(build_script_path, "r") as build_script:
            for line in build_script:
                if line.startswith("TERMUX_PKG_LICENSE"):
                    self.licenses = [self.get_value(line, "TERMUX_PKG_LICENSE")]

                if line.startswith("TERMUX_PKG_DESCRIPTION"):
                    self.desc = self.get_value(line, "TERMUX_PKG_DESCRIPTION")

                if line.startswith("TERMUX_PKG_HOMEPAGE"):
                    self.website_url = self.get_value(line, "TERMUX_PKG_HOMEPAGE")

                if line.startswith("TERMUX_PKG_VERSION"):
                    self.version = self.get_value(line, "TERMUX_PKG_VERSION")

        if not self.licenses:
            print(f"[!] No license for package '{package_name}'.")
            sys.exit(1)

        if not self.licenses:
            print(f"[!] No homepage for package '{package_name}'.")
            sys.exit(1)

        if not self.desc:
            print(f"[!] No description for package '{package_name}'.")
            sys.exit(1)

        if not self.version:
            print(f"[!] No version for package '{package_name}'.")
            sys.exit(1)

    def get_value(self, string, key):
        value = string.split(f"{key}=")[1]

        for char in "\"'\n":
            value = value.replace(char, '')

        return value

    def dump(self):
        return self.__dict__

def read_env_var(var_name):
    if var_name in os.environ:
        return os.environ[var_name]
    else:
        print(f'[!] Environment variable {var_name} is not set.')
        sys.exit(1)

def main():
    if len(sys.argv) == 1:
        print("")
        print("Usage: bintray-add-package.py [-d] [path to build.sh]")
        print("")
        print("Package uploader script for Bintray.")
        print("")
        print("Options:")
        print("")
        print("  -d  Delete package instead of uploading.")
        print("")
        print("Credentials are specified via environment variables:")
        print("")
        print("  BINTRAY_USERNAME  - User or organisation name.")
        print("  BINTRAY_API_KEY   - API key.")
        print("")
        sys.exit(1)

    bintray_user = read_env_var("BINTRAY_USERNAME")
    bintray_api_key = read_env_var("BINTRAY_API_KEY")

    metadata = PackageMetadata(sys.argv[1])

    response = requests.post("https://api.bintray.com/packages/xeffyr/x11-packages",
                             json=metadata.dump(),
                             auth=HTTPBasicAuth(bintray_user, bintray_api_key))

    if response.status_code == 201:
        print(f"[*] New package '{metadata.name}' successfully created.")
    elif response.status_code == 409:
        print(f"[!] Package '{metadata.name}' already exists.")
    else:
        print(f"[!] Failed to submit a package '{sys.argv[1]}'.")
        print(f"Raw response: {response.text}")
        sys.exit(1)

if __name__ == "__main__":
    main()
