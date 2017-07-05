#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os

topic_base = os.path.expanduser('./')
topics = [
    f for f in os.listdir(topic_base)
    if os.path.isdir(os.path.join(topic_base, f))
]

f = open(os.path.expandvars('./LAYERS.md'), 'w')
f.write('Layer Manifest\n')
f.write('==============\n\n')
f.write("%-20s | %s\n" % ('topic', 'layer'))
f.write("%-20s | %s\n" % (':---:', ':---:'))

url_prefix = 'https://github.com/liuchengxu/space-vim/tree/master/layers'

for t in topics:
    topic_path = topic_base + '/' + t
    layers = [
        f for f in os.listdir(topic_path)
        if os.path.isdir(os.path.join(topic_path, f))
    ]
    for l in layers:
        f.write("%-20s | [%s](%s/%s/%s)\n" % (t, l, url_prefix, t, l))

f.close()

print('LAYERS.md has been updated (created) successfully.')
