Configuration DscWebServer 
{
    param
    (
        [string]$NodeName = $ENV:computername
    )
  
    Import-DscResource -Module PSDesiredStateConfiguration
	
	Node $NodeName
	{
        WindowsFeature IIS {
            Ensure = "Present"
            Name = "Web-Server"
        }
        WindowsFeature IISManagementTools
        {
            Ensure = "Present"
            Name = "Web-Mgmt-Tools"
            DependsOn='[WindowsFeature]IIS'
        }

        
        <# ############ Additional Configurations ############
        Import-DscResource -Module xComputerManagement 
        Import-DscResource -Module xRemoteDesktopAdmin 
        Import-DSCResource -Module xSystemSecurity 
        Import-DscResource -Module xPSDesiredStateConfiguration 
        Import-DscResource -Module PSDesiredStateConfiguration 

        xUAC DisableUAC
        {
            Setting = "NeverNotifyAndDisableAll"
        }

		xRemoteDesktopAdmin EnableRemoteDesktop
        {
           Ensure = 'Present'
           UserAuthentication = 'Secure'
        }

        ############
        # Features #
        ############

		#Ensures .Net-Framework 3.5 is present
		xWindowsFeature Net-Framework-Core
        {
            Ensure = "Present"
            Name = "Net-Framework-Core"
        }

		#Ensures .Net-Framework 4.5 is present
		xWindowsFeature Net-Framework-45-Core
        {
            Ensure = "Present"
            Name = "Net-Framework-45-Core"
        }     

        # ASP.NET 4.5
		xWindowsFeature NET-Framework-45-ASPNET
        {
            Ensure = "Present"
            Name = "NET-Framework-45-ASPNET"
        } 

        ####################
        # Management Tools #
        ####################

        # IIS Management Console
        xWindowsFeature Web-Mgmt-Console
        {
            Ensure = "Present"
            Name = "Web-Mgmt-Console"
        }

        # Management Service
        xWindowsFeature Web-Mgmt-Service
        {
            Ensure = "Present"
            Name = "Web-Mgmt-Service"
        } 

        ##############
        # Web Server #
        ##############

        ## Application Developmen ##
        
        # ASP
        xWindowsFeature Web-ASP
        {
            Ensure = "Present"
            Name = "Web-ASP"
        }

        # ASP.NET 3.5
        xWindowsFeature Web-Asp-Net
        {
            Ensure = "Present"
            Name = "Web-Asp-Net"
        }

        # ASP.NET 4.5
        xWindowsFeature Web-Asp-Net45
        {
            Ensure = "Present"
            Name = "Web-Asp-Net45"
        }

        # CGI
        xWindowsFeature Web-CGI
        {
            Ensure = "Present"
            Name = "Web-CGI"
        }

        # ISAPI Extensions
        xWindowsFeature Web-ISAPI-Ext
        {
            Ensure = "Present"
            Name = "Web-ISAPI-Ext"
        }

        # ISAPI Filters
        xWindowsFeature Web-ISAPI-Filter
        {
            Ensure = "Present"
            Name = "Web-ISAPI-Filter"
        }

        # .NET Extensibility 3.5
        xWindowsFeature Web-App-Dev
        {
            Ensure = "Present"
            Name = "Web-App-Dev"
        }

        # .NET Extensibility 4.5
        xWindowsFeature Web-Net-Ext45
        {
            Ensure = "Present"
            Name = "Web-Net-Ext45"
        }

        ## Common HTTP Features ##

        # Default Document
        xWindowsFeature Web-Default-Doc
        {
            Ensure = "Present"
            Name = "Web-Default-Doc"
        }

        # Directory Browsing
        xWindowsFeature Web-Dir-Browsing
        {
            Ensure = "Present"
            Name = "Web-Dir-Browsing"
        }

        # HTTP Errors
        xWindowsFeature Web-Http-Errors
        {
            Ensure = "Present"
            Name = "Web-Http-Errors"
        }

        # Static Content
        xWindowsFeature Web-Static-Content
        {
            Ensure = "Present"
            Name = "Web-Static-Content"
        }

        ## Health and Diagnostics ##

        # HTTP Logging
        xWindowsFeature Web-Http-Logging
        {
            Ensure = "Present"
            Name = "Web-Http-Logging"
        }

        ## Performance ##

        # Static Content Compression
        xWindowsFeature Web-Stat-Compression
        {
            Ensure = "Present"
            Name = "Web-Stat-Compression"
        }

        ## Security ##        

        # Basic Authentication
        xWindowsFeature Web-Basic-Auth
        {
            Ensure = "Present"
            Name = "Web-Basic-Auth"
        }

        # IIS Client Certificate Mapping Authentication
        xWindowsFeature Web-Cert-Auth
        {
            Ensure = "Present"
            Name = "Web-Cert-Auth"
        }

        # Centralized SSL Certificate Support
        xWindowsFeature Web-CertProvider
        {
            Ensure = "Present"
            Name = "Web-CertProvider"
        }

        # Client Certificate Mapping Authentication
        xWindowsFeature Web-Client-Auth
        {
            Ensure = "Present"
            Name = "Web-Client-Auth"
        }

        # Request Filtering
        xWindowsFeature Web-Filtering
        {
            Ensure = "Present"
            Name = "Web-Filtering"
        }        

        # Windows Authentication
        xWindowsFeature Web-Windows-Auth
        {
            Ensure = "Present"
            Name = "Web-Windows-Auth"
        }
        #>
	}	
}