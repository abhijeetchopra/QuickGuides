# Ansible

## Ansible Essentials

> Simplicity in Automation (DO007)

Ansible is an automation and configuration management technology used to provision, deploy, and manage compute infrastructure across cloud, virtual, and physical environments.  

**Link:** https://www.ansible.com/resources/webinars-training/introduction-to-ansible  

## Contents

1. Ansible Essentials Introduction  
2. What is Ansible and the Ansible Way  
3. How Ansible Works  
4. Ad-Hoc Commands  
5. Introduction to Playbooks  
6. Introduction to Roles  
7. Creating the Roles Structure with Ansible-Galaxy  
8. Breaking an Existing Playbook into a Role  
9. Creating a New Role  
10. Utilizing Roles in your Main Playbooks  
11. Overview of Ansible Tower  

---

## 01. Ansible Essentials Introduction  

### Installation

<https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html>

```bash
sudo apt install python-pip
sudo pip install ansible
```

## 02. What is Ansible and the Ansible Way  

### Complete package

1. Application deployment - Fabric, Capistrano, Nolio
2. Configuration management - Chef, Puppet, CFEngine
3. Multi-tier orchestration - BMC, Mcollective, Chef Metal
4. Provisioning - Cobbler, AWS, JuJu

## 03. How Ansible Works  

### Users

- writes ansible playbook

### Ansible Playbook

- written in yaml - invoke tasks  
- tasks - are executed sequentially - invoke ansible modules
- modules - are executable 

### Inventory

- collection of hosts or group of hosts
- inventory sources can be static or dynamic
- hosts can be anything that is network addressable
- fqdn / hostname / ip address
- modules act against inventory

### Modules

- apt/yum
- copy
- file
- get_url
- git
- ping
- debug
- service
- synchronize
- template
- uri
- user
- wait_for
- assert
- run command

## 04. Ad-Hoc Commands  

### control machine setup

```bash
# install ansible
sudo apt install -y ansible

# check version
ansible --version
```

### ad-hoc ansible commands

```bash

# localhost
ansible localhost -m command -a "ifconfig"

# copy a file locally
ansible localhost -m copy -a "src = /tmp/dir1/filename dest = /tmp/dir2/filename"

# gather facts from all hosts
ansible all -i hosts.yml -m setup

# display uname of hosts in webservers group
ansible webservers -i hosts.yml -m command -a "uname -a"

# whoami
ansible all -i hosts.yml -m command -a "whoami"

# privilege escalation
ansible all -i hosts.yml -m command -a "whoami" -b

# rebooting servers; by default only 5 simultaneous forks
ansible all -i hosts.yml -a "/sbin/reboot"

# specifying 10 forks
ansible all -i hosts.yml -a "/sbin/reboot" -f 10

# connect to server as username
ansible all -i hosts.yml -a "/sbin/reboot" -f10 -u username

# connect to server as username and become root
ansible all -i hosts.yml -a "/sbin/reboot" -f10 -u username -b

# check if a package is installed
ansible webservers -i hosts.yml -u achopra --check --diff -m apt -a "name=cowsay state=present" -b

# actually install a package if it's not installed
ansible webservers -i hosts.yml -u achopra --diff -m apt -a "name=cowsay state=present" -b

#####

# check all my inventory hosts are ready to be managed by ansible
ansible all -m ping

# run the uptime command on all hosts in the web group
ansible web -m command -a "uptime"

# collect and display the discovered for the localhost
ansible localhost -m setup

#
ansible all -i hosts.yml -u achopra --diff -m command "whoami"

#
ansible all -i hosts.yml -u achopra -diff -m command "whoami" -b

#
ansible all -i hosts.yml -u achopra --limit="rasp-node-1," --check --diff -m apt -a "name=nginx state=present" -b
```

## 05. Introduction to Playbooks  

### Variables

#### Variable Precedence

1. Extra vars
2. Task vars (only for the task)
3. Block vars (only for tasks in the block)
4. Role and include vars
5. Play vars_file
6. Play vars_prompt
7. Play vars
8. Set_facts
9. Registered vars
10. Host facts
11. Playbook host_vars
12. Playbook group_vars
13. Inventory host_vars
14. Inventory group_vars
15. Inventory vars
16. Role defaults

### Example playbook

#### Modules we will use in this example

file: a directory should exist  
yum: a package should be installed  
service: a service should be running  
template: render a config file from a template  
get_url: fetch an archive file from a URL  
git: clone a scource code reposity  

#### Playbook

```yaml
tasks:
  - name: add cache dir
    file:
      path: /opt/cache
      state: directory

  - name: install nginx
    yum:
      name: nginx
      state: latest

  - name: restart nginx
    service:
      name: nginx
      state: restarted
```

#### Handler tasks

Handler tasks are special tasks that run at the end of a play if notified by another task.
Eg. If a configuration file gets changed notify a service restart task it needs to run.
If the task returns changed, then it will send notification and trigger the handler task.

```yaml
tasks:
  - name: add cache dir
    file:
      path: /opt/cache
      state: directory

  - name: install nginx
    yum:
      name: nginx
      state: latest
    notify: restart nginx

handlers:
  - name: restart nginx
    service:
      name: nginx
      state: restarted
```

#### Plays and Playbooks

Plays are ordered sets of tasks to execute against host selections from your inventory.

Playbook is a file containing one or more plays.

> Best practice: always name your plays and tasks.

```yaml
---
- name: install and start apache
  hosts: web
  vars:
    http_port: 80
    max_clients: 200
  remote_user: root

  tasks:
  - name: install httpd
    yum: pkg=httpd state=latest
  - name: write the apache config file
    template: src=/srv/httpd.j2 dest=/etc/httpd.conf
  - name: start httpd
    service: name=httpd state=started
```

Restructured with clean formatting:

```yaml
---
-
  hosts: web
  name: "install and start apache"
  remote_user: root
  tasks:
    -
      name: "install httpd"
      yum: "pkg=httpd state=latest"
    -
      name: "write the apache config file"
      template: "src=/srv/httpd.j2 dest=/etc/httpd.conf"
    -
      name: "start httpd"
      service: "name=httpd state=started"
  vars:
    http_port: 80
    max_clients: 200
```

Basic Playbook

```yaml
---
- name: install and start apache
  hosts: rasp
  remote_user: achopra
  become: yes

  tasks:
  - name: install epel repo
    apt: name=epel-release state=present

  - name: install python bindings for SELinux
    apt: name={{item}} state=present
    with_items:
    - libselinux-python
    - libsemanage-python

  - name: test to see if SELinux is running
    command: getenforce
    # register basically saves the outcome of the task in the variable 'sestatus'
    register: sestatus
    changed_when: false

  - name: install apache
    apt: name=apache state=present

  - name: start apache
    service: name=apache state=started enabled=yes

```

### Running ansible playbooks

```bash

# list hosts
ansible-playbook -i hosts.yml site.yml --list-hosts

# list tasks
ansible-playbook  -i hosts.yml site.yml --list-tasks

# dry run
ansible-playbook  -i hosts.yml site.yml --check --diff

# executing a playbook
ansible-playbook -i hosts.yml site.yml

```

## 06. Introduction to Roles  

Roles are packages of closely related Ansible content that can be shared more easily than plays alone.

### Directory Structure

```text
site.yml
roles/
    common/
        files/
        templates/
        tasks/
        handlers/
        vars/
        defaults/
        meta/
    webservers/
        files/
        templates/
        tasks/
        handlers
        vars/
        defaults/
        meta/
```

### Playbook with Roles

```yaml
# site.yml
---
- hosts: web
  roles:
    - common
    - webservers
```

## 07. Creating the Roles Structure with Ansible-Galaxy  

```bash
ansible-galaxy init --help
ansible-galaxy init common # lays down structure for the 'common' role
ansible-galaxy init apache # lays down structure for the 'apache' role
```

## 08. Breaking an Existing Playbook into a Role  

```text
.
├── defaults
│   └── main.yml
├── files
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── README.md
├── tasks
│   └── main.yml
├── templates
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    └── main.yml

```

## 09. Creating a New Role  

Basically refactor code from site.yml and break it into roles that can be created using the ansible-galaxy command as in section 07 above.

## 10. Utilizing Roles in your Main Playbooks  

```text
.
├── group_vars
│   ├── all.yml
│   └── webservers.yml
├── hosts.yml
├── README.md
├── roles
│   ├── apache
│   ├── common
│   ├── haproxy
│   ├── mariadb
│   └── web
└── site.yml
```

```yaml
# site.yml
---
- name: apply the common configuration to all hosts
  hosts: all
  remote_user: achopra
  become: yes

  roles:
  - common

- name: apply the database configuration
  hosts: dbservers
  remote_user: achopra
  become: yes

  roles:
  - mariadb


- name: apply the apache and the web roles
  hosts: webservers
  remote_user: achopra
  become: yes

  roles:
  - apache
  - web

- name: apply the lb configuration
  hosts: lbservers
  remote_user: achopra
  become: yes

  roles:
  - haproxy

```

```yaml
---
# roles/common/tasks/main.yml

# tasks file for common

- include: ntp.yml
- include: nginx.yml

```

## 11. Overview of Ansible Tower

Paid product!
