data "aws_ami" "windows_ami" {
    most_recent      = true
    
    filter {
        name   = "owner-alias"
        values = ["amazon"]
    }

    filter {
        name   = "name"
        values = ["Windows_Server-2016-English-Full-Base*"]
    }
}