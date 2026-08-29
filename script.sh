#!/usr/bin/env bash

# Collect plugin URLs from vim.pack.add({ ... }) calls in the current
# Neovim config directory and print them to stdout.

perl -0ne '
    while (/vim\.pack\.add\s*\(\s*\{(.*?)\}\s*\)/gs) {
        my $plugins = $1;

        while ($plugins =~ /["'\''](https?:\/\/[^"'\'']+)["'\'']/g) {
            print "$1\n";
        }
    }
' -- $(find . -type f -name '*.lua' -print)

