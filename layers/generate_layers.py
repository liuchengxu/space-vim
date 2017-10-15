#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import re

topic_base = os.path.expanduser('./')
topics = [
    f for f in os.listdir(topic_base)
    if os.path.isdir(os.path.join(topic_base, f))
]

f = open(os.path.expandvars('./LAYERS.md'), 'w')
f.write('Layer Manifest\n')
f.write('==============\n\n')
f.write("%-20s | %s | %s\n" % ('Topic', 'Layer', 'Plugins'))
f.write("%-20s | %s | %s\n" % (':----:', ':----:', ':----'))

url_prefix = 'https://github.com/liuchengxu/space-vim/tree/master/layers'

for t in topics:
    topic_path = topic_base + '/' + t
    layers = [
        f for f in os.listdir(topic_path)
        if os.path.isdir(os.path.join(topic_path, f))
    ]
    for l in layers:
        plugins = "<ul>"
        with open(topic_path + '/' + l + '/packages.vim', 'rt') as fp:
            for line in fp:
                if line.lstrip(' \t\n\r').startswith('MP'):
                    res = re.split(r"'*/*'", line)
                    plugins += "<li>[" + res[1] + "]"
                    plugins += "(https://github.com/" + res[1] + ")</li>"
        plugins += "</ul>"
        f.write("%-20s | [%s](%s/%s/%s) | %s\n" % (t, l, url_prefix, t, l,
                                                   plugins))

f.close()

print('LAYERS.md has been updated (created) successfully.')
