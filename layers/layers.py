#!/usr/bin/env python3
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

layers_md = os.path.expandvars('./LAYERS.md')
output = open(layers_md, 'w')

header = []
header.append('Layer Manifest\n')
header.append('==============\n\n')
header.append('Last updated: ' +
              time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()))
header.append("\n\n")
header.append("Default layers: `fzf`, `better-defaults` and `which-key`.")
header.append("\n\n")

header.append("%-20s | %s | %s\n" % ('Topic', 'Layer', 'Plugins'))
header.append("%-20s | %s | %s\n" % (':----:', ':----:', ':----'))

output.writelines(header)

url_prefix = 'https://github.com/liuchengxu/space-vim/tree/master/layers'

plugins = []

for topic in sorted(info_topics.keys()):
    layers = info_topics[topic]
    pattern = re.compile('\'(.*)\'')
    for layer in sorted(layers):
        plugs = []
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
                            plugs.append(plug)
        plugs.sort()
        plugs = map(
            lambda x: "<li>[{}](https://github.com/{})</li>".format(x, x),
            plugs)
        plugs = '<ul>' + ''.join(plugs) + '</ul>'
        row = ("%-20s | [%s](%s/%s/%s) | %s\n" % (topic, layer, url_prefix,
                                                  topic, layer, plugs))
        output.write(row)

output.close()

print('LAYERS.md has been updated (created) successfully.')
print('All related plugins: {}'.format(len(plugins)))
