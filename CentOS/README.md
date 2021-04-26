# QuickGuice | CentOS

```bash
LINUX - 1991 by Linus Torvalds

Major Distros - Arch, Debian (Ubuntu), Red Hat (CentOS, Fedora, RHEL), Slackware

Unix Philosophy : Do one thing. Do it well.


################################################################################
# INSTALLATION
################################################################################

# Linux Installation on Virtual Machine
#---------------------------------------
# Installing guest OS: "CentOS 7" on host OS: "Windows 10" over Oracle VM VirtualBox
1. Start VirtualBox > New > Name: "CentOS 7", Type: "Linux", Version: "Red Hat(64-bit)" > Next > Memory Size: "2048 MB" > Hard Disk: "Virtual" > Type: "VDI" > Allocation: "Dynamic" > Next

# Downloading Installer Disk Image
2. Go to http://centos.org > Download Now > DVD ISO

# Cloning VM to preserve fresh state
3. Oracle VM VirtualBox > CentOS 7 > Machine > Clone > Name: "CentOS 7 DVD"

# Initial setup configuration
4. Oracle VM VirtualBox > CentOS 7 DVD > Start > Select Startup disk: select downloaded ISO file path > Language: "English" > Continue > Date and Time > Base Environment: "Server with GUI"

5. Installation Destination: Other Storage Options > I will configure partitioning > Automatically create partition > Begin Installation

# Creating Users - First user has to be made admin
6.

# Creating Base Installation Snapshot
7.

# Updating system software
8.1 Applications > System tools > Application Installer >
OR
8.2 Applications > System tools > Software Update
OR
8.3 Applications > Favorites > Terminal >
sudo yum update

# Installing development tools for seamless integration with host OS
9. Applications > Favourites > Terminal
sudo yum groupinstall "Development Tools"

# Enabling WiFi Autoconnect
10. Applications > System tools > Settings > Network > Wired > Click the cog wheel button > Check "Connect Automatically"

# Extension Themes
11. Applications > Favourites > Terminal
sudo yum install gnome-shell-browser-plugin
# --------------------------------------



################################################################################
# BASIC LINUX SHELL COMMANDS
################################################################################

# Basic Linux Shell Command Syntax
# --------------------------------------
# Command Syntax: <command> <options> <arguments>


# Terminal Shortcuts
# --------------------------------------
Ctrl + A                          : Move to beginning of line
Ctrl + E                          : Move to end of line
Ctrl + Shift + Upward Arrow Key   : Scroll Up
Ctrl + Shift + Downward Arrow key : Scroll Down
Ctrk + Left Arrow Key             : One Word Left
Ctrl + Right Arrow Key            : One Word Right


# man - manual to get help on commands
# --------------------------------------
man <command>

# example:
man grep
Output: Displays manual pages for "grep" command


# ls - List files
# --------------------------------------
ls -lh /usr/bin
command : "ls"
options : "-lh" where l is for list, h is for human-readable format
arguments: "/usr/bin" which is the file path

ls -l    # list
   -a    # list all files
   -h    # human readable format
   -i    # inode
   -lah  # all three options at once

# options with one dash can be combined e.g. "$ls -l -a -h" = "$ls -lah"
# options with two dashes cannot be combined

# command with very less execution time when listing millions of files
/bin/ls -U -1 --color=never


# cat - print file contents / concatenate
# --------------------------------------
cat <filename>
cat /var/spool/mail/<username>
cat file_01 file_02 file_03


# cd - Change current directory
# --------------------------------------
cd ~ # changes current directory to home directory
cd .. # go to parent directory
cd /  # go to root directory


# home - tilde (~) character denotes home folder
# --------------------------------------
~/ means home directory
./ means current directory
../ means parent directory


# mkdir - make directory / create folder
# --------------------------------------
mkdir <dir_name>
mkdir {dir_1, dir_2, dir_3} # creates multiple directories in one command
mkdir dir_{1..100} # creates 100 directories using bracket expansion
mkdir -p dir{1..4}/parent{1..4}/child{one,two,three}


# touch - create new empty file / update timestamp of existing file
# --------------------------------------
touch <filename>
touch demo
touch demo.txt


# editing files - vi/nano/gedit/emacs
# --------------------------------------
vi <filename>
nano <filename>
gedit <filename>
emacs <filename>

# vi - two modes: normal (default) & insert (press i)
normal -> insert : press 'i'
insert -> normal : press 'Esc'

normal:
:   # to type a command
i   # to switch to insert mode
:w  # save / write file
:w <filename> # save as
:w! # force write / save
:q  #quit
:q! # force quit
:wq # save and quit (combo)
:x  # save and quit

vi <filename> # will create the file and open it, if file doesn't already exists


# cp - copy files
# --------------------------------------
cp <filename> <destination>

cp -a   #arhive     -
   -b   #backup     -
   -n   #no clobber - prevents overwriting existing files
   -u   #update     - only moves if newer version


# mv - move / rename / both
# --------------------------------------
mv <filename> <destination>
mv ~/folder_01/file_01 ~/folder_02/file_01 # move
mv ~/folder_01/file_01 ~/folder_01/file_02 # rename
mv ~/folder_01/file_01 ~/folder_02/file_02 # move + rename


# rm - removing/deleting files
# --------------------------------------
rm <filename> # warning: linux does not have a recycle bin

# delete directory / recursive
rm -r <directory_name>

# force delete file - deletes write protected files
rm -f <filename>

# force delete directory - deletes write protected dir/files
rm -rf <directory_name>

# delete empty dir
rmdir <directory_name>


# grep - searches for text in file/input
# --------------------------------------
grep -i "root" /etc/passwd
# command : "grep" used for searching text
options : "-i" for ignore case sensitive search
arguments : "/etc/passwd" which is the file path

grep "the" poems
grep -n "the" poems    # prints the line numbers
     -in "the" poems   # ignore case & print line numbers
     -v "the" poems    # prints line without "the"
     -E "[hijk]" poems # extended/regex - either of h,i,j,k
     -E "\w{6,}" poems # 6 or more of word character

grep "word1" <filename> | grep "word2" # to grep for 2 words existing on the same line


# awk - extract/modify file/stream
# --------------------------------------
awk '{print $2}' simple_data.txt # prints 2nd column of space/tab separated values

awk '{print $2 "\t" $1 }' simple_data.txt # <col2> <tab> <col1>

awk '{print $2}' simple_data.txt | sort -n # -n for numeric sort

awk '{for(i=6;i<=NF;++i)printf $i""FS; print ""}' auth.log # prints all columns after 5

awk '{$1=$2=$3=$4=$5=""; print $0}' auth.log



# sed
# --------------------------------------
# NOTE: GNU sed implementation differs from BSD sed
# MacOS users BSD by default
# Use homebrew to install gnu implementation on MacOS

# replace Orange with Red and print result in console
sed s/Orange/Red/ simple_data.txt # replaces Orange with Red

# replace Orange with Red and save output in the same input file
sed -i s/Orange/Red/ simple_data.txt # replaces Orange with Red

# insert Orange in beginning of the file
sed -i "1s/^/Orange\n/" simple_data.txt


# insert Red at the end of the file
sed -i -e "\$aRed" simple_data.txt

# sort - sorts contents of a file/input
# --------------------------------------
sort -u /etc/passwd
command : "sort"
options : "-u"
arguments : "/etc/passwd" which is the file path

sort -k2 simple_data.txt  # sorts 2nd column
sort -k2n simple_data.txt # sorts 2nd column numerically
sort -u simple_data.txt   # unique results only

rev simple_data.txt # prints file reverse / flip vertically
tac simple_data.txt # prints file backwards / flip horizontally

cat simple_data.txt | tr [:lower:][:upper:] #

cat file.txt | sort | uniq # unique rows only



# standard input/output/error - stdin/stdout/stderr
# --------------------------------------
ls -lah 0> filelist.txt  # 0 : writes output to console
ls -lah 1> filelist.txt  # 1 : writes output to file               - stdout
ls -lah 2> notreal       # 2 : writes errors to file (overwrites)  - stderr
ls -lah 2>> notreal      # 2 : writes errors to file (appends >>)

# Note: no spaces between 0>, 1>, 2>, 2>> etc

# Example
mkdir demo
echo "first file" > file_01
echo "second file" > file_02
# we are not making file_03 so next command will print error
cat file_01 file_02 file_03 1> output.log 2>&1
# 1 is output(stdout), 2 is error(stderr)
# 1> output.log  - means stdout redirects/goes to output.log
# 2>&1           - means stderr redirects/goes to &1 (&1 is variable)
# &1 stores what 1 is defined, which we prev. def. as output.log
# so effectively, both stdout and stderr going to output.log

source: https://unix.stackexchange.com/a/37662/291648

# 1. <<< denotes a string
$ cat <<< 'hi there'
hi there

# 2. << denotes a document
$ cat << EOF
> hi there
> how are you
>
EOF
hi there
how are you

# 3. < passes the contents of a file to a command's standard input
$ cat < ./readme.txt
this is some text in the readme.txt file

# stat - print file status
# --------------------------------------
stat <filename>


# wildcards
# --------------------------------------
 * - any number of characters
 ? - any one character


# find - finds files
# --------------------------------------
find . -name "poe*" # find all files in current dir with filename beginning "poe"
find <scope> <option - find by name> <argument>

# find in current directory, type directory, name starts with grid (/ is escaping here)
# maximum three directories down
find . -type d -name grid\* -maxdepth 3

# file - print file type
# --------------------------------------
file <filename>


# file globbing / pattern matching
# --------------------------------------
file*.txt          -  file.txt, file1.txt, file01.txt, file_001.txt
file??.txt         -  filexx.txt, fileyy.txt, file01.txt, fileAA.txt
file[1-9]          -  1 of set 1 to 9
file[a-z]          -  1 of set a to z
file[123ABC]       -  1 of set 1,2,3,A,B,C
file[!0-9]         -  not of set 1 to 9
file[:<class>:]    -  [:upper:], [:lower:], [:alpha:], [:alnum:], [:digit:], [:space:]
file[0-9].txt      =  file [[:digit:]].txt


# brace expansion
# --------------------------------------
ls {*.jpg, *.gif, *.png}


# shopt - shell options
# --------------------------------------
shopt -s extglob # turns on extended globs

? - zero or one occurrence
* - zero or more occurrence
+ - one or more occurrence

file?(abc).txt     -  file.txt, fileabc.txt.
file+(abc).txt     -  fileabc.txt, fileabcabc.txt, fileabcabcabc.txt, ...
file+(*.jpg|*.gif) -  file*.jpg or file*.gif
file*(abc).txt     -  file.txt, fileabc.txt, fileabcabc.txt, ...

file[cd].txt       -  filec.txt, filed.txt # pattern matching
file{c,d}.txt      -  filec.txt, filed.txt # brace expansion

file?.txt


# Create User / Group
# --------------------------------------
sudo useradd testuser    # creates user
sudo passwd testuser     # sets user password

# adduser is more friendly version of useradd
# -u               - userid
# -G               - group memberships
# -s               - default shell
# -d               - home directory
sudo adduser testuser --disabled-password -u 790 -G testgroup -s /bin/bash -d /home/testuser

sudo groupadd testgroup  # creates group

# create group with specific groupid
sudo groupadd -g 790 testgroup

# SUID / GUID
# --------------------------------------
SUID - elevates privileges to the file owner when executed
SGID - elevates privileges to the file group when executed

# Passwords
# --------------------------------------

# get entry
getent passwd
getent group

# /etc/passwd
cat /etc/passwd

/etc/passwd contains one line for each user account, with seven fields
delimited by colons (“:”). These fields are:

abhijeetchopra:x:1000:1001:Abhijeet Chopra:/home/abhijeetchopra:/bin/bash

1.  abhijeetchopra        - login name
2.  x                     - optional encrypted password
3.  1000                  - numerical user ID
4.  1001                  - numerical group ID
5.  Abhijeet Chopra       - user name or comment field
6.  /home/abhijeetchopra  - user home directory
7.  /bin/bash             - optional user command interpreter

source: https://askubuntu.com/a/725122


# passwd - change password
# --------------------------------------
passwd

passwd <username> # to change password of another user as root
sudo passwd <username>


# Logs
# --------------------------------------

# system log viewer
gnome-system-log


# Secure Log
# --------------------------------------

# successful ssh login attempts
cat /var/log/secure | grep 'Accepted' | awk '{print $1 " " $2 " " $3 " User: " $9 " " }'

# successful ssh login attempts with IP
cat /var/log/secure | sort | grep 'Accepted' | awk '{print $1 " " $2 " " $3 " User: " $9 " IP: " $11 }'

# successful ssh login attempts from sudo users
cat /var/log/secure | grep 'session opened for user root' | awk '{print $1 " " $2 " " $3 " Sudo User: " $13 " " }'

# login attempts from non-existing and unauthorized user accounts
cat /var/log/secure | grep 'Invalid user'

# ssh login attempts by authorized ssh accounts with failed password
cat /var/log/secure | grep -v invalid | grep 'Failed password'


################################################################################
# FILE PERMISSIONS
################################################################################


# File Permissions
# --------------------------------------

d : directory
- : regular file
l : symbolic link
c : character file
b : block device file
s : socket file
p : named pipe

.................... d: directory | -: file | s: sym link
| .................. r: user has read permission     | -: no permission
| | ................ w: user has write permission    | -: no permission
| | | .............. x: user has execute permission  | -: no permission
| | | | ............ r: group has read permission    | -: no permission
| | | | | .......... w: group has write permission   | -: no permission
| | | | | | ........ x: group has execute permission | -: no permission
| | | | | | | ...... r: other has read permission    | -: no permission
| | | | | | | | .... w: other has write permission   | -: no permission
| | | | | | | | | .. x: other has execute permission | -: no permission
| | | | | | | | | |
d r w x r w x r w x


ls -ali

933442 -rwxrw-r--    10    root   root 2048    Jan 13 07:11 afile.exe

+--------------+------------------+-----------------+-------+-------+------+-------+-----+-------+-----------+
| index number | file permissions | number of links | owner | group | size | month | day | time  | filename  |
+--------------+------------------+-----------------+-------+-------+------+-------+-----+-------+-----------+
|       933442 | -rwxrw-r--       |              10 | root  | root  | 2048 | Jan   |  13 | 07:11 | afile.exe |
+--------------+------------------+-----------------+-------+-------+------+-------+-----+-------+-----------+



# chmod - Change mode / File permissions
# --------------------------------------
touch testfile.txt # creates a blank textfile, default permissions are 666

# Two ways to change permissions: 1. Octal and 2. Symbolic

# Octal: user,group,other(XXX) get read,write,modify (5+1+1 = 7)
chmod 777 testfile.txt

# Symbolic: user,group,other(u,g,o) get read,write,modify (all = +a)
chmod u=a,g=a,o=a testfile.txt



# Octal
# --------------------------------------

#Syntax: chmod [who][+,-,=] [permissions] [filename]

#Octal - three digit between 000 - 777

#Example 704
First digit  7 - user
Second digit 0 - group
Third digit  4 - others

---------------------------------------------
read    (4) | 4 | 4 | 4 | 4 | 0 | 0 | 0 | 0 |
write   (2) | 2 | 2 | 0 | 0 | 2 | 1 | 0 | 0 |
execute (1) | 1 | 0 | 1 | 0 | 1 | 0 | 1 | 0 |
---------------------------------------------
total   (7) | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
---------------------------------------------

One digit represents either user or group or others
Put them all together to get three digits like 704

First digit  7 - user : 4+2+1 : read + write + execute
Second digit 0 - group : 0 : no permission
Third digit  4 - others : read

#Example 777
First digit  7 - user : 4+2+1 : read + write + execute
Second digit 0 - group : 4+2+1 : read + write + execute
Third digit  4 - others : 4+2+1 : r + w + x

# Symbolic
# --------------------------------------


u : user
g : group
o : others

+ : add permission to existing permissions
- : remove permission from existing permissions
= : replace existing permission

r : read
w : write
x : execute



# chown - Change User Ownership
# --------------------------------------
sudo chown root test.sh
sudo chown <user> <filename>


# chgrp - Change Group Ownership
# --------------------------------------
sudo chgrp <wheel> test.sh
sudo chgrp <group> <filename>


# ACL - Access Control List
# --------------------------------------

setfacl -m user:root:rwx aclfile.txt

setfacl -m mask: :rx aclfile.txt

getfacl -t aclfile.txt


# Extended User Attributes
# --------------------------------------

# chattr - change attribute
sudo chattr +i <filename> # adds i(immutable) attribute to file

# lsattr - list attribute
lsattr <filename>


# Pipes ( | )
# --------------------------------------
echo "hello world" | wc # prints the word-count of string "hello"
Output: 1  2  12  # Lines, Words, Characters

cat poems.txt | cat -n | tail -4
# print file | print line no.s | print last 4 - 97,98,99,100

cat poems.txt | tail -4 | cat -4
# print file | print last 4 | print line no.s - 1,2,3,4

less poem.txt
↑↓    : scroll up/down
space : scroll down one screen
f/b   : forward/backward
h     : help
q     : quit

# &
# --------------------------------------
If a command is terminated by the control operator &, the shell executes the command in the background in a subshell. The shell does not wait for the command to finish, and the return status is 0.
E.g. on Windows Linux Subsystem/Git bash Terminal: $ nano <filename>



# Downloading files from URL using shell command
# --------------------------------------
wget <url> # file will be saved to current directory

# More uses: https://www.hostinger.com/tutorials/wget-command-examples/



# Compressing files
# --------------------------------------
# TAR - Tape Arcive Files

# File types:
1. .tar
2. .tar.gz
3. .tgz
4. .tar.bz2

tar -cvf backup.tar <filename/directory name>
    -c # compress / create
    -v # verbose / print warnings/messages
    -f # file


tar -caf backup.tar <filename/directory name>
    -c # compress / create
    -a # automatically detect compression format from file ext
    -f # file


# Extracting Files
# --------------------------------------

tar -xvf backup.tar
      -x # extract
      -v # verbose / print warnings/messages
      -f # file


# Extracting tar.gz

git clone https://github.com/abhijeetchopra/Assembly/blob/master/Masm615_Download.zip
tar -xvzf log.tar.gz
# x: extract - c for compress
# v: vebose - will show error/sucess messages
# z: select "gzip" compression option; use - a for "auto-detect" with file extension
# f: file


# Extracting in another directory
tar -xvf backup.tar

# Example
touch file_{1..10}             # creating files
tar -cvf backup.tar file_0*    # creating tar - compressing files
rm file_0*                     # removing files
tar -xvf backup.tar            # extracting tar - decompressing files
tar -xvf backup.tar -C unpack/ # extracting tar in another dir


# Installing software/packages
# --------------------------------------
sudo dnf install nano # dnf is the package manager in Fedora (dnf replaced yum)

sudo yum install nano # yum is package manager in CentOS (CentOS didn't port dnf yet)

sudo apt-get install nano # apt-get is package manager in Ubuntu



# OS version
# --------------------------------------
cat /etc/*-release


# Memory
# --------------------------------------
free -h


# CPU
# --------------------------------------
cat /proc/cpuinfo


# HDD
# --------------------------------------
df -h # disk-free space

sudo du / -hd1 # disk usage

du -sh

du -sh *


################################################################################
# PACKAGE MANAGEMENT
################################################################################


# RPM vs YUM
# --------------------------------------
   RPM                                YUM
1. Install download packages       1. Install from repos
2. Manage installed packages       2. Search installable packages
3. Query package database


# RPM Querryiing - Database/Package/File
# --------------------------------------
rpm -qa      # q:querry, a:all
rpm -qi bash # q:querry, i:information
rpm -qa Group="System Environment/Shells" # pkgs installed in this group
rpm -qa --last
rpm -ql yum  # q:query, l:list
rpm -qd yum  # q:query, d:documentation
rpm -qf      # q:query, f:file  - to know where file came from
rpm -q --provides bash
rpm -q --requires bash
rpm -q --changelog bash # view changelog
rpm -qa --queryformat "%{NAME} %{VERSION}\n"
rpm -qa --queryformat "%-30{NAME} %-10{VERSION}\n"   # left align
rpm -qa --queryformat "%-30{NAME} %10{VERSION}\n"    # right align ***fav***

rpm -q --queryformat "%{FILENAMES}\n" bash # only returns first entry of list FILENAMES
rpm -q --queryformat "[%{FILENAMES}]" bash # shows for complete array
rpm -q --queryformat "[%{FILENAMES} %{FILESIZES} \n]" bash
rpm -q --queryformat "[%{NAME} ${INSTALLTIME:date}\n]" bash
rpm -q --queryformat "[%{FILEMODES:perms} ${FILENAMES}\n]" bash # perms: permissions

man rpm # for more info


# Downloading pkgs with RPM
# --------------------------------------
mkdir ~/tmp/packages

sudo yum install -y yum-plugin-downloadonly
# > now we can use --downloadonly option while installing with yum

sudo yum install --downloadonly --downloaddir = ~/tmp/packages http  # http pkg


# Installin Downloaded pkgs with RPM
# --------------------------------------
sudo rpm -ivh <package file name> # i:install, v:verbose, h:hash

#Note: sometimes failed dependencies are not installed. Google the error.

rpm -qlp <package file name> # q:query, l:list, p:package


# Uninstalling/removing programs with RPM
# --------------------------------------
rpm -ev <package_name>
rpm -ev httpd


# Upgrading programs with RPM
# --------------------------------------
sudo rpm -Uvh <package_name>

sudo rpm -Uvh --nodeps <package_name> # ignoring dependency issue and upgrade

sudo rpm -ivh --force <package_name> # overwrites package / force install

#Note: sometimes dependency deadlock occurs so force install / upgrade is required


# Validating Package Integrity
# --------------------------------------
cd ~tmp/packages
ls
rpm -k --nosignature <packagename>  # we get sha1, md5 OK
rpm -k <packagename> # we get rsa sha1 md5 pgp OK; check both md5 checksum & gpg signature
rpm -q gpg_publickey # we get <public_key>; copy this!
rpm -qi <public_key> # paste here!



# YUM - Yellowdog Update Manager
# --------------------------------------






# Check installed packages
# --------------------------------------
dnf history # Fedora


# Update CentOS
# --------------------------------------
su -c 'yum update'



# Resetting Root Password using rd.break
# --------------------------------------
1. $shutdown -r now
2. On GRUB menu, pause booting by using either of the up or down arrow keys
3. Select default option [usually first] and press the 'E' key for editing
4. Go to line that has "Linux16..." > go to the end of the line using the 'End' key > insert a single space and write "rd.break" without the quotes > Press Ctrl and X
5. A prompt appears with the # instead of $. Type the following commands at the # prompt:
# mount
# mount -o remount,rw /sysroot/
# chroot /sysroot/
# passwd
# touch /.autorelabel
# exit
# exit
# --------------------------------------



# ps - report snapshot of processes currently active in shell
# --------------------------------------

# print processes in current shell
ps

# ps command with arguments
ps -aux
   -a # print "all" processes
   -u #
   -x # print processes owned by user "x"
   -f # full format
   -F # extra full format

# NOTE: UNIX vs BDS syntax
# "$ps -aux" is distinct from "$ps aux" without the dash "-" sign

# output
# PID - process ID
# CMD - executable name
# TTY - terminal associated with process
# TIME - cumulated CPU time
# STAT - process state
# COMMAND - command arguments

# print every process on the system using standard syntax
ps -e
ps -ef
ps -eF
ps -ely

# print every process on the system using BSD syntax
ps ax
ps aux

# print a process tree
ps -ejH
ps axjf
ps -e --forest

# print a process tree for given process
ps -ef --forest | grep -v grep | grep rsync

# print info about threads
ps -eLf
ps axms

# print security info
ps -eo euser, ruser, suser, fuser, f, comm, label
ps axZ
ps -eM

# print every process with a user-defined format
ps -eo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:14,comm
ps axo stat,euid,ruid,tty,tpgid,sess,pgrp,ppid,pid,pcpu,comm
ps -Ao pid,tt,user,fname,tmout,f,wchan

# print only process IDs of syslogd
ps -C syslogd -o pid=

# print only the name of PID 42
ps -q 42 -o comm=

# print processes sorted by memory usage
ps -o pid,user,%mem,command ax | sort -b -k3 -r

# print process id of particular process
pidof <process_name>
pgrep <process_name>

pidof crond # prints process id of crond daemon
pgrep crond # prints process id of crond daemon

# monitor process in real-time
top # download tool
# --------------------------------------



# jobs - jobs currently active in shell
# --------------------------------------
help jobs

vi & # vi does in background

jobs    # prints job status
jobs -l # prints PIDs with jobs
jobs -p # prints PIDs
jobs %  # resume first job
jobs %2 # resume second job

jobs -STOP %<JOBID> # stop job with job id <JOBID>



# creating 1GB dummy file
# --------------------------------------
dd if=/dev/urandom of=sample.txt bs=1MB count=1024



# transferring files from dir A to B
# --------------------------------------
# scp is secured and encrypted but slow
# rsync is fast and has optimization features

# scp
#   1. copy from A to B if logged into A
scp /source username@b:/destination

#   2. copy from A to B if logged into B
scp username@a:/source /destination

# rsync
rsync -uav srchost:<source_path> <destination_path>

mkdir ~/A                      # creating empty dir
touch ~/A/file_0{1-9}          # populating dir A with dummy files
mkdir ~/B                      # creating empty dir B
rsync -av srchost:~/A/ ~/B/ # transfering files from A to B

# -a: archive mode - no hardlinks, don't preserve ACLs, cross filesystem
# -v: verbose
# -u: update - replaces files only if different filename/size/time
# -z: compression

touch ~/A/file_{11-99}         # creating more dummy files
touch ~/A/file_100             #
rsync -uav ~/A/ ~/B/ # transfering only new data


# resetting root password using rd.break
# --------------------------------------
1. $shutdown -r now
2. On GRUB menu, pause by using arrow keys
3. Select default option [top] and press 'e' for edit
4. Go to line that has 'linux16...', go to end using 'End' key
5. After space write 'rd.break' , ctrl + x
6. # mount
7. # mount -o remount, rw /sysroot/
8. # chroot /sysroot/
9. # passwd
10. # touch /.autorelabel
11. # exit
12. # exit


# Crontab
# --------------------------------------
crontab -l # list crontab
crontab -e # edit crontab
crontab -u <username> -l # list crontab for user <username>
crontab -u root -l


# vgdisplay
# fdisk


# Shortcuts - GUI
# --------------------------------------
0. Super key is Windows key / Command key
1. Super + A : Applications
2. Super + M : Message Tray
3. Super + L : Lock Screen
4. Double tab after a letter : possible commands
5. Ctrl + Alt + Tab : Terminal


# Shortcuts - CLI / Terminal
# --------------------------------------
1. Ctrl + A : Move to beginning of line
2. Ctrl + E : Move to end of line
3. Ctrl + Shift + Up : Scroll Up
4. Ctrl + Shift + Down : Scroll Down
5. Ctrl + Left Arrow Key : One Word Left
6. Ctrl + Right Arrow Key : One Word Right


# compare files line by line
# --------------------------------------
diff <filename> <filename>
     -s: report identical files
     -y: side by side output in two columns

vimdiff <filename> <filename>

# Working between Windows and Linux
# --------------------------------------
1. Line Endings are different in different Operating Systems
Use dos2unix and unix2dos utilities for file conversions


# Networking
# --------------------------------------
ping google.com


# test open port on remote host

## using nmap
nmap -A <ip> -p <port>
nmap -A 52.43.73.53/32 -p 443

## using nc
nc -zv <ip> <port>
nc -zv 52.43.73.53 443

# disable audio bell
# set in bashrc
set bell-style visual

# useful history datetimestamp
# set in bashrc at /home/username for user and/or at /etc/bashrc for root
export HISTTIMEFORMAT="%Y-%m-%d_%H:%M:%S "

# send mail using mailx email client
echo "This is a test message." | mailx -r sender@email.com -s "Email subject" recipient@email.com


# useful commands
# --------------------------------------

# cut from character 59 to end of line
for i in `ls -lah | grep "Feb  5" cut -c 59-`; do echo $i; done;

# read file line by line with whitespace in line
cat filename | while read; do echo "$REPLY"; done


# References / Further Reading
# --------------------------------------
http://tldp.org/
https://linux.die.net
https://www.hostinger.com/tutorials/how-to-setup-ftp-server-on-ubuntu-vps/
https://www.tecmint.com/ps-command-examples-for-linux-process-monitoring/
https://www.distrowatch.com

# Abbreviations
# --------------------------------------
APT - Advanced Package Tools
RHEL - Red Hat Enterprise Linux

# END OF FILE
# --------------------------------------
```
