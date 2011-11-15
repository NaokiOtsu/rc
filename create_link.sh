#!/bin/sh
cd $(dirname $0)
for rc in .?*
do
if [ $rc != '..' ] && [ $rc != '.git' ]
    then
ln -Fis "$PWD/$rc" $HOME
    fi
done
