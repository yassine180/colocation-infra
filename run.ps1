# Navigate to the Terraform directory
Set-Location -Path "terraform"

Write-Host "Running Terraform Command..."
# Run Terraform apply and capture the output
terraform apply -auto-approve -no-color | Out-String -Stream | Select-Object -Last 8 | Set-Content -Path "data.txt"

Write-Host "Extracting Data From Terraform Output..."
# Extract the Jenkins IP from the Terraform output
$jenkins_ip = Get-Content -Path "data.txt" | Select-String -Pattern "jenkins-ip" | ForEach-Object {
    ($_ -split '"')[1]
}

Write-Host "Clearing Environment..."
# Remove the temporary data file
Remove-Item -Path "data.txt" -Force
Set-Location -Path ".."

Write-Host "Adding LINUX instances Fingerprints to Known Hosts..."
# Add the Jenkins IP fingerprint to known hosts
ssh-keyscan $jenkins_ip | Out-File -FilePath "$HOME\.ssh\known_hosts" -Append

Write-Host "Creating inventory file..."
# Create the Ansible inventory file
@"
[linux]
jenkins ansible_host=$jenkins_ip

[linux:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=ansible/keys/aws-ssh-key.pem
"@ | Set-Content -Path "ansible/inventory.cfg"
