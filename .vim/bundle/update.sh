#!/bin/sh

for i in *
do
    [ -e $i/.git ] && \
        echo "~ $i ~" && \
        cd $i && \
        git pull && \
        cd ..;
done

