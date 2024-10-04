<#
.SYNOPSIS
    Fügt der angegebenen Website ein Banner hinzu.

.DESCRIPTION
    Dieses Skript fügt der angegebenen Website ein Banner hinzu. Der Banner wird oben auf der Website angezeigt und enthält den angegebenen Text.

.PARAMETER siteUrl
    Die Url der Website, der das Banner hinzugefügt werden soll.

.Parameter bannerText
    Der Text, der im Banner angezeigt werden soll.

.EXAMPLE
    add-banner.ps1 -siteUrl "https://contoso.sharepoint.com/sites/contoso" -bannerText "Das wird aber nur auf den Modern Pages angezeigt"
#>

param
(
    [Parameter(Mandatory=$true)]
    [string]$siteUrl,
    [Parameter(Mandatory=$true)]
    [string]$bannerText
)

Connect-PnPOnline -Url $siteUrl -CurrentCredentials

# Prüfen, ob die Komponente schon hinzugefügt wurde
$componentId = "3eac1394-ff4e-42a5-94b9-db55f911f9a1"

$uca = Get-PnPCustomAction -Scope Site | Where-Object {$_.ClientSideComponentId -eq $componentId}                    
if ($uca)
{
    Remove-PnPCustomAction -Identity $uca.Id -Scope Site -Confirm:$false
}

$parameters = @{
    "bannerText" = $bannerText
}
$parameterJson = ConvertTo-Json $parameters

$location = "ClientSideExtension.ApplicationCustomizer"

try
{
    Add-PnPCustomAction -Location $location -ClientSideComponentId $componentId -ClientSideComponentProperties $parameterJson  -Scope Site -Name "Banner" -Title "Banner" -ErrorAction Stop
    Write-Host "Das Banner wurde der Website hinzugefügt." -ForegroundColor Green
}
catch
{
    Write-Host $_.Exception.ToString() -ForegroundColor Red
}

