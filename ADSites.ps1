<#
.SYNOPSIS
    Export AD Site and Subnet Detail and output export into CSV file.

.DESCRIPTION
    This script requires the active directory module to run.

    It exports the AD Site Name and Subnets in a CSV file 
   

.EXAMPLE
.\Get-ADSites.ps1
    Will run the script and export the AD Site Name and Subnets details 

.NOTES
Function by Gautam Sharma
v1.0 - 07/27/2018
#>

Import-Module .\TestExchangeADTool.psm1
Test-ADTools

$Sites = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest().Sites           
$obj = @() 
foreach ($Site in $Sites) {            

 $obj += New-Object -Type PSObject -Property (            
  @{            
   "SiteName"  = $site.Name            
   "SubNets" = $site.Subnets -Join ";"         
   "Servers" = $Site.Servers -Join ";"
  }            
 )            
}
$obj | Export-Csv -NoTypeInformation ADSite.csv