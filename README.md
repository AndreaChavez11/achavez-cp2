# achavez-cp2
**Prerrequisitos**

Tanto para la ejecución del despliegue de la infraestructura como para la aplicación debemos tomar en cuenta los siguientes prerrequisitos:

**Instalación de paquetes requeridos**

	Antes de iniciar este procedimiento es importante realizar una actualización completa de la máquina (dnf update -y) y adicionalmente incluir Azure Cli, chronyd,  git, ansible y terraform.
Adicionalmente es necesario levantar los servicios de chronyd.

**Configuración de acceso mediante llave pública**

	Para poder ejecutar el plan de terraform y para la ejecución de los playbooks de ansible debemos generar un par de llaves que nos permitan conectarnos a través de SSH a nuestras máquinas virtuales.
Para el caso de Linux ejecutamos el comando ssh-keygen si aplicamos los valores por defecto la llave se generará en la ruta: ~/.ssh/id_rsa.pub
Esta ruta la utilizaremos más adelante para el despliegue del plan de terraform.

**Repositorio de Github**

El código fuente de esta solución se encuentra disponible en Git Hub bajo una licencia de tipo GNU General Public License v3.0. Esta licencia de código abierto que habilita que pueda ser modificada, distribuida, darle uso comercial o privado siempre y cuando se mantenga bajo las mismas condiciones de licencia (manteniéndose como código abierto). No ofrece responsabilidad o garantías sobre el uso de la misma. 
Para la presente práctica el repositorio que utilizaremos se encuentra en la siguiente ruta: https://github.com/AndreaChavez11/achavez-cp2.git Para el caso de Linux ejecutamos el siguiente comando:  git clone https://github.com/AndreaChavez11/achavez-cp2.git
El repositorio tiene la siguiente estructura de archivos:

**Despliegue de la infraestructura**

	En esta sección detallaremos la ejecución del plan de terraforma para el despliegue de nuestro entorno en Microsoft Azure
Configuración de cuenta Azure
	Para poder ejecutar el plan de terraform se requiere realizar la configuración de la cuenta de azure para esto debemos realizar Login con el comando: az login, posteriormente establecer las suscripción que vamos a utilizar creamos un Service Principal, los datos generados serán utilizados para establecer el archivo de credenciales.
Configuración de variables
	Debemos crear un archivo de credenciales en la carpeta achavez-cp2/terraform/  con los datos generados del paso anterior incluyendo la siguiente información:
subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
client_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" # appID
  client_secret   = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"  # password
  tenant_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" # tenant

Nota: Este archivo no debe ser público.

En el archivo achavez-cp2/terraform/correccion-vars.tf si es necesario actualizar las variables:
location (por defecto se manejará "West Europe")
storage_account
public_key_path
ssh_user 
Adicionalmente se incluye el archivo achavez-cp2/terraform/vars.tf con la configuración de las IPs que utilizaremos en la práctica por si se desea modificar. Dentro de la configuración de ansible en la carpeta achavez-cp2/ansible/group_vars/ se incluyen los archivos de variables en donde según sea necesario también se configurarán las IPs de los nodos.

**Ejecución del Plan**

	Para la ejecución del plan de terraform, una vez actualizado el archivo de corrección de variables debemos posicionarnos en la carpeta: achavez-cp2/terraform/ y ejecutamos los siguientes comandos:
terraform init
terraform plan
terraform apply
Si fuese necesario generar nuevamente la infraestructura podemos aplicar el comando: 
terraform destroy



**Despliegue de kubernetes**

**Validación de acceso a las VM en azure**

	Al intentar ejecutar los playbooks de ansible para el despliegue de kubernetes se identificó que no validaba como conexión segura si lo ejecutaba inmediatamente después de de la creación de la infraestructura con terraform, sin embargo si se generaba una primera conexión a las máquinas este inconveniente no se presentaba, para esto ejecutamos una validación de acceso a todos los nodos con los siguientes comandos.
  
Nota: si presenta error para autenticar ejecutamos los siguientes comandos para aceptar la conexión ssh.

ssh adminUsername@vmnfsunir180.westeurope.cloudapp.azure.com
ssh adminUsername@vmmasterunir180.westeurope.cloudapp.azure.com
ssh adminUsername@vmworker1unir180.westeurope.cloudapp.azure.com
ssh adminUsername@vmworker2unir180.westeurope.cloudapp.azure.com

**Configuración de Inventario de Host **

	Como parte de la creación de la infraestructura con terraform se estableció para cada nodo una ip pública y se configuró el domain_name_label, sin embargo se podría configurar por IP de acuerdo a lo desplegado en Azure.
Si se actualizó el usuario en el archivo achavez-cp2/terraform/correccion-vars.tf  es necesario actualizarlo también en el archivo de achavez-cp2/ansible/hosts

[all:vars]
ansible_user=adminUsername
ansible_python_interpreter=/usr/bin/python3

[master]
vmmasterunir180.westeurope.cloudapp.azure.com

[workers]
vmworker1unir180.westeurope.cloudapp.azure.com
vmworker2unir180.westeurope.cloudapp.azure.com

[nfs]
vmnfsunir180.westeurope.cloudapp.azure.com

** Ejecución del Playbook**

Para el despliegue del NFS y de Kubernetes en el nodo master y los workers se crean los siguientes playbooks los cuales se encuentran definidos en el archivo deploy.sh
ansible-playbook -i hosts install-common.yaml
ansible-playbook -i hosts -l nfs install-nfs.yaml
ansible-playbook -i hosts conf-servers.yaml
ansible-playbook -i hosts -l master conf-kubernetes.yaml
ansible-playbook -i hosts -l workers conf-workers.yaml
	Los playbooks se definieron en función de la ejecución de cada tipo de host. puede ejecutarse de uno en uno en el orden indicado o hacerlo a través de la ejecución de archivo achavez-cp2/ansible/deploy.sh
  
Nota: Debido a que en primera instancia se ejecuta un update de los nodos puede tomar varios minutos.
