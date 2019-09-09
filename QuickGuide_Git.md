# QuickGuide | Markdown

## Git Help

##### Git User Manual
`info git`

##### Git command Quick Reference
`git [command] -help`

##### Git command Manual Pages
```
git help [command]
git [command] --help
```

## Git Configuration

##### Checking configuration settings
`git config --list`

##### Checking configuration settings specific key value
```
git config --global <key>
git config --global user.name
```

##### Setting up your identity
```
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
```

##### Setting global configuration for line endings
On Windows, you simply pass true to the configuration (as shown below)  
`git config --global core.autocrlf true`


## Git Aliases
```
cd ~
notepad .gitconfig
```

##### Add the following to the .gitconfig file in your $HOME directory
```
[alias]
	co = checkout
	ci = commit
	st = status
	br = branch
	hist = log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
	hist1 = log --pretty=oneline
	type = cat-file -t
	dump = cat-file -p
```

## Working with Git Repositories
Two ways:
1. Clone existing initialized repo from server
2. Initialize repo locally and "remote add" to server

## Clone existing repo from server
```
mkdir repos
cd repos
git clone https://abhijeetchopra@bitbucket.org/tamucinventors/basic-ke.git
git clone https://github.com/abhijeetchopra/Certifications.git
ls
```

##### Bash command to clone all public repos from github account
```
curl -sS "https://api.github.com/users/abhijeetchopra/repos?per_page=1000" | grep -w clone_url | grep -o '[^"]\+://.\+.git' | xargs -L1 git clone
```

## Initialize repo locally and add to server
If you did not create a repo online first, then instead of cloning from web, you can create local repo, initialize empty git repository with "init" and "remote add" it to your server

Create new repository in GitHub without initializing with README, license or .gitignore files.

```
# navigate to your project directory
cd my_repo

# initialize repo
git init

# stage local files
git add .

# commit staged files to local repo
git commit -m "First commit"

# set the new remote
git remote add origin <GitHub remote repository URL>

# verify the new remote URL
git remote -v

# push local repo changes up the remote 'origin' repo
git push origin master

# check status
git status
```

## Workflow overview

##### Working Directory
> local files & changes

```
# initialize local repo  
git init

# undo initializing   
rm -rf .git

# create new file locally
touch <filename>

# modify file locally
<editor> <filename>

# save file locally
[within editor]

# delete newly created file locally
rm <filename>

# restore modified file in working dir to last local commit version
git checkout -- <filename>
```

##### Staging Area
> Tracked files & changes

```
# add file locally to staging area
git add <filename>

# remove file from staging area  
git reset HEAD <filename>
```

##### Repository
> Committed files & changes

```
# commit file locally    
git commit <filename> -m "message"

# commit all stages changes by skipping <filename>
git commit -m "message"

# commit message title and description
git commit <filename> -m "title" -m "description"

# opens a text editor to enter longer commit messages
git commit


# push changes to server
git push -u origin master

# pull from server       
git pull origin master
```

## Git commands

##### Check status
`git status`

##### Track new files - add files to staging area before committing
`git add file_name`

##### Add all files using wildcards
`git add *`

##### Remove added file
`git rm file_name`  

##### Remove added directory recursively
`git rm -r directory_name`  

##### Undo adding file/dir using reset
Remove file from staging area  
`git reset HEAD -- <file>`

Remove directory from staging area  
`git reset HEAD -- <directoryName>`

NOTE: Your modifications will be kept. When you run git status the file will once again show up as modified but not yet staged.

##### Committing all files to the stating area / online server
`git commit -m "Adding new files"`

##### git log | Browse changes in log - with different formatting options
```
git log
git log --pretty=oneline
git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
```

Commits on origin/master but not yet on master  
`git log master..origin/master`

Commits on master but not yet on origin/master  
`git log origin/master..master`

##### git show | Browse changes in files
`git show master..origin/master`

## Remote
Add remote in current directory/repo  
`git remote add https://github.com/abhijeetchopra/new-repo/abc.git`

View remote config in current directory/repo  
`git remote -v`

## Pushing
The -u parameter tells git to remember the parameters so next time we can write just : git push  
`git push -u origin master`

## Pulling
`git pull origin master`

## Differences
HEAD tells git to check all the differences with the "latest commit"  
`git diff HEAD`

## Stage
Staged files are the files that we have told git that are ready to be committed.
`git add <filename>`

## Unstage
Unstaging files from repo  
`git reset new-repo/readme.txt`

## Revert
Revert changes in file to how they were at the last commit  
`git checkout -- <filename>`

Revert repo to a previous commit and delete any changes made after the commit  
`git reset --hard <commit hash>`


## Fork
In GitHub website, browse to the repository you want to fork and click on "Fork".
After a few seconds, you should arrive at your 'personal' fork of the repository. Use the https/ssh links to clone it to your system locally.

`git clone <fork clone url>`

## Sync your fork

**origin** - your fork repo  
**upstream** - your fork's parent repo

```
# change current branch to master
git checkout master

# add ; only need this once
git remote add upstream <fork's parent repo clone link>

# verify remote links
git remote -v

# fetch changes from 'upstream' remote
git fetch upstream

# merge changes between fetched 'upstream' remote and local repo
git merge upstream/master

# push local repo changes to origin i.e. from your local fork repo to remote fork
git push
```

## Branch
##### Create New Branch
```
# navigate to your repo
cd my_repo

# create a new branch locally
git checkout -b new-branch

# pushing the branch to the remote
git push --set-upstream origin new-branch

# make changes to branch  
git add <filename>

```

##### View Branches
```
git branch       # local branches
git branch -v    # verbose
git branch -r    # remote branches
git branch -rv   # remote + verbose
git branch -a    # all

# show commit ancestry graph
git show-branch
git show-branch --current

git ls-remote [remote]
git remote show [remote]

```

##### Checkout Remote Branch
```
git checkout -t <name of remote>/branch_name
```

##### Delete Local Branch
```
# -d is alias for --delete
# only deletes branch if it has already been fully merged in its upstream branch
git branch -d branch_name

# -D is alias for --delete-force
# deletes branch irrespective of it's merged status
git branch -D branch_name
```
##### Delete Remote Branch
```
git push <remote_name> --delete <branch_name>
```

##### Branch Housekeeping
If a branch is deleted on server but still exists on your local repo, use prune to clean up your local repo. This command will remove branches from your local repo that don't exist on server anymore. This will not delete independent local branches that never existed on the server.   
```
git fetch --all --prune
```




## Pull Request

## GitHub

### GitHub with SSH

##### Generate SSH key pair
```
ssh-keygen -t rsa

id_rsa # to be configured on your local shell
id_rsa.pub # to be configured on GitHub
```

##### Windows
Install GitHub Desktop

#### Linux
Start ssh agent manually on every console session and add the identity key
```
eval `ssh-agent -s`               # starting the ssh agent
ssh-add /path/to/my_private_key   # adding private key to agent
ssh-add -l                        # list the identities on the agent
```

##### Add public key to GitHub account
In GitHub, go to profile > settings > SSH keys

##### After enabling 2FA, change your remote URLs from HTTPS to SSH
```
# verify remote URL
git remote -v

# set remote url
git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
```

# References
1. https://git-scm.com/docs/
2. https://gitimmersion.com
3. https://lab.github.com
4. https://www.linkedin.com/learning/github-essential-training/version-control-and-collaboration-with-github  




# Commit Messages

##### Rules to live by for commit messages:  

* Don’t end your commit message with a period.  
* Keep your commit messages to 50 characters or less.  
* Use active voice. E.g., "add" instead of "added" and "merge" instead of "merged".  
* Think of your commit as expressing intent to introduce a change.  


# GitHub Learning Lab

* https://youtu.be/PBI2Rz-ZOxU
* https://lab.github.com
* https://lab.github.com/courses


# GitHub Workflow

Master / Main / Production Branch  

* Security concerns  
* Automated testing  
* Code reviews  
* Issues / Projects  

## Security Concerns

### Branch Protections

    GitHub > repo > settings > branches > add branch protection rule

1. Require pull request reviews before merging
2. Require status checks to pass before merging
3. Require signed commits
4. Include administrators
5. Restrict who can push to matching branches

#####  1. Protecting the Master Branch

1. Block direct changes made to master
2. Only authorized users can bypass
3. Can be applied to any branch, not just master

##### 2. Pull Request Reviews

1. Require at least one approving review
2. Better accountability for reviewers
3. Better accountability for pull request authors

##### 3. Merge Protections

1. Restrict who can push merge
2. Comply with organization requirements
3. Can be authorized users or teams

##### 4. Status Checks on Commits

1. Automated control
2. Consistency with each commit
3. Reduces the amount of bugs pushed to production

## Continuous Integration (CI)

Automatically building and testing code

1. Adheres to your team's quality standards
2. Reduces context switching
3. Improves consistency for testing
4. Reduces bugs in production

## Continuous Delivery (CD)

1. Production ready with every commit
2. Being production ready dowsn't always translate to releasing new code every time
3. Gives you the flexibility to release as often as you want

## Continuous Deployment (CD++)
1. Takes continuous delivery one step further
2. Automated in the background, no human intervention




