#!/usr/bin/python3

# Read /proc/meminfo
meminfo = dict((i.split()[0].rstrip(':'),int(i.split()[1])) for i in open('/proc/meminfo').readlines())
mem_kib = meminfo['MemTotal']  # e.g. 3921852
mem_gib = mem_kib/(1024**2)

# # PSUTILS
# import psutil
# mem_gib = psutil.virtual_memory().total/1024**3

# # OS
# import os
# mem_bytes = os.sysconf('SC_PAGE_SIZE') * os.sysconf('SC_PHYS_PAGES')  # e.g. 4015976448
# mem_gib = mem_bytes/(1024.**3)

print(f"{mem_gib:.1f}")
