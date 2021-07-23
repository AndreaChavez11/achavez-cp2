#!/bin/bash

# añadir tantas líneas como sean necesarias para el correcto despligue
ansible-playbook -i host.lab install-common.yaml
ansible-playbook -i host.lab -l nfs install-nfs.yaml
ansible-playbook -i host.lab conf-servers.yaml
ansible-playbook -i host.lab -l master conf-kubernetes.yaml
ansible-playbook -i host.lab -l workers conf-workers.yaml

