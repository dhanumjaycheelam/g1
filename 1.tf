resource "aws_vpc" "v1" {
cidr_block= "10.0.0.0/16"
}

resource "aws_subnet" "s1" {
vpc_id= aws_vpc.v1.id
cidr_block= "10.0.0.0/24"
availability_zone= "ap-southeast-1a"
}

resource "aws_internet_gateway" "igw"{
vpc_id=aws_vpc.v1.id
}

resource "aws_route_table" "rt"{
vpc_id=aws_vpc.v1.id
}

resource "aws_route" "r" {
route_table_id=aws_route_table.rt.id
destination_cidr_block="0.0.0.0/0"
gateway_id=aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "sr" {
route_table_id=aws_route_table.rt.id
subnet_id=aws_subnet.s1.id
}

resource "aws_instance" "i1"{
ami ="ami-0df7a207adb9748c7"
instance_type ="t2.micro"
subnet_id =aws_subnet.s1.id
}

resource "aws_eip" "eip"{
instance=aws_instance.i1.id
}

resource "aws_s3_bucket" "sb1" {
bucket = "dhanu-first-bucket"
}