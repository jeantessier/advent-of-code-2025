#!/bin/bash

for d in $(find . -name Gemfile -exec dirname \{\} \+)
do
    echo "==========" $d "=========="
    (
        cd $d
        bundle outdated
    )
done
