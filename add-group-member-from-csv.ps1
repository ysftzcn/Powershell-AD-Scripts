$Items = Import-Csv C:\********.csv # path csv file

$Items | ForEach-Object {
     $SamAccountName = $_.sAmAccountName
     $Groups = ($_.groups).split(";")
     foreach ($Group in $Groups)
    {
     "Adding $SamAccountName to the following group: $Group"
      Add-ADGroupMember $Group -Members $SamAccountName
    }

    }