#!/bin/sh

for i in *
do
    [ -e $i/.git ] && \
        echo "~ $i ~" && \
        cd $i && \
        git pull && \
        git status && \
        cd ..;
done

git status
