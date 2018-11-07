#aws.tf
variable "AWS_ACCESS_KEY" {

}
variable "AWS_SECRET_KEY" { 

}
//variable "WSERVER_KEY" {}
variable "VM_NAME" {
		default = "VM01" 
}

variable "INSTANCE_USERNAME" {
		
}

variable "INSTANCE_PASSWORD" {
		 
}

variable "AMI_ID" {
  type    = "string"
  //default = "ami-14709e6e" //Template-VM04
  default = "ami-017bf00eb0d4c7182" // Microsoft Windows Server 2012 R2 64-Bits
}

variable "REGION" {
		default = "us-west-2" 
}

variable "AVAILABILITY_ZONE" {
		default = "us-west-2a"
}

variable "INSTANCE_TYPE" {
		default = "t2.2xlarge"
}

provider "aws" {
	region = "${var.REGION}"
	access_key = "${var.AWS_ACCESS_KEY}"
	secret_key = "${var.AWS_SECRET_KEY}"
}

/*
resource "aws_key_pair" "demo-key" {
	key_name = "wserver-key"
	public_key = "${var.WSERVER_KEY}"
}
*/

resource "aws_instance" "web-server" {
  ami = "${var.AMI_ID}"
  instance_type = "${var.INSTANCE_TYPE}"
  //key_name = "${aws_key_pair.mykey.key_name}"

	# VPC subnet
  subnet_id = "${aws_subnet.main-public.id}"

  # security group
  vpc_security_group_ids = ["${aws_security_group.allow-http-rdp-winrm.id}"]

	tags {
		Name = "${var.VM_NAME}"
	}

  user_data = <<EOF
<powershell>
net user ${var.INSTANCE_USERNAME} '${var.INSTANCE_PASSWORD}' /add /y
net localgroup administrators ${var.INSTANCE_USERNAME} /add
winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow
net stop winrm
sc.exe config winrm start=auto
net start winrm
</powershell>
EOF

/*
  provisioner "file" {
    source = "configuration.ps1"
    destination = "C:/temp/configuration.ps1"
  }

	provisioner "remote-exec" {
		inline = [
      "powershell.exe -File C:\\temp\\configuration.ps1"
    ]
  }
	*/

	# Move DSC Files
	provisioner "file" {
    source = "DSC/"
    destination = "C:/temp"
  }

	# Execute Powershell DSC
	provisioner "remote-exec" {
    inline = [
      "powershell.exe -File C:\\temp\\Start-DSC-Configuration-Demo.ps1"
    ]
  }

  connection {
    type = "winrm"
    timeout = "10m"
    user = "${var.INSTANCE_USERNAME}"
    password = "${var.INSTANCE_PASSWORD}"
  }
}