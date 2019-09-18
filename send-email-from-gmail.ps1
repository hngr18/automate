$from = "duplicate@virtualnet.co.uk"
$to = "ken@virtualnet.co.uk"
$pass = ""

$smtpServer = "smtp.gmail.com"  
$smtp = new-object Net.Mail.SmtpClient($smtpServer) 
$smtp.EnableSsl = $true 

$msg = new-object Net.Mail.MailMessage 
$msg.From = $from
$msg.To.Add("$to") 
$msg.BodyEncoding = [system.Text.Encoding]::Unicode 
$msg.SubjectEncoding = [system.Text.Encoding]::Unicode 
$msg.IsBodyHTML = $true  
$msg.Subject = "Test mail from PS" 
$msg.Body = "<h2> Test mail from PS </h2> 
</br> 
Hi there 
"  
$smtp.Credentials = New-Object System.Net.NetworkCredential("$from", "$pass"); # Get-Credential
$smtp.Send($msg)
