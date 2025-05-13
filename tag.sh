#!/bin/bash

# check tag was specified
if [ -z "$1" ]; then
    echo "Usage: $0 <tag>"
    exit 1
fi

tag=$1

# create full tag
git tag "$tag"
git push origin "$tag" --force

# delete old v1 tag
git tag -d v1
git push --delete origin v1

# point v1 tag at new full tag
git tag -f v1 "$tag"
git push origin v1 --force 