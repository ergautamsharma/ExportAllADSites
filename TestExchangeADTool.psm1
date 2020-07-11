<#
.SYNOPSIS
    Testing the Exchange & AD tool installed.

.DESCRIPTION
    This script requires the basic Powershell.
    
.NOTES
Function by Gautam Sharma
v1.0 - 08/28/2018 - Draft 

#>
[cmdletbinding()]
param()

Function Test-ExchTools(){
    Try
    {
        $ExVerbose = "Loading Exchange 2010 snapins enabling script to be executed on a basic Powershell session"
        Write-Verbose $ExVerbose
        $ExDebug = "You must have Exchange Admin tools installed on this machine."
        Write-Debug $ExDebug
        Add-PSSnapin microsoft.exchange.management.powershell.admin -erroraction 'SilentlyContinue' | OUT-NULL
        Add-PSsnapin Microsoft.Exchange.Management.PowerShell.E2010 -erroraction 'SilentlyContinue' | OUT-NULL
        Add-PSsnapin Microsoft.Exchange.Management.PowerShell.Setup -erroraction 'SilentlyContinue'  | OUT-NULL
        Add-PSsnapin Microsoft.Exchange.Management.PowerShell.Support -erroraction 'SilentlyContinue'  | OUT-NULL
        Get-command Get-mailbox -ErrorAction Stop
        $ExchInstalledStatus = $true
        $Message = "Exchange tools are present !"
        Write-Host $Message -ForegroundColor Blue -BackgroundColor White
    }
    Catch [System.SystemException]
    {
        $ExchInstalledStatus = $false
        $Message = "Exchange Tools are not present !"
        Write-Host $Message -ForegroundColor red -BackgroundColor White
        Exit
    }
    Return $ExchInstalledStatus
}

Function Test-ADTools(){
    Try
    {
        $AdVerbose = "importing Active Directory Module to enabling script to be executed on a basic Powershell session"
        Write-Verbose $AdVerbose
        $ADDebug = "you must have Remote Server Administration Tools installed on this machine."
        Write-Debug $ADDebug
        #import-module activedirectory -ErrorAction SilentlyContinue
        Get-command Get-ADUser -ErrorAction Stop
        $ADInstalledStatus = $true
        $Message = "AD tools are present !"
        Write-Host $Message -ForegroundColor Blue -BackgroundColor White
    }
    Catch [System.SystemException]
    {
        $ADInstalledStatus = $false
        $Message = "AD Tools are not present !"
        Write-Host $Message -ForegroundColor red -BackgroundColor White
        Exit
    }
    Return $ADInstalledStatus
}