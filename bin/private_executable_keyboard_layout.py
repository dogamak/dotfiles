#!/usr/bin/env python

import sys
import subprocess

layouts = ['fi', 'us']

def run(*args):
    child = subprocess.Popen(args, stdout=subprocess.PIPE)
    return child.communicate()[0]

def get_current_layout():
    out = run('setxkbmap', '-query')

    return next(
        line.split(b':')[1].strip().decode('utf-8')
        for line in out.split(b'\n')
        if line.startswith(b'layout:')
    )

def get_next(cur):
    if cur not in layouts:
        return layouts[0]

    i = layouts.index(cur) + 1
    i %= len(layouts)
    return layouts[i]

if '--toggle' in sys.argv:
    run('setxkbmap', get_next(get_current_layout()))

print(get_current_layout())
