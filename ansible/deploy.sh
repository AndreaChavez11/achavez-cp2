#!/bin/bash

# añadir tantas líneas como sean necesarias para el correcto despligue
ansible-playbook -i host.lab install-common.yaml
ansible-playbook -i host.lab -l nfs install-nfs.yaml
#ansible-playbook -i host.lab install-kubernetes.yaml
