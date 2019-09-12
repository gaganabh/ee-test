# Define webserver inside the public subnet
resource "aws_instance" "ee-pub-ec2" {
   ami  = "${var.ami}"
   instance_type = "t2.micro"
   key_name = "ee-test"
   subnet_id = "${aws_subnet.public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.ee-pub-sg.id}"]
   associate_public_ip_address = true
   source_dest_check = false
   user_data = "${file("userdata.sh")}"
   tags = {
       Name = "node1"
  }

}

# Define database inside the private subnet
resource "aws_instance" "ee-pvt-ec2" {
   ami  = "${var.ami}"
   instance_type = "t2.micro"
   key_name = "ee-test"
   subnet_id = "${aws_subnet.private-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.ee-pvt-sg.id}"]
   source_dest_check = false
   tags = {
    Name = "node2"
  }

}
