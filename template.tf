# Provider configuration
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "test_public" {
  vpc_id     = "${aws_vpc.test_vpc.id}"
  cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "allow_http" {
  name = "allow_http"
  description = "Allow HTTP traffic"
  vpc_id = "${aws_vpc.test_vpc.id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "master-instance" {
  ami           = "ami-78485818"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.test_public.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}"]
}

resource "aws_instance" "slave-instance" {
  ami           = "ami-78485818"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.test_public.id}"
  depends_on    = ["aws_instance.master-instance"]
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}"]
/*
  tags {
    master_hostname = "${aws_instance.master-instance.private_dns}"
  }
*/
  lifecycle {
    ignore_changes = ["tags"]
  }
}
