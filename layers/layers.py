#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""

$ ./layers.py

update LAYERS.md

"""

import os
import re
import time
import ast

info_path = os.path.expanduser('~/.space-vim/core/autoload/spacevim/info.vim')

topics = dict()
layers = dict()

with open(info_path) as f:
    lines = f.readlines()
    info_topics = ast.literal_eval(lines[0].split('=')[1].strip())
    info_layers = ast.literal_eval(lines[1].split('=')[1].strip())

output = open(os.path.expandvars('./LAYERS.md'), 'w')
output.write('Layer Manifest\n')
output.write('==============\n\n')
output.write('Last updated: ' +
             time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()))
output.write("\n\n")
output.write(
    "Default layers: `fzf`, `unite`, `better-defaults` and `which-key`.")
output.write("\n\n")

output.write("%-20s | %s | %s\n" % ('Topic', 'Layer', 'Plugins'))
output.write("%-20s | %s | %s\n" % (':----:', ':----:', ':----'))

url_prefix = 'https://github.com/liuchengxu/space-vim/tree/master/layers'

plugins = []

for topic, layers in info_topics.items():
    pattern = re.compile('\'(.*)\'')
    for layer in layers:
        plugs = "<ul>"
        with open(info_layers[layer]['dir'] + '/packages.vim') as f:
            for line in f.read().splitlines():
                if line.startswith('"'):
                    continue
                mat = pattern.search(line)
                if mat is not None:
                    if mat.group(0).find('/') != -1:
                        plug = mat.group(0).split("'", 2)[1]
                        if line.count('<Plug>'):
                            continue
                        if plugins.count(plug):
                            continue
                        else:
                            plugins.append(plug)
                            plugs += (
                                "<li>[{}](https://github.com/{})</li>".format(
                                    plug, plug))
        plugs += "</ul>"
        output.write("%-20s | [%s](%s/%s/%s) | %s\n" %
                     (topic, layer, url_prefix, topic, layer, plugs))
output.close()

print('LAYERS.md has been updated (created) successfully.')
print('All related plugins: {}'.format(len(plugins)))
