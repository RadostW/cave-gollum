# installation guide

## Follow "Debian 9.7 - gem" installation guide

https://github.com/gollum/gollum/wiki/Installation

Requires sudo
Requires cmake

Follow "Debian 9.7 - gem" installation guide
(60 MB download + some)
Building first time takes a few minutes

## Prepare repository

$ mkdir my_wiki
$ cd my_wiki
$ git init --initial-branch=trunk

## Run gollum

Run gollum by specifying path to the wiki and branch name

$ gollum --ref main my_wiki/

Open gui by executing

$firefox http://localhost:4567

screen -dmS gollum_web gollum --ref master expoweb
screen -dmS gollum_loser gollum --ref master loser

 

