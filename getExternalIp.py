#!/usr/bin/env python


try:
    from urllib.request import urlopen
    print(urlopen('http://ip.42.pl/raw').read().decode())
except ImportError:
    from urllib2 import urlopen
    print(urlopen('http://ip.42.pl/raw').read())

