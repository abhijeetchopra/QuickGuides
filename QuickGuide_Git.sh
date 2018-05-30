# --------------------------------------
# Auth: Abhijeet Chopra
# Date: Mon Oct 16, 2017
# Desc: Quick Git Guide
# --------------------------------------

# GIT COMMANDS
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

# browse changes log
git log

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