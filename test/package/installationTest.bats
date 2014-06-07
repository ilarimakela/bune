#!/usr/bin/env bats

# https://github.com/sstephenson/bats

@test "Check is package available" {
   RPM=$(ls -r /data/dist/bune-*.rpm | head -n 1)

   [ -f $RPM ] || exit 1
}

@test "Install Bune" {
   RPM=$(ls -r /data/dist/bune-*.rpm | head -n 1)

   yum -y --nogpgcheck localinstall $RPM
}

@test "Run Bune and get default usage options" {
   bune 2>&1 | grep -q Usage
}

