#aws.tf
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "VM_NAME" {}
variable "INSTANCE_USERNAME" {}
variable "INSTANCE_PASSWORD" {}
variable "AMI_ID" {}
variable "REGION" {}
variable "AVAILABILITY_ZONE" {}
variable "INSTANCE_TYPE" {}

provider "aws" {
	region = "${var.REGION}"
	access_key = "${var.AWS_ACCESS_KEY}"
	secret_key = "${var.AWS_SECRET_KEY}"
}

resource "aws_instance" "web-server" {
  ami = "${var.AMI_ID}"
  instance_type = "${var.INSTANCE_TYPE}"

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

  provisioner "file" {
    source = "../Configuration/configuration.ps1"
    destination = "C:/temp/configuration.ps1"
  }

	provisioner "remote-exec" {
		inline = [
      "powershell.exe -File C:\\temp\\configuration.ps1"
    ]
  }

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