# Pariscall.international-ops

Recipes to setup infrastructure and deploy pariscall.international website and API

> Recettes pour mettre en place l'infrastructure et déployer le site web et l'API de pariscall.international

## Requirements

- Install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- Install required Ansible roles `ansible-galaxy install -r requirements.yml`

### [For developement only] Additionals dependencies

To test the changes without impacting the production server, a Vagrantfile is provided to test the changes locally in a virtual machine. VirtualBox and Vagrant are therefore required.

- Install [VirtualBox](https://www.vagrantup.com/docs/installation/)
- Install [Vagrant](https://www.vagrantup.com/docs/installation/)

## Configuration

### Allow decrypting all sensitive data.

A password is needed to decrypt encrypted files with [`ansible-vault`](https://docs.ansible.com/ansible/latest/user_guide/vault.html).
Get the password from the administrator and copy it in a `vault.key` file at the root of this project, it will avoid entering it every time you run a command.

### [For developement only] Configure your host machine to access the VM.

Edit your hosts file `/etc/hosts`, add the following line so you can connect to the VM to test deployed apps from your host machine's browser:
```
192.168.33.10    vagrant.local
```

Now on your browser you will be able to access deployed app on the VM with the URL `http://vagrant.local`

The server name `vagrant.local` can be changed in the file `/inventories/dev.yml`:
```
[…]
    dev:
      hosts:
        '127.0.0.1':
          […]
          base_url: <SERVER_NAME>
```

The guest VM's IP can be changed in the `VagrantFile`:
```
[…]
config.vm.network "private_network", ip: "192.168.33.10"
[…]
```

## Usage

To avoid making changes on the production server by mistake, by default all commands will only affect the vagrant developement VM. Note that the VM need to be started before with `vagrant up`.\
To execute commands on the production server you should specify it by adding the option `-i inventories/production.yml` to the following commands:

- To setup a phoenix server:
```
ansible-playbook playbooks/site.yml
```

- To setup infrastructure only:
```
ansible-playbook playbooks/infra.yml
```

- To setup `pariscall.international-backend` app only:
```
ansible-playbook playbooks/pariscall.international-backend.yml
```

- To setup one subpart of the infra:
```
ansible-playbook playbooks/infra/<MODULE>.yml
```
_You can find all available modules in `playbooks/infra` directory._

For example, to setup only Themis on the new server:
```
ansible-playbook playbooks/infra/themis.yml
```

Some useful options can be used to:
- see what changed with `--diff`
- simulate execution with `--check`
- see what will be changed with `--check --diff`

### Tags

Some tags are available to refine what will happen, use them with `-t`:
 - `setup`: to only setup system dependencies required by the app(s) (cloning repo, installing app dependencies, all config files, and so on…)
 - `start`: to start the app(s)
 - `stop`: to stop the app(s)
 - `restart`: to restart the app(s)
 - `update`: to update the app(s) (pull code, install dependencies and restart app)

For example, you can update `pariscall.international-backend` by running:
```
ansible-playbook playbooks/pariscall.international-backend.yml -t update
```
