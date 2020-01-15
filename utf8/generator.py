#!/bin/env python3

import sys

def get_next_character(f):
    c = f.read(1)
    i = 0
    while c:
        yield i,c
        c = f.read(1)
        i = i + 1

s = 0
u = 0
with open(sys.argv[1], encoding="utf-8") as f:
    for i, c in get_next_character(f):
        s = s +ord(c)
        if c.isupper():
           u = u + 1

print(s)
print(u)
