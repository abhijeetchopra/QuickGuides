# --------------------------------------
# Auth: Abhijeet Chopra
# Date: Mon Oct 16, 2017
# Desc: Quick Git Guide
# --------------------------------------

# REFERENCES
#---------------------------------------
# 1. https://git-scm.com/docs/
# 2. http://gitimmersion.com


# GIT HELP
#---------------------------------------

# Git User Manual
info git

# Git command Quick Reference
git [command] -help

# Git command Manual Pages
git help [command]
git [command] --help


# GIT CONFIGURATION
#---------------------------------------

# checking configuration settings
git config --list

# checking configuration settings specific key value
git config --global <key>
git config --global user.name

# setting up your identity
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com

# settin global configuration for line endings
# On Windows, you simply pass true to the configuration (as shown below)
git config --global core.autocrlf true


# GIT ALIASES
#---------------------------------------
cd ~
notepad .gitconfig
# add the following to the .gitconfig file in your $HOME directory
[alias]
	co = checkout
	ci = commit
	st = status
	br = branch
	hist = log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
	hist1 = log --pretty=oneline
	type = cat-file -t
	dump = cat-file -p

# WORKING WITH GIT REPOSITORIES
#---------------------------------------

# Two ways:
# 1. clone existing initialized repo from server 
# 2. initialize repo locally and "remote add" to server


# CLONE EXISTING REPO FROM SERVER
#---------------------------------------
mkdir repos
cd repos
git clone https://abhijeetchopra@bitbucket.org/tamucinventors/basic-ke.git
git clone https://github.com/abhijeetchopra/Certifications.git
ls

# CLONE EXISTING REPO FROM SERVER
#---------------------------------------
# If you did not create a repo online first, then instead of cloning from web, 
# you can create local repo, initialize empty git repository with "init" and "remote add" it to your server

mkdir my_repo
git init
ls

# check status
git status

# track new files
git add file_name

# adding all files using wildcards
git add *

# removing added file 
git rm file_name

# removing added directory recursively
git rm -r directory_name

# commiting all files to the stating area / online server
git commit -m "Adding new files"

# browse changes in log - with different formatting options
git log
git log --pretty=oneline
git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short


# remote 
git remote add https://github.com/abhijeetchopra/new-repo/abc.git

# remote config in current directory 
git remote -v

# pushing, the -u parameter tell git to remember the parameters so next time we can write just : git push
git push -u origin master

# pulling
git pull origin master

# differences, HEAD tell git to check all the differences with the "latest commit"
git diff HEAD

# staged files are the files that we have told git that are ready to be committed.

# unstage, unstaging files from repo
git reset new-repo/readme.txt

# Files can be changed back to how they were at the last commit by using the 
# command: git checkout -- <target_file_tobe_undo-ed>
git checkout -- readme.txt


# END OF FILE
# --------------------------------------