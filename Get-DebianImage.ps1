[CmdletBinding()]
param(
    [string]$OutputPath
)

$ErrorActionPreference = 'Stop'

# Note: Github removed TLS 1.0 support. Enables TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 'Tls12'

$imageVersion = '20200928-407'
$urlRoot = "https://cloud.debian.org/images/cloud/buster/$imageVersion"

# genericcloud image won't boot in Hyper-V (!?)
$urlFile = "debian-10-generic-amd64-$imageVersion.qcow2"

$url = "$urlRoot/$urlFile"
        
if (-not $OutputPath) {
    $OutputPath = Get-Item '.\'
}

$imgFile = Join-Path $OutputPath $urlFile

if ([System.IO.File]::Exists($imgFile)) {
    Write-Verbose "File '$imgFile' already exists. Nothing to do."
} else {
    Write-Verbose "Downloading file '$imgFile'..."

    $client = New-Object System.Net.WebClient
    $client.DownloadFile($url, $imgFile)

    # Debian image repository doesn't have SHA1SUMS file for integrity checks?
}

$imgFile
