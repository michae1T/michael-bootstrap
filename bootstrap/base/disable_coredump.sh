#!/bin/bash

echo "kernel.core_pattern=|/bin/true" > /etc/sysctl.d/disable_coredump.conf

sysctl --system
