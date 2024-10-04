<#
.SYNOPSIS
    Entfernt ein evtl. in der angegebenen Websitesammlung installiertes Banner.


.PARAMETER siteUrl
    Die Url der Website, von der das Banner entfernt werden soll.


.EXAMPLE
    remove-banner.ps1 -siteUrl "https://contoso.sharepoint.com/sites/contoso"
#>

param
(
    [Parameter(Mandatory=$true)]
    [string]$siteUrl
)

Connect-PnPOnline -Url $siteUrl -CurrentCredentials

$componentId = "3eac1394-ff4e-42a5-94b9-db55f911f9a1"

$uca = Get-PnPCustomAction -Scope Site | Where-Object {$_.ClientSideComponentId -eq $componentId}                    
if ($uca)
{
    try
    {
        Remove-PnPCustomAction -Identity $uca.Id -Scope Site -Confirm:$false -ErrorAction Stop
        Write-Host "Das Banner wurde entfernt." -ForegroundColor Green
    }
    catch
    {
        Write-Host $_.Exception.ToString() -ForegroundColor Red
    }
}
