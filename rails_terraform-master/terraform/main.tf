provider "aws" {
    access_key        = "***********************"
    secret_key        = "***********************************"
    region            = "us-east-1"
}


resource "aws_instance" "ec2_web" {
    subnet_id         = "${aws_subnet.websubnet.id}"
    ami               = "ami-04505e74c0741db8d"
    instance_type     = "t2.micro"
    key_name          = "initkey"
    security_groups   = ["${aws_security_group.apps-sg.id}", "${aws_security_group.nginx-sg.id}"]

    tags = {
    Name              = "Web-app"
    }

    root_block_device {
    volume_size = "30"
    volume_type = "standard"
  }


    provisioner "remote-exec" {
        inline = [
          "sudo git clone https://cloud-lab-token:2ef2ej-Ysx14otMxgJys@gitlab.com/sekiri/coud-lab.git init && cd init/",
          "sudo bash install.sh"
        ]

        connection {
          type        = "ssh"
          user        = "ubuntu"
          private_key = file("./initkey.pem")
          host        = self.public_ip
        }
    }
}



resource "aws_eip" "ip" {
    instance   = "${aws_instance.ec2_web.id}"
    depends_on = [aws_instance.ec2_web]
    vpc        = true
}