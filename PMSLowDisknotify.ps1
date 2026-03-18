$MinSpace = 10GB
$MinPercent = 0.10
$MailFrom = "YOUR_GMAIL_ADDRESS"
$AppPwd = "YOUR_GMAIL_APP-PWD"
$MailTo = "RECIPIENT_EMAIL_ADDRESS"

$Drives = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"
# Choose which method to determine the low disk space, the first determines on available GB and the second uses available %
#$LowD = $Drives | Where-Object { $_.FreeSpace -lt $MinSpace }
# I selected by available % where 0.10 is 10%
$LowD = $Drives | Where-Object { ($_.FreeSpace / $_.Size) -lt $MinPercent }

if ($LowD) {
	$Rep = $LowD | Select-Object @{n='Drive';e={$_.DeviceID}}, 
        @{n='Volume';e={$_.VolumeName}},
        @{n='Size(GB)';e={[math]::Round($_.Size / 1GB, 2)}}, 
		@{n='Free(GB)';e={[math]::Round($_.FreeSpace / 1GB, 2)}}, 
        @{n='Used(%)';e={[math]::Round((1 - ($_.FreeSpace / $_.Size)) * 100, 2)}}
	$Res = "PLEX MEDIA SERVER LOW DRIVE SPACE NOTIFICATION`n`n"
	$Res += "This message is to notify you that your Plex Media Server is running low on disk space.`n"
	$Res += "Notification`n"
	$Res += $Rep | ft | out-string
    
    $sAppPwd = ConvertTo-SecureString $AppPwd -AsPlainText -Force
    $Creds = New-Object System.Management.Automation.PSCredential ($MailFrom, $sAppPwd)
    #write-host $Res
    Send-MailMessage -To $MailTo -From $MailFrom -Subject "PMS DISK ALERT" -Body $Res -SmtpServer "smtp.gmail.com" -Port 587 -Usessl -Credential $Creds
}
