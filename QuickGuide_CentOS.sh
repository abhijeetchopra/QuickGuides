# --------------------------------------
# Auth: Abhijeet Chopra
# Date: Mon May 23, 2018
# Desc: Quick CentOS Guide
# --------------------------------------

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
$ sudo yum update

# Installing development tools for seamless integration with host OS
9. Applications > Favourites > Terminal
$ sudo yum groupinstall "Development Tools"

# Enabling WiFi Autoconnect
10. Applications > System tools > Settings > Network > Wired > Click the cog wheel button > Check "Connect Automatically"

# Extension Themes
11. Applications > Favourites > Terminal
$ sudo yum install gnome-shell-browser-plugin
# --------------------------------------


# Basic Linux Shell Command Syntax
# --------------------------------------
# Command Syntax: <command> <options> <arguments>

# List files
# --------------------------------------
$ ls -lh /usr/bin
command : "ls"
options : "-lh" where l is for list, h is for human-readable format
arguments: "/usr/bin" which is the file path

$ ls -l    # list
     -a    # list all files
	 -h    # human readable format
	 -i    # inode
	 -lah  # all three options at once

# Note: 
# Tilde (~) character denotes home folder
./ means current directory
~/ means home directory
../ means parent directory

# cd - Change current directory
# --------------------------------------
$ cd ~/ # changes current directory to home directory
$ cd .. # go to parent directory
$ cd /  # go to root directory


# mkdir - make directory / create folder
# --------------------------------------
$ mkdir <dir_name> 

$ mkdir {dir_1, dir_2, dir_3} # creates multiple directories in one command

# sort - sorts contents of a file/input
# --------------------------------------
$ sort -u /etc/passwd
command : "sort"
options : "-u"
arguments : "/etc/passwd" which is the file path

# grep - searches for text in file/input
# --------------------------------------
$ grep -i "root" /etc/passwd
command : "grep" used for searching text
options : "-i" for ignore case sensitive search
arguments : "/etc/passwd" which is the file path 

# find - finds files
# --------------------------------------
$ find . -name "poe*" # find all files in current directory with filename beginning "poe"
find <scope> <option - find by name> <argument>

# man - opening manual to get help on commands
# --------------------------------------
$ man <command>

# example: 
$ man grep
Output: Displays manual pages for "grep" command


# rm - removing/deleting files
# --------------------------------------
$ rm <filename> # warning: linux does not have a recycle bin

# delete directory
$ rm -r <directory_name>

# delete empty dir 
$ rmdir <directory_name>

# print file contents
$ cat /var/spool/mail/username

# get entry
$ getent passwd 
$ getent group

# system log viewer
$ gnome-system-log

# update timestamp of existing file / create new empty file
$ touch <filename>

# cp - copy files
# --------------------------------------
$ cp <filename> <destination>

$ cp -a   #arhive     -
     -b   #backup     -
     -n   #no clobber - prevents overwriting existing files
     -u   #update     - only moves if newer version

# mv - move
# --------------------------------------
$ mv <filename> <destination>


# Terminal Shortcuts
# --------------------------------------
Ctrl + A                          : Move to beginning of line
Ctrl + E                          : Move to end of line
Ctrl + Shift + Upward Arrow Key   : Scroll Up 
Ctrl + Shift + Downward Arrow key : Scroll Down
Ctrk + Left Arrow Key             : One Word Left
Ctrl + Right Arrow Key            : One Word Right



# File Permissions
# --------------------------------------

.................... d: directory | -: file
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


$ ls -ali

933442 -rwxrw-r--    10    root   root 2048    Jan 13 07:11 afile.exe

+--------------+------------------+-----------------+-------+-------+------+-------+-----+-------+-----------+
| index number | file permissions | number of links | owner | group | size | month | day | time  | filename  |
+--------------+------------------+-----------------+-------+-------+------+-------+-----+-------+-----------+
|       933442 | -rwxrw-r--       |              10 | root  | root  | 2048 | Jan   |  13 | 07:11 | afile.exe |
+--------------+------------------+-----------------+-------+-------+------+-------+-----+-------+-----------+


# Change mode / File permissions
# --------------------------------------

$ touch testfile.txt # creates a blank textfile, default permissions are 666

# Two ways to change permissions: 1. Octal / 2. Symbolic
$ chmod 777 testfile.txt # Octal
# OR
$ chmod u+x,g+x,o+x testfile.txt # Symbolic

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

#Symbolic: 

u : user
g : group
o : others

+ : add permission to existing permissions
- : remove permission from existing permissions
= : replace existing permission

r : read
w : write
x : execute


# Change User Ownership with chown
# --------------------------------------
$ sudo chown root test.sh
$ sudo chown <user> <filename>

# Change Group Ownership with chgrp
# --------------------------------------
$ sudo chgrp <wheel> test.sh
$ sudo chgrp <group> <filename>


# Pipes ( | )
# --------------------------------------
$ echo "hello world" | wc # prints the word-count of string "hello"
Output: 1  2  12  # Lines, Words, Characters

$ cat poems.txt | cat -n | tail -4 
# print file | print line no.s | print last 4 - 97,98,99,100

$ cat poems.txt | tail -4 | cat -4
# print file | print last 4 | print line no.s - 1,2,3,4

$ less poem.txt
↑↓    : scroll up/down
space : scroll down one screen
f/b   : forward/backward
h     : help
q     : quit



# Downloading files from URL using shell command
# --------------------------------------
$ wget <url> # file will be saved to current directory

# More uses: https://www.hostinger.com/tutorials/wget-command-examples/



# Compressing files
# --------------------------------------
# TAR - Tape Arcive Files

# File types:
1. .tar
2. .tar.gz
3. .tgz
4. .tar.bz2

$ tar -cvf myfile.tar 'Excercise Files'
      -c # compress / create
      -v # verbose / print warnings/messages
      -f # file


$ tar -caf myfile.tar 'Excercise Files'
      -c # compress / create
      -a # automatically detect compression format from file ext
      -f # file
	  
	 

# Extracting Files
# --------------------------------------

$ tar -xvf myfile.tar
      -x # extract
      -v # verbose / print warnings/messages
      -f # file

# Extracting tar.gz

$ git clone https://github.com/abhijeetchopra/Assembly/blob/master/Masm615_Download.zip
$ tar -xvzf log.tar.gz
# x: extract - c for compress
# v: vebose - will show error/sucess messages
# z: select gzip compression option - a for auto-detect with file extension
# f: file




# Installing software/packages
# --------------------------------------
$ sudo dnf install nano # dnf is the package manager in Fedora (dnf replaced yum)

$ sudo yum install nano # yum is package manager in CentOS (CentOS didn't port dnf yet)

$ sudo apt-get install nano # apt-get is package manager in Ubuntu

# OS version
# --------------------------------------
$ cat /etc/*-release

# Memory
# --------------------------------------
$ free -h

# CPU
# --------------------------------------
$ cat /proc/cpuinfo

# HDD
# --------------------------------------
$ df -h # disk-free space

$ sudo du / -hd1 # disk usage


# Check installed packages
# --------------------------------------
$ dnf history # Fedora


# Update CentOS
# --------------------------------------
$ su -c 'yum update'


# grep - searches text
# --------------------------------------
$ grep "the" poems
$ grep -n "the" poems # prints the line numbers
       -in "the" poems
	   -v "the" poems
	   -E "[hijk]" poems # regex - either of h,i,j,k
	   -E "\w{6,}" poems

# awk - extract/modify file/stream
# --------------------------------------
$ awk '{print $2}' simple_data.txt # prints 2nd column of space/tab separated values

$ awk '{print $2 "\t" $1 }' simple_data.txt # <col2> <tab> <col1>

$ awk '{print $2}' simple_data.txt | sort -n # -n for numeric sort

$ awk '{for(i=6;i<=NF;++i)printf $i""FS; print ""}' auth.log # prints all columns after 5

$ awk '{$1=$2=$3=$4=$5=""; print $0}' auth.log

# sed
# --------------------------------------
$sed s/Orange/Red/ simple_data.txt # replaces Orange with Red


# sort
# --------------------------------------
$ sort -k2 simple_data.txt # sorts 2nd column
$ sort -k2n simple_data.txt # sorts 2nd column numerically
$ sort -u simple_data.txt # unique results only

$ rev simple_data.txt # prints file reverse / flip vertically
$ tac simple_data.txt # prints file backwards / flip horizontally
 
$ cat simple_data.txt | tr [:lower:][:upper:] # 
 
$ cat file.txt | sort | uniq # unique rows only


# standard input/output/error - stdin/stdout/stderr
# --------------------------------------
$ ls -lah 0 > filelist.txt  # 0 : writes output to console
$ ls -lah 1 > filelist.txt  # 1 : writes output to file
$ ls -lah 2 > notreal       # 2 : writes errors to file (overwrites)
$ ls -lah 2 >> notreal      # 2 : writes errors to file (appends >>)


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


# Further Reading
# --------------------------------------
https://www.hostinger.com/tutorials/how-to-setup-ftp-server-on-ubuntu-vps/



# END OF FILE
# --------------------------------------