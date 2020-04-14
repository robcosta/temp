$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"
$Username = "costaemendes1010@gmail.com"
$Password = "costa0535"
$mes = get-date -Uformat %m
$ano =  get-date -Uformat %Y
If($mes -eq 1){
    $mes = 11
    $ano = $ano-1
} Else {
    $mes = $mes -2
}
$meses = 'Janeiro','Fevereiro','Marco','Abril','Maio','Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro','Novembro', 'Dezembro'

$to = "robertocosta66@live.com"
$cc = "fiscal@quantcontabil.com"
#$bcc = "destinatariocopiaoculta@dominio.com.br"
$subject = "CFe's - Costa & Mendes  - "+$meses[$mes]+" - "+$ano
$body = "Seguem em anexo as CFe's da Costa & Mendes referentes ao mes de "+$meses[$mes]+" de "+$ano+".

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
    write-host "Erro ao enviar o e-mail. Verifique sua conexao com a internet" 
    #Write-Host $_.ScriptStackTrace
    break
}
write-host "E-mail Enviado com sucesso para" $to "e" $cc




#PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "Notas_Fiscais2.ps1" -Verb RunAs
#C:\SGBR\Master\Arquivos SAT