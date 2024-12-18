#!/bin/bash

cd terraform
echo "Running Terraform Command..."
terraform apply -auto-approve -no-color | tail -8 > data.txt

echo "Extracting Data From Terraform Output..."
jenkins_ip=$(cat data.txt | grep -E "jenkins-ip" | cut -d '"' -f 2)

echo "Clearing Envirement..."
rm data.txt
cd ..

echo "Adding LINUX instances Fingerprints to Known Hosts ..."
ssh-keyscan $jenkins_ip >> ~/.ssh/known_hosts

echo "Creating inventory file ..."
cat << EOT > ansible/inventory.cfg
[linux]
jenkins ansible_host=$jenkins_ip

[linux:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=ansible/keys/aws-ssh-key.pem
EOT

# sleep 20
# ansible-playbook -i ansible/inventory.cfg ansible/playbooks/openvpn-playbook.yml -vvv
# sleep 20

# scp -i "ansible/keys/aws-ssh-key.pem" ubuntu@$openvpn_ip:/home/ubuntu/client-configs/files/admin.ovpn .
# nohup sudo openvpn admin.ovpn &
# sleep 10

# ssh-keyscan $jenkins_ip >> ~/.ssh/known_hosts
# ssh-keyscan $sonar_ip >> ~/.ssh/known_hosts