$computers = Get-Content -Path C:\Local_Pass\hosts.txt
$username = "Administrator" # Specific user
$password = "Password" # User password

# Lists to store success / failed attempts
$success = New-Object System.Collections.Generic.List[string]
$failure = New-Object System.Collections.Generic.List[string]


foreach ($computer in $computers) {
    # Attempt to change the password on the computer, ignoring any errors
    try {
        ([ADSI] "WinNT://$computer/$username").SetPassword("$password")
    } catch {}
    # On success:
    if ($?) { 
        $success.Add($computer)
        Write-Host "Success: $computer" -ForegroundColor Green
    }
    # On failure:
    else { 
        $failure.Add($computer)
        Write-Host "Failure: $computer" -ForegroundColor Red
    }
}

# Uncomment to export results to a file:
#$success | Out-File "C:\success.txt"
#$failure | Out-File "C:\failure.txt"