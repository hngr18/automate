param (
    [string]$subject,
    [string]$body,
    $from = "duplicate@virtualnet.co.uk",
    $to = "support@virtualnet.co.uk",
    $hostServer = "smtp.gmail.com",
    $pass = "",
    $isBodyHTML = $true
)

$smtp = new-object Net.Mail.SmtpClient($hostServer) 
$smtp.EnableSsl = $true 

$msg = new-object Net.Mail.MailMessage 
$msg.From = $from
$msg.To.Add("$to") 
$msg.BodyEncoding = [system.Text.Encoding]::Unicode 
$msg.SubjectEncoding = [system.Text.Encoding]::Unicode 
$msg.IsBodyHTML = $isBodyHTML
$msg.Subject = $subject
$msg.Body = $body
$smtp.Credentials = New-Object System.Net.NetworkCredential("$from", "$pass"); # Get-Credential
$smtp.Send($msg)