param(
    [string]$localDirectory,
    [string]$blobContainerName,
    $blobStorageAccount = "",
    $sasToken=""
)

$blobUrl="https://$blobStorageAccount.blob.core.windows.net/$blobContainerName/$sasToken"

$env:AZCOPY_CRED_TYPE = "Anonymous";

./azcopy.exe copy $localDirectory "$blobUrl" --overwrite=false `
--follow-symlinks --recursive --from-to=LocalBlob --blob-type=BlockBlob --put-md5 2>&1

$env:AZCOPY_CRED_TYPE = "";
