$Hostname = hostname

$hotfixes = "KB4012212", "KB4012217", "KB4015551", "KB4019216", "KB4012216", "KB4015550", "KB4019215", "KB4013429", "KB4019472", "KB4015217", "KB4015438", "KB4016635"

$hotfix = Get-HotFix -ComputerName $Hostname | Where-Object {$hotfixes -contains $_.HotfixID} | Select-Object -property "HotFixID"

if (Get-HotFix | Where-Object {$hotfixes -contains $_.HotfixID} )

{

"Bulunan güncelleme: " + $hotfix.HotFixID

$hotfixobj = New-Object -TypeName psobject

$hotfixobj | Add-Member -Name Hostname -Value $Hostname -MemberType NoteProperty

$hotfixobj | Add-Member -Name HotFixID -Value $hotfix.HotFixID -MemberType NoteProperty

Export-Csv -Path "**************" -NoTypeInformation -Encoding UTF8 -InputObject $hotfixobj -Append # CSV Path

} else {

$hotfixobj = New-Object -TypeName psobject

$hotfixobj | Add-Member -Name Hostname -Value $Hostname -MemberType NoteProperty

$hotfixobj | Add-Member -Name HotFixID -Value "Güncelleme yüklü deðil." -MemberType NoteProperty

Export-Csv -Path "***************" -NoTypeInformation -Encoding UTF8 -InputObject $hotfixobj -Append # CSV Path

}
