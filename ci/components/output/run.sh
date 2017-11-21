#!/bin/bash

# This script runs all tests that relate to the HTML produced from our content.
# The idea here is to ensure that our raw HTML adheres to accepted quality
# standards in terms of structure (tags, attributes, etc.), accessibility, and
# performance.

# Install Hugo and build the site:
go get github.com/gohugoio/hugo && hugo

# Install and run html-proofer (https://github.com/gjtorikian/html-proofer).
#
# We allow hash `href`s -- e.g.,
#
#    <a href="#" id="back_to_top"></a>
export NOKOGIRI_USE_SYSTEM_LIBRARIES=true gem install html-proofer
htmlproofer public --allow-hash-href

# Install and run a11y (https://github.com/addyosmani/a11y):
npm install -g a11y && a11y 'public/**/*.html'
