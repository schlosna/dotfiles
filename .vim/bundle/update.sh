#!/bin/sh

for i in *
do
    [ -d $i/.git ] && \
        echo "~ $i ~" && \
        cd $i && \
        git pull && \
        cd ..;
done

