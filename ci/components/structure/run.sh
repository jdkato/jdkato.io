#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

npm install --silent gray-matter
npm install --silent glob
npm install --silent toml
npm install --silent jsonschema

node $DIR/structure.js

# This script runs all tests that relate to the structure of our content. For
# us, this means the style of our Markdown.

# Install MarkdownLint (https://github.com/igorshubovych/markdownlint-cli):
npm install -g markdownlint-cli

# Run MarkdownLint on our content:
markdownlint content
