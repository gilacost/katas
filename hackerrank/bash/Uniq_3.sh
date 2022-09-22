#!/bin/bash

uniq -ci | sed -e 's/ *//' -e 's/ / /'
