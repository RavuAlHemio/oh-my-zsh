#!/bin/sh
# hint: to upgrade other copies, do a git pull --rebase ondra master

git checkout upstream-master && \
git pull robbyrussell master && \
git checkout ondra-master && \
git rebase upstream-master && \
git push --force ondra ondra-master:master
