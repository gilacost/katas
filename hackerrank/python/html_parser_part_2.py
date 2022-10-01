#!/bin/python3

from html.parser import HTMLParser

class SexyHTMLParser(HTMLParser):
    def handle_comment(self, data):
        if len(data.splitlines()) == 1:
            print(">>> Single-line Comment")
        else:
            print(">>> Multi-line Comment")
        print(data.replace("\r", "\n"))
    def handle_data(self, data):
        if data != "\n":
            print(">>> Data") 
            print(data)

N = int(input())
html = ""
for _ in range(N):
    html = html + input() + "\n"

_ = SexyHTMLParser().feed(html)
