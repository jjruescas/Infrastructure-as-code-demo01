# Infrastructure-as-code-demo01

Hi, this project presents an example of a Windows EC2 instance in AWS, provisioned using Terraform and configured using Powershell DSC and Chocolatey.

The Windows EC2 Instace in this example is customized to add an Administrator User that you can use to RDP into the instance once it's gets provisioned.

About the configuration, there are two parts:
   1. The DSC (Powershell Desired State Configuration) file in the  will install IIS into the EC2 Instance.
   2. The configuration.ps1 file will download Chocolatey and use it to install Git, Google Chrome and Notepad++.

This demo uses:
* [Amazon Web Services](https://aws.amazon.com) (AWS)
* [Terraform](https://www.terraform.io/)
* [Desired State Configuration](https://docs.microsoft.com/en-us/powershell/dsc/overview)
* [Chocolatey](https://chocolatey.org/)

## What you'll need

1. In case you don't know how to get your AWS Secret Key and ID, you can learn Amazon's docs [here](http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html) and also in this [video](https://www.youtube.com/watch?v=Jgqgie_vhig). 
2. 

## What you'll need
