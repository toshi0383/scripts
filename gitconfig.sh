#!/bin/bash
git config --global alias.a 'add'
git config --global alias.ap 'add -p'
git config --global alias.b 'checkout -b'
git config --global alias.ba 'branch -a'
git config --global alias.br 'branch'
git config --global alias.brd 'branch -d'
git config --global alias.brdf 'branch -df'
git config --global alias.c 'commit -v'
git config --global alias.d 'diff'
git config --global alias.dc 'diff --cached'
git config --global alias.f 'fetch'
git config --global alias.g 'grep -in'
git config --global alias.hard 'reset --hard'
git config --global alias.hardd 'reset --hard HEAD^'
git config --global alias.hist 'log --pretty=format:\\"%C(yellow)%h %C(White)%ad | %C(White)%s%C(Green)%d %C(Red)[%an]\\" --graph --date=short'
git config --global alias.l 'log'
git config --global alias.line 'log --no-merges --date=short --pretty=format:\\"%C(yellow)%h %C(green)%cd %C(blue)%an%C(red)%d %C(reset)%s\\"'
git config --global alias.o 'checkout'
git config --global alias.p 'pull'
git config --global alias.pu '!git push origin `git rev-parse --abbrev-ref HEAD`'
git config --global alias.nuke '!sh -c "git branch -d ${1} && git push origin --delete ${1}"'
git config --global alias.pu-nuke '!sh -c "git pu && git nuke ${1}"'
git config --global alias.puu 'push -u'
git config --global alias.rp 'reset -p'
git config --global alias.s 'status'
git config --global alias.soft 'reset --soft'
git config --global alias.softt 'reset --soft HEAD^'
git config --global alias.st 'stash'
git config --global alias.stat 'log --stat'
git config --global alias.stp 'stash pop'
git config --global alias.unstg 'reset HEAD'
