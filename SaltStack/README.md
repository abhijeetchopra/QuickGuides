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

```
