resource "aws_security_group" "allow-http-rdp-winrm" {
    vpc_id = "${aws_vpc.main.id}"
    name = "allow-http-rdp-winrm"
    description = "security group that allows http, rdp and winrm and all egress traffic"
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # http - Port 80
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    # rdp - Port 3389
    ingress {
        from_port = 3389
        to_port = 3389
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # WinRM - Port 5985 
    ingress {
        from_port = 5985
        to_port = 5985
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # WinRM - Port 5986 
    ingress {
        from_port = 5986
        to_port = 5986
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }  

    tags {
        Name = "allow-http-rdp-winrm"
    }
}