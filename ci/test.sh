#!/bin/bash
set -e

# Section 1: Toolchain set up
#
# We use four toolchains in our CI suite: Python (pytest), Node (`jsonschema`
# and `markdownlint`), Go (Vale and Hugo), and Rust (blocktest).
#
# We specify Python 3.6 as our primary language for Travis CI, which comes with
# a recent enough version of Node for our use cases. However, we need to
# manually install both Go and Rust:

# Install Go 1.8 using https://github.com/travis-ci/gimme.
eval "$(gimme 1.8)"

# Install Rust's stable toolchain using https://www.rustup.rs/.
export PATH="$HOME/.cargo/bin:$PATH"
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable

# Section 2: Global variables and utilities

# `DIR` is the directory holding this script.
#
# See https://goo.gl/uAK7pM (Stack Overflow).
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Section 3: Structure tests
#
# These tests relate to the structure (i.e., not the actual written content) of
# our markup (Markdown, for now).

# The first thing we do is use `blocktest` to preprocess our code examples.
#
# This converts our raw markup (the `blog` directory) into a Hugo-compatible
# `content` directory.
#
# See https://github.com/jdkato/blocktest.
cargo install blocktest && blocktest blog .md content

# We then test the formatting style of our Markdown (see the root-level
# `.markdownlint.json` file for more details).
#
# See https://github.com/igorshubovych/markdownlint-cli.
npm install -g markdownlint-cli && markdownlint content

# The final structure test we run is for our front matter.
#
# We use the Node.js script `structure.js` to define a JSON Schema that we then
# check our front matter against.

npm install --silent gray-matter # Extract the front matter.
npm install --silent glob        # Find the relevant files.
npm install --silent toml        # Used by `gray-matter`.
npm install --silent jsonschema

node $DIR/structure.js

# Section 4: Content tests
#
# These tests relate to our actual written content. We use Vale to check the
# following (see the root-level `.vale.ini` file for more details):
#
#    1. Our spelling;
#    2. our use of techincal terminology (see ci/core/Terms.yml); and
#    3. that we are adhering to the Google Developer Documentation Style Guide.
#
# See https://github.com/ValeLint/vale and https://developers.google.com/style.
go get github.com/ValeLint/vale && vale content

# Section 5: Build tests
#
# These tests relate to our the quality of our HTML as produced by Hugo.
#
# The first thing we do is install Hugo and build the site:
go get github.com/gohugoio/hugo && hugo

# We then install and run html-proofer, allowing for hash `href`s -- e.g.,
#
#    <a href="#" id="back_to_top"></a>
#
# See https://github.com/gjtorikian/html-proofer.
export NOKOGIRI_USE_SYSTEM_LIBRARIES=true && gem install html-proofer

htmlproofer public --allow-hash-href

# Finally, we run install and run a11y. This looks for basic accessibility
# violations.
#
# See https://github.com/addyosmani/a11y.
npm install -g a11y && a11y 'public/**/*.html'

# TODO: Add performance tests.
