$Items = import-csv C:\*************.csv # Path csv file

$Items | ForEach-Object {
  $SamAccountName = $_.sAmAccountName
  $Groups = ($_.removegroups).split(";")
  foreach ($Group in $Groups)
  {
    "Removing $SamAccountName to the following group: $Group"
     Remove-ADGroupMember -Identity $Group $SamAccountName -Confirm:$false
  }      
}
