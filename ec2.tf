# ------------- create aws ec2 bastion  --------------------------

resource "aws_instance" "bastion" {
  ami                         = var.ami
  instance_type               = var.ec2_instance_type
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  key_name                    = aws_key_pair.iti_ssh_key.key_name
  subnet_id                   = module.network.iti_public_subnet1_id
  associate_public_ip_address = true

  tags = {
    Name      = "iti-bastion"
    createdBy = "terraform"
  }
  root_block_device {
    delete_on_termination = true
  }


  provisioner "local-exec" {
    # print the bastion public ip address
    command = "echo ${self.public_ip}"
  }

}

resource "aws_instance" "application_instance" {
  ami                    = var.ami
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.application_sg.id]
  key_name               = aws_key_pair.iti_ssh_key.key_name
  subnet_id              = module.network.iti_private_subnet1_id
  tags = {
    Name      = "iti-application_instance"
    createdBy = "terraform2"
  }
  root_block_device {
    delete_on_termination = true
  }

}


resource "time_sleep" "wait" {
  create_duration = "180s"
  depends_on      = [aws_instance.bastion, aws_instance.application_instance, aws_key_pair.iti_ssh_key]
}


resource "null_resource" "ansible_inventory" {
  provisioner "local-exec" {

    interpreter = ["bash", "-c"]
    command     = <<EOT
          echo "
              [application]
              ${aws_instance.application_instance.private_ip}

              [application:vars]
              ansible_user = ubuntu

              ansible_port = 22

              private_key_file = /var/jenkins_home/workspace/aws_infra_pipeline/ansible/pk.pem

              ansible_ssh_common_args = '-o ProxyCommand="ssh -i /var/jenkins_home/workspace/aws_infra_pipeline/ansible/pk.pem -W %h:%p -q ubuntu@${aws_instance.bastion.public_ip}"'
          " > ./ansible/inventory
          
          echo "
          Host bastion
                  HostName ${aws_instance.bastion.public_ip}
                  IdentityFile /var/jenkins_home/workspace/aws_infra_pipeline/ansible/pk.pem
                  User ubuntu

          Host application
                  HostName ${aws_instance.application_instance.private_ip}    
                  IdentityFile /var/jenkins_home/workspace/aws_infra_pipeline/ansible/pk.pem
                  Port 22
                  User ubuntu     
                  ProxyCommand ssh -q -W %h:%p bastion
          " > /root/.ssh/config
     EOT
  }

  depends_on = [
    time_sleep.wait
  ]
}

resource "null_resource" "run_ansible" {
  provisioner "local-exec" {

    interpreter = ["bash", "-c"]
    command     = <<EOT
           cd ./ansible && ansible-playbook --private-key ./pk.pem plays/app_vm.yaml -vvv
     EOT
  }

  depends_on = [
    null_resource.ansible_inventory
  ]
}









