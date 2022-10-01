#!/bin/python3

from html.parser import HTMLParser

class SexyHTMLParser(HTMLParser):
    def handle_starttag(self, tag, attrs):
        print("Start : %s" % tag)
        for attr, value in attrs:
            print("->", attr, ">", value)
    def handle_endtag(self, tag):
        print("End   : %s" % tag)
    def handle_startendtag(self, tag, attrs):
        print("Empty : %s" % tag)
        for attr, value in attrs:
            print("->", attr, ">", value)

N = int(input())
html = ""
for _ in range(N):
    html = html + input()

_ = SexyHTMLParser().feed(html)
