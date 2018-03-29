# Infra-as-code-Openstack
deploy infra on openstack with automation tools

  
How to launch ansible :   

```  
first install dependencies with apt-get install :  
  
 - python-dev  
 - python-pip  

next install ansible and shade with pip :  
  
 - pip install ansible  
 - pip install shade  
  
you need to change vars in vars/main.yml before start script ansible  
  
for launch ansible execute this command :   
  
$ cd $repo-ansible  
$ ansible-playbook -i "localhost," -c local playbook.yml  

```  


How to launch terraform :

```  
first install terraform :  

go to terraform website for download terraform binary : https://www.terraform.io/downloads.html   

example :   

 - $ wget https://releases.hashicorp.com/terraform/0.11.5/terraform_0.11.5_linux_amd64.zip?_ga=2.99648030.1025015082.1522224733-226428289.1522224733  

you need to unzip it before to use it :  

unzip terraform_0.11.5_linux_amd64.zip /usr/bin  

now you can use terraform :  

terraform init -> initialize repo with module openstack if the providers in main.tf is openstack, you need also to change vars in providers in main.tf before to start it  

$ cd $repo-terraform
$ terraform init
$ terraform apply or terraform destroy
```  

How to launch heat :  
  
```
first you need to source credentials for your project :  

  $ source demo-openrc.sh    

you need list available network with command $ neutron net-list  

set env NET_ID with : export NET_ID=$(neutron net-list | awk '/ public / { print $2 }')  

for launch heat use this command for example : 

$ cd $repo-heat  
$ heat stack-create -f template.yml -P "ImageID=cirros;NetID=$NET_ID" stack  

```
