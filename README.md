# Infrastructure-as-code-demo01

Hi! This project presents an example of a Windows EC2 instance in AWS, provisioned using Terraform and configured using Powershell DSC and Chocolatey.

The Windows EC2 Instace in this example is customized to add an Administrator User that you can use to RDP into the instance once it's gets provisioned.

About the configuration, there are two parts:
   1. The DSC (Powershell Desired State Configuration) file in the  will install IIS into the EC2 Instance.
   2. The configuration.ps1 file will download Chocolatey and use it to install Git, Google Chrome and Notepad++.

This demo uses:
* [Amazon Web Services](https://aws.amazon.com) (AWS)
* [Terraform](https://www.terraform.io/)
* [Desired State Configuration](https://docs.microsoft.com/en-us/powershell/dsc/overview)
* [Chocolatey](https://chocolatey.org/)

_**Note**: You can run this example using a t2.micro instance, but it may take about an hour to execute all the configurations._

## What you'll need

1. An [AWS](https://aws.amazon.com) account.
2. In case you don't know how to get your AWS Secret Key and ID, you can learn Amazon's docs [here](http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html) and also in this [video](https://www.youtube.com/watch?v=Jgqgie_vhig). 
3. Terraform [installed](https://www.terraform.io/intro/getting-started/install.html) in your local computer.
4. An [AWS Region and Availability Zone](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html) where you want to provision the EC2 Instance and a Windows AMI ID that you want to use that belongs to that Region. You can find an AMI ID using AWS Console or through AWS CLI ([AWS Login](https://youtu.be/0BkX3m1yZnE?t=302) and [AWS Get AMI ID](https://stackoverflow.com/questions/43069988/get-the-latest-windows-2012r2-base-ami-id-using-aws-cli) examples).

## Let's do this!
1. Download this project in your local computer (or clone it if you have Git).
2. In terraform.tfvars update the followin variables with your own values: AWS_ACCESS_KEY, AWS_SECRET_KEY, REGION, AVAILABILITY_ZONE, AMI_ID. Optionally you can also customize INSTANCE_TYPE, VM_NAME, INSTANCE_USERNAME and INSTANCE_PASSWORD.
3. In a commad line run this only the first time:<br>
`> terraform init`
4. Run this to start the provisioning and configuration of your infrastructure:<br>
`> terrafrom apply`

...voilà! That's it!<br>
Wait until terraform finishes doing its magic and you'll see in the Console an Output Variable called "web_server_address". Browse to that location and that means you have a Windows IIS WebServer ready to go.



