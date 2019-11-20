
Ansible recipe to configure system and deploy pariscall.international website and API

> Recette Ansible pour configurer le système et déployer le site web et l'API de pariscall.international

## Developement

Requirements:
- Virtualbox
- Vagrant

A VagrantFile is here to test your changes locally.
You need to add the following line to your `/etc/hosts` file to allow testing the nginx configuration in the test VM:
```
192.168.33.10    vagrant-test.local.com
```
You can change the server name in the `hosts.yml`.

A password is needed to decrypt encrypted files with Vault. Once you have the password, copy it in a `vault.key` file, it will allows you to avoid entering it each time you run the command.

Start vagrant VM by running:

```
vagrant up
```

Run playbook by specifying the vagrant private key to use, generally it is in `.vagrant/machines/default/virtualbox/private_key`

```
ansible-playbook --vault-password-file vault.key --private-key <PATH_TO_THE_VAGRANT_VM_PRIVATE_KEY> site.yml
```

TODO
- [] generate certificate
- [] add https nginx conf
- [] auto renew certificates

