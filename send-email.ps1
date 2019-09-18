param (
    [string]$subject,
    [string]$body,
    $from = "",
    $tos = (""),
    $hostServer = "smtp.gmail.com",
    $pass = "",
    $isBodyHTML = $true
)

$smtp = new-object Net.Mail.SmtpClient($hostServer) 
$smtp.EnableSsl = $true 

$msg = new-object Net.Mail.MailMessage 
$msg.From = $from
foreach ($to in $tos)
{
    $msg.To.Add("$to") 
}
$msg.BodyEncoding = [system.Text.Encoding]::Unicode 
$msg.SubjectEncoding = [system.Text.Encoding]::Unicode 
$msg.IsBodyHTML = $isBodyHTML
$msg.Subject = $subject
$enc=[System.Text.Encoding]::ASCII
$bytes=$enc.GetBytes($body);
$msg.Body = $enc.GetString($bytes)

$smtp.Credentials = new-object System.Net.NetworkCredential("$from", "$pass"); # Get-Credential
$smtp.Send($msg)
