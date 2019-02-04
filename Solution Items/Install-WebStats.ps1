<#
.Synopsis
   Installs the WebStats HTTP module on all local IIS sites.
.DESCRIPTION
   Installs the WebStats HTTP module on all local IIS sites.
.AUTHOR
   Jared
.UPDATED
   February 4, 2019
#>

$ErrorActionPreference = "Stop"

$HttpModuleBase64 = "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a19fQmFja2luZ0ZpZWxkADxSZXNwb25zZVN0cmVhbT5rX19CYWNraW5nRmllbGQAPEJ5dGVzV3JpdHRlbj5rX19CYWNraW5nRmllbGQAPFJlcXVlc3RQcm9jZXNzb3I+a19fQmFja2luZ0ZpZWxkADxIdG1sR2VuZXJhdG9yPmtfX0JhY2tpbmdGaWVsZAA8TWVhc3VyZW1lbnRzPmtfX0JhY2tpbmdGaWVsZAA8V2lkZ2V0Q29udGVudD5rX19CYWNraW5nRmllbGQAPENvbnRleHQ+a19fQmFja2luZ0ZpZWxkAFJlYWRUb0VuZABQcm9jZXNzUmVxdWVzdEVuZABSZXBsYWNlAElzTnVsbE9yV2hpdGVTcGFjZQBBdmVyYWdlAEVudW1lcmFibGUASURpc3Bvc2FibGUARG91YmxlAElIdHRwTW9kdWxlAFN0YXRzTW9kdWxlAEdldE1vZHVsZVByb2Nlc3NpbmdUaW1lAEdldFJlcXVlc3RQcm9jZXNzaW5nVGltZQBnZXRfQ29udGVudFR5cGUAV2hlcmUAU3lzdGVtLkNvcmUAZ2V0X1N0YXRlU3RvcmUAc2V0X1N0YXRlU3RvcmUAc3RhdGVTdG9yZQBnZXRfUmVzcG9uc2UASHR0cFJlc3BvbnNlAERpc3Bvc2UARGVidWdnZXJCcm93c2FibGVTdGF0ZQBDbGVhbnVwQXBwbGljYXRpb25TdGF0ZQBnZXRfQ2FuV3JpdGUAQ29tcGlsZXJHZW5lcmF0ZWRBdHRyaWJ1dGUAR3VpZEF0dHJpYnV0ZQBEZWJ1Z2dhYmxlQXR0cmlidXRlAERlYnVnZ2VyQnJvd3NhYmxlQXR0cmlidXRlAENvbVZpc2libGVBdHRyaWJ1dGUAQXNzZW1ibHlUaXRsZUF0dHJpYnV0ZQBBc3NlbWJseVRyYWRlbWFya0F0dHJpYnV0ZQBUYXJnZXRGcmFtZXdvcmtBdHRyaWJ1dGUAQXNzZW1ibHlGaWxlVmVyc2lvbkF0dHJpYnV0ZQBBc3NlbWJseUNvbmZpZ3VyYXRpb25BdHRyaWJ1dGUAQXNzZW1ibHlEZXNjcmlwdGlvbkF0dHJpYnV0ZQBDb21waWxhdGlvblJlbGF4YXRpb25zQXR0cmlidXRlAEFzc2VtYmx5UHJvZHVjdEF0dHJpYnV0ZQBBc3NlbWJseUNvcHlyaWdodEF0dHJpYnV0ZQBBc3NlbWJseUNvbXBhbnlBdHRyaWJ1dGUAUnVudGltZUNvbXBhdGliaWxpdHlBdHRyaWJ1dGUAdmFsdWUAUmVtb3ZlAEdldEF2ZXJhZ2VSZXNwb25zZVNpemUATG9nUmVzcG9uc2VTaXplAEdldE1pblJlc3BvbnNlU2l6ZQBHZXRNYXhSZXNwb25zZVNpemUAcmVzcG9uc2VTaXplAFN5c3RlbS5UaHJlYWRpbmcAU3lzdGVtLlJ1bnRpbWUuVmVyc2lvbmluZwBUb1N0cmluZwBTdG9wd2F0Y2gARmx1c2gAZ2V0X0xlbmd0aABTZXRMZW5ndGgAZ2V0X0NhblNlZWsAV2ViU3RhdHMuZGxsAFdlYlN0YXRzLlJlc291cmNlcy5TdGF0c1dpZGdldC5odG1sAEdldE1hbmlmZXN0UmVzb3VyY2VTdHJlYW0AZ2V0X1Jlc3BvbnNlU3RyZWFtAHNldF9SZXNwb25zZVN0cmVhbQByZXNwb25zZVN0cmVhbQBnZXRfSXRlbQBzZXRfSXRlbQBTeXN0ZW0AVGltZVNwYW4AZ2V0X0J5dGVzV3JpdHRlbgBzZXRfQnl0ZXNXcml0dGVuAE1pbgBTZWVrT3JpZ2luAG9yaWdpbgBIdHRwQXBwbGljYXRpb24AU3lzdGVtLlJlZmxlY3Rpb24ATmFtZVZhbHVlQ29sbGVjdGlvbgBnZXRfUG9zaXRpb24Ac2V0X1Bvc2l0aW9uAFN0b3AAU3lzdGVtLkxpbnEAU3RyZWFtUmVhZGVyAFRleHRSZWFkZXIAc2VuZGVyAGJ1ZmZlcgBFdmVudEhhbmRsZXIAZ2V0X0ZpbHRlcgBzZXRfRmlsdGVyAE1lYXN1cmVtZW50RmlsdGVyAEVudGVyAGNvdW50ZXIASVJlcXVlc3RQcm9jZXNzb3IAZ2V0X1JlcXVlc3RQcm9jZXNzb3IAc2V0X1JlcXVlc3RQcm9jZXNzb3IASUh0bWxHZW5lcmF0b3IAZ2V0X0h0bWxHZW5lcmF0b3IAc2V0X0h0bWxHZW5lcmF0b3IAaHRtbEdlbmVyYXRvcgAuY3RvcgAuY2N0b3IATW9uaXRvcgBTeXN0ZW0uRGlhZ25vc3RpY3MAZ2V0X1RvdGFsTWlsbGlzZWNvbmRzAFdlYlN0YXRzLkludGVyZmFjZXMAU3lzdGVtLlJ1bnRpbWUuSW50ZXJvcFNlcnZpY2VzAFN5c3RlbS5SdW50aW1lLkNvbXBpbGVyU2VydmljZXMARGVidWdnaW5nTW9kZXMAQnVpbGREZXBlbmRlbmNpZXMARXZlbnRBcmdzAFdlYlN0YXRzLkltcGxlbWVudGF0aW9ucwBnZXRfSGVhZGVycwBXZWJTdGF0cwBJTWVhc3VyZW1lbnRzAGdldF9NZWFzdXJlbWVudHMAc2V0X01lYXN1cmVtZW50cwBtZWFzdXJlbWVudHMAQ29uY2F0AEZvcm1hdABPYmplY3QAR2V0U3RhdHNXaWRnZXQAb2Zmc2V0AEluaXQARXhpdABnZXRfV2lkZ2V0Q29udGVudABzZXRfV2lkZ2V0Q29udGVudABnZXRfQ291bnQAY291bnQATG9nTW9kdWxlU3RhcnQATG9nUmVxdWVzdFN0YXJ0AFByb2Nlc3NSZXF1ZXN0U3RhcnQAZ2V0X1JlcXVlc3QAYWRkX0VuZFJlcXVlc3QAQ29udGV4dF9FbmRSZXF1ZXN0AGFkZF9CZWdpblJlcXVlc3QAQ29udGV4dF9CZWdpblJlcXVlc3QASHR0cFJlcXVlc3QAR2V0UmVzcG9uc2VTaXplc0xpc3QAZ2V0X0NvbnRleHQAY29udGV4dABTdGFydE5ldwBNYXgAQ29udGFpbnNLZXkAR2V0RXhlY3V0aW5nQXNzZW1ibHkAb3BfRXF1YWxpdHkAAAAAR1cAZQBiAFMAdABhAHQAcwAuAFIAZQBzAG8AdQByAGMAZQBzAC4AUwB0AGEAdABzAFcAaQBkAGcAZQB0AC4AaAB0AG0AbAAAI3sAbQBpAG4AUgBlAHMAcABvAG4AcwBlAFMAaQB6AGUAfQAADXsAMAA6AG4AMAB9AAArewBhAHYAZQByAGEAZwBlAFIAZQBzAHAAbwBuAHMAZQBTAGkAegBlAH0AAAt7ADAAOgBuAH0AACN7AG0AYQB4AFIAZQBzAHAAbwBuAHMAZQBTAGkAegBlAH0AABl7AG0AbwBkAHUAbABlAFQAaQBtAGUAfQAAG3sAcgBlAHEAdQBlAHMAdABUAGkAbQBlAH0AABdNAG8AZAB1AGwAZQBTAHQAYQByAHQAABNOAG8AdAAgAEYAbwB1AG4AZAAADXsAMAA6AG4ANAB9AAAZ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AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAwAAAAoPAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
$ModuleBytes = [System.Convert]::FromBase64String($HttpModuleBase64)

# Determine if the script is running with elevated permissions (e.g. Run as Administrator).
function Is-Administrator() {
    $Identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $Principal = New-Object System.Security.Principal.WindowsPrincipal -ArgumentList $Identity
    return $Principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}


#region Startup checks

if ([System.Environment]::Is64BitProcess -eq $false){
    Write-Host "This script requires the 64-bit version of PowerShell.  Please relaunch in 64-bit."
    pause
    return
}

try {
    Get-Command -Name "Get-Website" | Out-Null
}
catch {
    Write-Host "It appears some required cmdlets are missing.  Please make sure the WebAdministration module is installed."
    pause
    return
}


if ((Is-Administrator) -eq $false) {
	Write-Host "Install script requires elevation (e.g. Run as Administrator).  Attempting to self-elevate..."
	Start-Sleep -Seconds 3
	$param = "-f `"$($MyInvocation.InvocationName)`""
	foreach ($arg in $ArgList){
		$param += " $arg"
	}
	Start-Process -FilePath powershell.exe -ArgumentList "$param" -Verb RunAs
	exit
}

#endregion


# Add WebStats module to each IIS website.
[PSCustomObject[]]$Sites = Get-Website
foreach ($site in $Sites) {
    $existingModule = Get-WebConfiguration -PSPath "IIS:\Sites\$($site.name)" -Filter "/system.webServer/modules/add[@name='WebStats']"
    if ($existingModule -eq $null){
        Add-WebConfiguration -PSPath "IIS:\Sites\$($site.name)" -Filter "/system.webServer/modules" -Value @{name="WebStats"; type="WebStats.StatsModule"}
    }

    $modulePath = [System.Environment]::ExpandEnvironmentVariables($site.physicalPath + "\bin\WebStats.dll")
    [System.IO.File]::WriteAllBytes($modulePath, $ModuleBytes)
}
