#!/bin/bash

# This script runs all tests that relate to our actual written content. This
# includes spelling, grammar, and style.

# Install Vale (https://github.com/ValeLint/vale):
go get github.com/ValeLint/vale

# Run Vale on our Markdown files:
vale content
