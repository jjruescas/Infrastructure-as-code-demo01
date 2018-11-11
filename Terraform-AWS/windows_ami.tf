data "aws_ami" "windows_ami" {
    most_recent      = true
    
    filter {
        name   = "owner-alias"
        values = ["amazon"]
    }

    filter {
        name   = "name"
        values = ["${var.AMI_EXPRESSION_NAME}"]
    }
}