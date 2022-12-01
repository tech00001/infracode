resource "aws_security_group" "apps-sg" {
  name        = "apps-sg"
  vpc_id      = "${aws_vpc.webvpc.id}"

  #Incoming traffic
  ingress {
    description = "Nginx"
    from_port   = 5990
    to_port     = 5990
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Porteiner"
    from_port   = 5991
    to_port     = 5991
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "Speedtest"
    from_port   = 5993
    to_port     = 5993
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "Homer"
    from_port   = 5995
    to_port     = 5995
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Grafana"
    from_port   = 5992
    to_port     = 5992
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Prometheus"
    from_port   = 5994
    to_port     = 5994
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "VPN"
    from_port   = 5996
    to_port     = 5996
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Outgoing traffic
  egress {
    description      = "for all outgoing traffics"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "apps"
  }
}

resource "aws_security_group" "nginx-sg" {
  name        = "nginx-sg"
  vpc_id      = "${aws_vpc.webvpc.id}"

  #Incoming traffic
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 29
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Outgoing traffic
  egress {
    description      = "for all outgoing traffics"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "nginx"
  }
}