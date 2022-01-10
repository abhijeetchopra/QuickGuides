# QuickGuide | Markdown

## Git Help

### Git User Manual

```basj
info git
```

### Git command Quick Reference

```bash
git [command] -help
```

### Git command Manual Pages

```bash
git help [command]
git [command] --help
```

## Git Configuration

### Listing git config with scope (global/local/unknown)

```bash
git config --list --show-origin --show-scope
````

### Checking configuration settings

```bash
git config --list
```

### Checking configuration settings specific key value

```bash
git config --global <key>
git config --global user.name
```

### Setting up your identity

```bash
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
```

### Setting global configuration for line endings

On Windows, you simply pass true to the configuration (as shown below)  

```bash
git config --global core.autocrlf true
```

## Git Aliases

```bash
# change directory to your home dir
cd ~

# open the .gitconfig file in a text editor
$EDITOR .gitconfig

# e.g. (WSL/Cygwin/Git Bash)
notepad .gitconfig
```

### Add the following to the .gitconfig file in your $HOME directory

```gitconfig
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

```bash
mkdir repos
cd repos
git clone https://abhijeetchopra@bitbucket.org/tamucinventors/basic-ke.git
git clone https://github.com/abhijeetchopra/Certifications.git
ls
```

### Bash command to clone all public repos from github account

```bash
curl -sS "https://api.github.com/users/abhijeetchopra/repos?per_page=1000" | grep -w clone_url | grep -o '[^"]\+://.\+.git' | xargs -L1 git clone
```

## Initialize repo locally and add to server

If you did not create a repo online first, then instead of cloning from web, you can create local repo, initialize empty git repository with "init" and "remote add" it to your server

Create new repository in GitHub without initializing with README, license or .gitignore files.

```bash
# navigate to your project directory
cd my_repo

# initialize repo
git init

# stage local files
git add .

# commit staged files to local repo
git commit -m "First commit"

# set the new remote
git remote add origin $INSERT_GITHUB_REMOTE_REPOSITORY_URL

# verify the new remote URL
git remote -v

# push local repo changes up the remote 'origin' repo
git push origin master

# check status
git status
```

## Workflow overview

### Working Directory

> local files & changes

```bash
# initialize local repo
git init

# undo initializing
rm -rf .git

# create new file locally
touch $INSERT_FILENAME

# modify file locally
$EDITOR $INSERT_FILENAME

# e.g. vim file01

# save file locally
[within editor]

# delete newly created file locally
rm $INSERT_FILENAME

# restore modified file in working dir to last local commit version
git checkout -- $INSERT_FILENAME
```

### Staging Area

> Tracked files & changes

```bash
# add file locally to staging area
git add $INSERT_FILENAME

# remove newly added file from staging area / untrack file
git rm --cached $INSERT_FILENAME

# remove newly added directory from staging area / untrack directory
git rm --cached -r $INSERT_DIRNAME

# revert changes to checked file from staging area
git reset HEAD $INSERT_FILENAME
```

### Repository

> Committed files & changes

```bash
# commit file locally
git commit $INSERT_FILENAME -m "message"

# commit all stages changes by skipping <filename>
git commit -m "message"

# commit message title and description
git commit $INSERT_FILENAME -m "title" -m "description"

# opens a text editor to enter longer commit messages
git commit

# push changes to server
git push -u origin master

# pull from server
git pull origin master
```

### Remote

> Revert pushed commit 

```bash
#NOTE: - only do this if no-one has already pulled your change
#      - after reset and forced push, some tags may still be pointing to removed commit

# this will re-checkout all the updates locally (so git status will list all updated files)
# git reset --soft <previous label or sha1>
git reset --soft HEAD~1

# git push -f <remote-name> <branch-name>
git push -f origin master
```

## Git commands

### Check status

```bash
git status
```

### Track new files - add files to staging area before committing

```bash
git add $INSERT_FILENAME
```

### Add all files using wildcards

```bash
git add *
```

### Remove added file

```bash
git rm $INSERT_FILENAME
```

### Remove added directory recursively

```bash
git rm -r $INSERT_DIRNAME
```

### Undo adding file/dir using reset

Remove file from staging area  

```bash
git reset HEAD -- $INSERT_FILENAME
```

Remove directory from staging area  

```bash
git reset HEAD -- $INSERT_DIRNAME
```

NOTE: Your modifications will be kept. When you run git status the file will once again show up as modified but not yet staged.

### git commit

Committing all files to the stating area / online server

```bash
git commit -m "Add new files"
```

Changing the latest Git commit message

```bash
git commit --amend -m "New commit message"
git push --force-with-lease repository-name branch-name

# example
git push --force-with-lease origin develop
```

### git log | Browse changes in log - with different formatting options

```bash
git log
git log --pretty=oneline
git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
git log --oneline --graph -n 5
```

Commits on origin/master but not yet on master  

```bash
git log master..origin/master
```

Commits on master but not yet on origin/master  

```bash
git log origin/master..master
```

### git show | Browse changes in files

```bash
git show master..origin/master
```

## Remote

Add remote in current directory/repo  

```bash
git remote add https://github.com/abhijeetchopra/new-repo/abc.git
```

View remote config in current directory/repo  

```bash
git remote -v
```

## Pushing

The -u parameter tells git to remember the parameters so next time we can write just : git push  

```bash
git push -u origin master
```

## Pulling

```bash
git pull origin master
```

## Differences

HEAD tells git to check all the differences with the "latest commit"  

```bash
git diff HEAD
```

Differences between "parent of HEAD" and "HEAD" commit

```bash
git diff HEAD~1 HEAD
```

## Stage

Staged files are the files that we have told git that are ready to be committed.

```bash
git add $INSERT_FILENAME
```

## Unstage

Unstaging files from repo  

```bash
git reset new-repo/readme.txt
```

## Revert

Revert changes in file to how they were at the last commit  

```bash
git checkout -- $INSERT_FILENAME
```

Revert repo to a previous commit and delete any changes made after the commit

```bash
git reset --hard $INSERT_COMMIT_HASH
```

Revert repo to a previous commit and keep any changes made after the commit

```bash
git reset --soft $INSERT_COMMIT_HASH
```

### Reword a git commit message

```bash
$ git log --oneline --graph
* 2cefbba (HEAD -> master) f2
* 826a7db f1
* f2c3ab7 m3
* 639535b m2
* 280fc64 m1
* 2a069bf initial commit
```

To change commit message of commit 826a7db i.e. 'f1' to say 'g1':

```bash
git rebase -i 826a7db
```

You will get this:

```bash
  1 pick 2cefbba f2
  2
  3 # Rebase 826a7db..2cefbba onto 826a7db (1 command)
  4 #
  5 # Commands:
...
```

Replace 'pick' with 'reword', then save and exit:

```bash
  1 reword 2cefbba f2
  2
  3 # Rebase 826a7db..2cefbba onto 826a7db (1 command)
  4 #
  5 # Commands:
...
```

You will be prompted to put in a new commit message:

```bash
  1 f2
  2
  3 # Please enter the commit message for your changes. Lines starting
  4 # with '#' will be ignored, and an empty message aborts the commit.
  5 #
  6 # Date:      Fri Apr 17 22:44:56 2020 -0400
  7 #
  8 # interactive rebase in progress; onto 826a7db
  9 # Last command done (1 command done):
 10 #    reword 2cefbba f2
 11 # No commands remaining.
 12 # You are currently editing a commit while rebasing branch 'master' on      '826a7db'.
 13 #
 14 # Changes to be committed:
 15 #       modified:   README.md
 16 #
```

Reword the commit message and then save and exit:

```bash
  1 g2
  2
  3 # Please enter the commit message for your changes. Lines starting
  4 # with '#' will be ignored, and an empty message aborts the commit.
  5 #
  6 # Date:      Fri Apr 17 22:44:56 2020 -0400
  7 #
  8 # interactive rebase in progress; onto 826a7db
  9 # Last command done (1 command done):
 10 #    reword 2cefbba f2
 11 # No commands remaining.
 12 # You are currently editing a commit while rebasing branch 'master' on     '826a7db'.
 13 #
 14 # Changes to be committed:
 15 #       modified:   README.md
 16 #
```

Message on exit:

```bash
$ git rebase -i 826a7db
[detached HEAD 44a7180] g2
 Date: Fri Apr 17 22:44:56 2020 -0400
 1 file changed, 1 insertion(+)
Successfully rebased and updated refs/heads/master.
```

Check git log and you can see the reworded commit:

```bash
$ git log --oneline --graph
* 44a7180 (HEAD -> master) g2
* 826a7db f1
* f2c3ab7 m3
* 639535b m2
* 280fc64 m1
* 2a069bf initial commit
```

## Tagging

### List tags

```bash
# list tags
git tag

# list tags like
git tag -l "v2.*"

# list tags with message
git tag -n
```

### Create tags

Two types of tags

1. Lightweight
2. Annotated (recommend)

#### Create lightweight tag

Lightweight tags are created with the absense of `-a, -s or -m` options

```bash
git tag v1.4-lw

```

#### Create annotated tag

```bash
git tag -a v1.4


git tag -a v1.4 -m "version 1.4"

```

### Tagging old commits

```bash
git tag -a v1.2 <commit-sha>
```

### Pushing tags to remote

By default, tags are not pushed to remote on `git push`.

```bash
# pushing single tag
git push origin v1.4

# pushing multiple tags
git push --tags
```

### Checking out tags

```bash
git checkout v1.4
```

### Deleting tags

```bash
git tag -d  v1.4
```

### Distinguish lightweight vs annotaged tags

Run below command. Lines marked with `tag` indicate lightweight tag. Lines marked with `commit`indicate annotated tag.

```bash
git for-each-ref refs/tags

0774b0d88c9a751d05abf621bdafc272f50c2306 commit refs/tags/v1.0
732c5e2da1b41282ee9d51897dedf3483a6331b2 tag    refs/tags/v1.1
fd3cf147ac6b0bb9da13ae2fb2b73122b919a036 commit refs/tags/v1.2
```

## Fork

In GitHub website, browse to the repository you want to fork and click on "Fork".
After a few seconds, you should arrive at your 'personal' fork of the repository. Use the https/ssh links to clone it to your system locally.

```bash
git clone $INSERT_FORK_CLONE_URL
```

## Sync your fork

**origin** - your fork repo  
**upstream** - your fork's parent repo

```bash
# change current branch to master
git checkout master

# add ; only need this once
# $CLONE_LINK_TO_FORKS_PARENT = <fork's parent repo clone URL>>
git remote add upstream  $INSERT_UPSTREAM_CLONE_URL

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

### Create New Branch

```bash
# navigate to your repo
cd my_repo

# create a new branch locally
git checkout -b new-branch

# pushing the branch to the remote
git push --set-upstream origin new-branch

# make changes to branch  
git add <filename>

```

### View Branches

```bash
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

### Checkout Remote Branch

```bash
git checkout -t <name of remote>/branch_name
```

### Delete Local Branch

```bash
# -d is alias for --delete
# only deletes branch if it has already been fully merged in its upstream branch
git branch -d branch_name

# -D is alias for --delete-force
# deletes branch irrespective of it's merged status
git branch -D branch_name
```

### Delete Remote Branch

```bash
git push <remote_name> --delete <branch_name>
```

### Branch Housekeeping

If a branch is deleted on server but still exists on your local repo, use prune to clean up your local repo. This command will remove any remote tracking references that no longer exist on the remote. This will not delete independent local branches that never existed on the server, for which, use branch command that follows the command below.

```bash
git fetch --all --prune
```

```bash
git branch -d '$INSERT-NAME-OF-BRANCH-TO-BE-DELTED'
```

## Pull Request

## GitHub

### GitHub with SSH

#### Generate SSH key pair

```bash
ssh-keygen -t rsa

id_rsa # to be configured on your local shell
id_rsa.pub # to be configured on GitHub
```

#### Windows

Install GitHub Desktop

#### Linux

Start ssh agent manually on every console session and add the identity key

```bash
eval `ssh-agent -s`               # starting the ssh agent
ssh-add /path/to/my_private_key   # adding private key to agent
ssh-add -l                        # list the identities on the agent
```

##### Add public key to GitHub account

In GitHub, go to profile > settings > SSH keys

##### After enabling 2FA, change your remote URLs from HTTPS to SSH

```bash
# verify remote URL
git remote -v

# set remote url
git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
```

## References

1. https://git-scm.com/docs/
2. https://gitimmersion.com
3. https://lab.github.com
4. https://www.linkedin.com/learning/github-essential-training/version-control-and-collaboration-with-github
5. https://help.github.com/en/github/committing-changes-to-your-project/changing-a-commit-message
6. https://stackoverflow.com/a/31937298

## Commit Messages

### Rules to live by for commit messages

* Don’t end your commit message with a period.  
* Keep your commit messages to 50 characters or less.  
* Use active voice. E.g., "add" instead of "added" and "merge" instead of "merged".  
* Think of your commit as expressing intent to introduce a change.  

## GitHub Learning Lab

* https://youtu.be/PBI2Rz-ZOxU
* https://lab.github.com
* https://lab.github.com/courses

## GitHub Workflow

Master / Main / Production Branch  

* Security concerns  
* Automated testing  
* Code reviews  
* Issues / Projects  

### Security Concerns

#### Branch Protections

GitHub > repo > settings > branches > add branch protection rule

1. Require pull request reviews before merging
2. Require status checks to pass before merging
3. Require signed commits
4. Include administrators
5. Restrict who can push to matching branches

##### 1. Protecting the Master Branch

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
