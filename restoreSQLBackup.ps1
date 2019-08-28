param(
    [Parameter(Mandatory=$True)][string]$sqlServerName,
    [Parameter(Mandatory=$True)][string]$sqlUserName,
    [Parameter(Mandatory=$True)][string]$sqlPwd,
    [Parameter(Mandatory=$True)][string]$dbName,
    [Parameter(Mandatory=$True)][string]$backupPath
)

[System.Reflection.Assembly]::LoadWithPartialName('System.Data.SqlClient')
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO')
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SmoExtended')

$connectionString = "Server=$sqlServerName;Integrated Security=True;"

$sqlConnection = new-object ('System.Data.SqlClient.SqlConnection') $connectionString
$sqlServer = new-object ('Microsoft.SqlServer.Management.Smo.Server') $sqlConnection
$dbRestore = new-object ('Microsoft.SqlServer.Management.Smo.Restore')

$dbRestore.Database = $dbname
$dbRestore.Devices.AddDevice($backupPath, 'File')
$dbRestore.NoRecovery = $false;
$dbRestore.ReplaceDatabase = $true;
 
$dbRestore.SqlRestore($sqlServer)

Write-Progress -Activity 'Executing SQL' -Status 'Executing SQL => $sql'
Write-Host 'Executing SQL => $sql'

$sqlConnecton.Close();


function Resolve-Error ($ErrorRecord=$Error[0])
{
   $ErrorRecord | Format-List * -Force
   $ErrorRecord.InvocationInfo | Format-List *
   $Exception = $ErrorRecord.Exception
   for ($i = 0; $Exception; $i++, ($Exception = $Exception.InnerException))
   {   �$i� * 80
       $Exception | Format-List * -Force
   }
}

Resolve-Error
