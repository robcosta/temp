$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"
$Username = "costaemendes1010@gmail.com"
$Password = "mendes0535"

$to = "robertocosta66@live.com"
#$cc = "destinatariocopia@dominio.com.br"
#$bcc = "destinatariocopiaoculta@dominio.com.br"
$subject = "NFe da Mendes & Mendes"
$body = "Segue em anexo as NFe's da Mendes & Mendes referentes ao mes passado.

Att,
Zilma Mendes"

$message = New-Object System.Net.Mail.MailMessage
$message.subject = $subject
$message.from = $username
$message.to.add($to)
#$message.cc.add($cc)
#$message.cc.add($bcc)
#$message.attachments.add($attachment1)
#$message.attachments.add($attachment2)

# Verifica a existencia do anexo CF-e.rar antes de enviar
if (test-path -path "C:\Temp\CF-e.rar") {
    $attachment1 = "C:\Temp\CF-e.rar"
    $message.attachments.add($attachment1)
}

# Verifica a existencia do anexo CF-e Cancelados.rar antes de enviar
if (test-path -path "C:\Temp\CF-e Cancelados.rar") {
    $attachment2 = "C:\Temp\CF-e Cancelados.rar"
    $message.attachments.add($attachment2)
}


$message.body = $body

$smtp = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort);
$smtp.EnableSSL = $true
$smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);



try {
    $smtp.send($message)
}catch [Exception]{
    write-host " Erro ao enviar o e-mail. Verifique sua conexao com a internet"
    #Write-Host $_.ScriptStackTrace
    break
}
write-host "  E-mail Enviado com sucesso!"




#PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "Notas_Fiscais2.ps1" -Verb RunAs
#C:\SGBR\Master\Arquivos SAT