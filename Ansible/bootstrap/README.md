# Bootstrap | Ansible

## Directory Structure

```bash
.
├── README.md
├── inventory
│   ├── production
│   │   ├── group_vars
│   │   │   ├── group1.yml
│   │   │   └── group2.yml
│   │   └── hosts.yml
│   └── staging
│       ├── group_vars
│       │   ├── group1.yml
│       │   └── group2.yml
│       └── hosts.yml
├── playbooks
│   ├── ansible.cfg
│   ├── playbook-01.yml
│   ├── playbook-02.yml
│   ├── playbook-03.yml
│   └── playbook-04.yml
└── roles
    ├── common
    │   └── tasks
    │       └── main.yml
    ├── role-01
    │   └── tasks
    │       ├── main.yml
    │       ├── task_one.yml
    │       └── task_two.yml
    ├── role-02
    │   └── tasks
    │       ├── main.yml
    │       ├── task_one.yml
    │       └── task_two.yml
    └── role-03
        └── tasks
            ├── main.yml
            ├── task_one.yml
            └── task_two.yml
```

## Executing playbooks

```bash
# run from playbooks directory
cd playbooks/

# ansible-playbook <playbook>
ansible-playbook playbook-01.yml
```
