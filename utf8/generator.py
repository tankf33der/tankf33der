#!/bin/env python3

import sys

def get_next_character(f):
    c = f.read(1)
    while c: 
        yield c
        c = f.read(1)
 
s = 0
with open(sys.argv[1], encoding="utf-8") as f:
    for c in get_next_character(f):
        s = s +ord(c)
print(s)
