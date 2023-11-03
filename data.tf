data "aws_vpc" "selected" {
  id = "vpc-039d3b1d36b7c4672"
}

data "aws_subnet" "subnet1" {
  id = "subnet-03a024e804413bad9"
}

data "aws_security_group" "test" {
    id = "sg-0c26639bc3430ed15"
}

resource "aws_instance" "web-1" {
    ami = "ami-0e8a34246278c21e4"
    #ami = "ami-0d857ff0f5fc4e03b"
    #ami = "${data.aws_ami.my_ami.id}"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "newvpc"
    subnet_id = "${data.aws_subnet.subnet1.id}"
    vpc_security_group_ids = [ "${data.aws_security_group.test.id}" ]
    associate_public_ip_address = true	
    tags = {
        Name = "Server-1"
        Env = "Prod"
        Owner = "Anudeep"
	CostCenter = "ABCD"
    }
}