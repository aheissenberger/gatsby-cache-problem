#!/bin/bash

#set -x
case "$1" in
    restore)
        if [ -f "gatsby-artifacts.tgz" ]; then
            if [ -d ".cache" ]; then
                rm -fr .cache
            fi
            if [ -d "public/" ]; then
                rm -fr public
            fi
            # if [ -d "node_modules/" ]; then
            #     rm -fr node_modules
            # fi
            tar -xf gatsby-artifacts.tgz
            echo "restored from gatsby-artifacts.tgz\n"
        fi
        ;;
    save)
        if [ -f "gatsby-artifacts.tgz" ]; then
            rm gatsby-artifacts.tgz
        fi
        tar czf gatsby-artifacts.tgz .cache/ public/ 
        echo "saved to gatsby-artifacts.tgz\n"
        if [ -d ".cache" ]; then
            rm -fr .cache
        fi
        if [ -d "public/" ]; then
            rm -fr public
        fi
        ;;
    *)
        echo $"Usage: $0 {restore|save}"
        exit 1
esac

if [ -f ".cache/newPages.txt" ]; then
    rm .cache/newPages.txt
fi
if [ -f ".cache/deletedPages.txt" ]; then
    rm .cache/deletedPages.txt
fi