#!/usr/bin/python
# -*- coding: utf-8 -*-
#
# <bitbar.title>Current ISP</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Atul Yadav</bitbar.author>
# <bitbar.author.github>sayatul</bitbar.author.github>
# <bitbar.desc>Display's your current ISP</bitbar.desc>
# <bitbar.dependencies>python</bitbar.dependencies>

import requests
import time

try:
    res = requests.get('http://ipinfo.io')
    res = res.json()
    isp = res['hostname'].split('.')[-2]
    print(isp)
except Exception:
    print('Not Connected')
