# SaltStack

```bash
# run command on all hosts from salt-master
salt '*' cmd.run 'hostname -I'

# run command on 'server-01' host from salt-master
salt server-01 cmd.run 'hostname -I'

# run command on hosts starting with 'server-*' from salt-master
salt '*' cmd.run 'hostname -I'

# run command on hosts starting with 'server-*' from salt-master
salt server-* cmd.run 'hostname -I'

# run command as user 'demo-user' on target host from salt-master
salt '*' cmd.run "su -c 'whoami' demo-user"

# apply salt in staggered way to prevent throttling ssm
salt '*' test.ping | grep sbx | grep ":" | sed 's/:$//' | xargs -n 1 -I {} salt {} state.apply

# refresh pillar
salt '*' saltutil.refresh_pillar

# target state id
salt <target> state.sls_id <state-id> <module-path>

# target sls
salt <target> state.sls <file-path>

# print AMI-IDs of all hosts in an env
salt '*' cmd.run 'curl -s http://169.254.169.254/latest/meta-data/ami-id' | grep -v "^qas-.*:$" | sed 's/^.*ami-/ami-/' | sort -u

# print AMI-IDs of all hosts not running awsagent (Thank you Doug McIlroy!)
salt '*' cmd.run 'systemctl is-active --quiet awsagent || ls /etc/rc.d/init.d/awsagent' | grep -B 1 "No such file" | grep "qas-" \
| sed 's/:$//' | xargs -n 1 -I {} salt {} cmd.run 'curl -s http://169.254.169.254/latest/meta-data/ami-id' | grep -v "^qas-.*:$" \
| sed 's/^.*ami-/ami-/'

# execute state in specific file
salt '*' state.sls <state_file>

# execute the highstate configured by top.sls
salt '*' state.highstate

# state.apply invoked without any SLS names will run state.highstate
# state.apply invoked with SLS names will run state.sls

salt '*' state.apply
salt '*' state.apply <state-sls-name>

# add grain manually from salt-master
salt <target> grains.setval key1 val1

# Output:
#     ----------
#     key1:
#         val1

salt <target> grains.setval key1 "{'sub-key': 'val1', 'sub-key2': 'val2'}"

# Output:
#     ----------
#     key1:
#         ----------
#         sub-key:
#             val1
#         sub-key2:
#             val2

salt <target> grains.setval key1 "{'sub-key': 'val1', 'sub-key2': 'val2'}"

# Output:
#     ----------
#     key1:
#         ----------
#         sub-key:
#             - val1
#             - val2

# list all grains
salt <target> grains.ls

# list all grains with values
salt <target> grains.items

# list given grain value
salt <target> grains.item <grain-name/key>

# delete given grain
salt <target> grains.delkey <grain-name/key>

# list salt keys
salt-key -L

# list jobs
salt-run jobs.list_jobs --out=json

# list jobs filter by function
salt-run jobs.list_jobs --out=json search_function="state.apply"

# list jobs filter by function and only print job id and target name (requires jq package to be installed)
salt-run jobs.list_jobs --out=json search_function="state.apply" | jq -r 'to_entries[] | "\(.key) \(.value.Target)"'

```

## Runners

Salt runners are convenience applications executed with the salt-run command.

Salt runners work similarly to Salt execution modules however they execute on the Salt master itself instead of remote Salt minions.

A Salt runner can be a simple client call or a complex application.

## Runner Modules

<https://docs.saltproject.io/en/latest/ref/runners/all/index.html#all-salt-runners>

### Jobs Runner

```bash
salt-run jobs.list_jobs search_function='test.*,pkg.install'
```

Return the printout from a previously executed job

```bash
salt-run jobs.lookup_jid 20130916125524463507
salt-run jobs.lookup_jid 20130916125524463507 --out=highstate
```

Print list of salt states in ascending order of duration or time taken for each salt state to complete in seconds

```bash
salt-run jobs.lookup_jid 20130916125524463507 --out=highstate | grep -e "ID:" -e "Duration:" | paste - - | sed 's/^.*ID: //g;s/[ ]*Duration://g' | awk '{print $1 " "$2/1000}' | sort -h -k2 | column -t
```

## Troubleshooting on minion

```bash
# run high state in debug mode from salt minion on host locally for troubleshooting
salt-call -l debug state.highstate

salt-call -l debug state.apply

```
