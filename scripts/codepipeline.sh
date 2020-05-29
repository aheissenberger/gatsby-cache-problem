#!/bin/bash

set -x

BUILD_CACHE=/tmp/buildcache.tgz
TMPDIR=$(mktemp -d)
git clone https://github.com/aheissenberger/gatsby-cache-problem.git $TMPDIR
if [ -f "$BUILD_CACHE" ]; then
   tar -xf "$BUILD_CACHE" --directory $TMPDIR
fi
pushd $TMPDIR
yarn install
GATSBY_EXPERIMENTAL_PAGE_BUILD_ON_DATA_CHANGES=true yarn build --log-pages || exit 1
if [ -f "$BUILD_CACHE" ]; then
   rm "$BUILD_CACHE"
fi
tar czf "$BUILD_CACHE" .cache/ public/
popd