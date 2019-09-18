param (
    [string]$blobContainerName
)

Set-Location $PSScriptRoot

$directories=''
$copyOutput=@()

ForEach ($directory in $directories)
{
    write-host "directory: $directory"

    $directoryOutput += invoke-expression "&'.\copy-folder-to-azure-blob.ps1' -localDirectory 'C:\...\$directory' -blobContainerName $blobContainerName"

    write-host $directoryOutput

    $copyOutput += $directoryOutput
}

invoke-expression "&'.\send-email.ps1' -subject 'Backup Report' -body 'copy-to-azure-blob output: $copyOutput'"
