param(
    [string]$localDirectory,
    [string]$localFileName,
    [string]$blobContainerName,
    $blobStorageAccount = "",
    $sasToken=""
)

$blobUrl="https://$blobStorageAccount.blob.core.windows.net/$blobContainerName/$localFileName$sasToken"

$env:AZCOPY_CRED_TYPE = "Anonymous";
./azcopy.exe copy "$localDirectory\$localFileName" "$blobUrl" --overwrite=true --follow-symlinks --recursive --from-to=LocalBlob --blob-type=BlockBlob --put-md5;
$env:AZCOPY_CRED_TYPE = "";
