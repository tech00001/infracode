resource "aws_vpc" "webvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Web VPC"
  }
}

# Creating Internet Gateway 
resource "aws_internet_gateway" "webgateway" {
  vpc_id = "${aws_vpc.webvpc.id}"
}

# Grant the internet access to VPC by updating its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.webvpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.webgateway.id}"
}

# Creating 1st subnet 
resource "aws_subnet" "websubnet" {
  vpc_id                  = "${aws_vpc.webvpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Pub subnet"
  }
}