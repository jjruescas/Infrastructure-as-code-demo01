#aws.tf
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "WSERVER_KEY" {}
variable "VM_NAME" {}
variable "AMI_ID" {
  type    = "string"
  default = "ami-14709e6e" //Template-VM04
  //default = "ami-d79d92c1" // Microsoft Windows Server 2012 R2 64-Bits
}

variable "KEY_PAIR" {
  type    = "string"
  default = "wserver-key"
}

provider "aws" {
	region = "us-east-1"
	access_key = "${var.AWS_ACCESS_KEY}"
	secret_key = "${var.AWS_SECRET_KEY}"
}

/*
resource "aws_key_pair" "demo-key" {
	key_name = "wserver-key"
	public_key = "${var.WSERVER_KEY}"
}
*/

resource "aws_instance" "web" {
	ami = "${var.AMI_ID}"
	instance_type = "t2.micro"
	key_name = "${var.KEY_PAIR}"
	security_groups = ["Microsoft Windows Server 2012 R2-2017.07.13-AutogenByAWSMP-"]
	tags {
		Name = "${var.VM_NAME}"
	}
}