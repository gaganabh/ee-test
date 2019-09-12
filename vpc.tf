resource "aws_vpc" "ee-vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags = {
    Name ="ee-vpc"
   }
}

# Define the public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = "${aws_vpc.ee-vpc.id}"
  cidr_block = "${var.ee-public_subnet_cidr}"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "ee-pub-sub"
   }
}

# Define the private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = "${aws_vpc.ee-vpc.id}"
  cidr_block = "${var.ee-private_subnet_cidr}"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "ee-pvt-sub"
   }
}

# Define the internet gateway
resource "aws_internet_gateway" "ee-igw" {
  vpc_id = "${aws_vpc.ee-vpc.id}"
  tags = {
    Name = "ee-igw"
   }

}

# Define the route table
resource "aws_route_table" "ee-public-rt" {
  vpc_id = "${aws_vpc.ee-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ee-igw.id}"
  }
  tags = {
    Name = "ee-pub-rt"
   }


}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "ee-public-rt" {
  subnet_id = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.ee-public-rt.id}"
}

# Define the security group for public subnet
resource "aws_security_group" "ee-pub-sg" {
  name = "ee-vpc-pub"
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  vpc_id="${aws_vpc.ee-vpc.id}"
  tags = {
    Name = "ee-web-sg"
   }


}

# Define the security group for private subnet
resource "aws_security_group" "ee-pvt-sg"{
  name = "ee-vpc-pvt"
  description = "Allow traffic from public subnet"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${var.ee-public_subnet_cidr}"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.ee-public_subnet_cidr}"]
  }

  vpc_id = "${aws_vpc.ee-vpc.id}"
  tags = {
    Name = "ee-db-sg"
   }

}
