# data "aws_vpc" "selected" {
#   id = "vpc-039d3b1d36b7c4672"
# }

# data "aws_subnet" "subnet1" {
#   id = "subnet-03a024e804413bad9"
# }

# data "aws_security_group" "test" {
#     id = "sg-0c26639bc3430ed15"
# }

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "anudeep121810"
    key    = "Terraformtfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "web-2" {
  ami = "ami-0e8a34246278c21e4"
  #ami = "ami-0d857ff0f5fc4e03b"
  #ami = "${data.aws_ami.my_ami.id}"
  availability_zone           = "us-east-1a"
  instance_type               = "t2.micro"
  key_name                    = "newvpc"
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet1_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_id]
  associate_public_ip_address = true
  tags = {
    Name       = "Server-2"
    Env        = "Prod"
    Owner      = "Anudeep"
    CostCenter = "ABCD"
  }
}
