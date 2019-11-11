# Script baslangici 
#// CSV dosyasi icin yil ve ay verisini hazirliyoruz.
$DateTime = Get-Date -f "yyyy-MM" 
 
#// CSV dosyasinin adini tanimliyoruz. 
$CSVFile = "C:\Temp\AD_Groups_"+$DateTime+".csv" 
 
#// CSV datasi için bos bir array olusturuyoruz. 
$CSVOutput = @() 
 
#// Domain icindeki AD Gruplarini cekiyoruz. 
$ADGroups = Get-ADGroup -Filter * 
 
#// Progress bar icin degisken tanimliyoruz. 
$i=0 
$tot = $ADGroups.count 
 
foreach ($ADGroup in $ADGroups) { 
    #// Progress bari hazirliyoruz 
    $i++ 
    $status = "{0:N0}" -f ($i / $tot * 100) 
    Write-Progress -Activity "Exporting AD Groups" -status "Processing Group $i of $tot : $status% Completed" -PercentComplete ($i / $tot * 100) 
 
    #// Grup uyelerinin degiskenini tanimliyoruz. 
    $Members = "" 
 
    #// AD Grup uyelerini cekiyoruz. 
    $MembersArr = Get-ADGroup -filter {Name -eq $ADGroup.Name} | Get-ADGroupMember |  select Name 
    if ($MembersArr) { 
        foreach ($Member in $MembersArr) { 
            $Members = $Members + "," + $Member.Name 
        } 
        $Members = $Members.Substring(1,($Members.Length) -1) 
    } 
 
    #// Hash table tanimliyoruz ve deger giriyoruz. 
    $HashTab = $NULL 
    $HashTab = [ordered]@{ 
        "Name" = $ADGroup.Name 
        "Category" = $ADGroup.GroupCategory 
        "Scope" = $ADGroup.GroupScope 
        "Members" = $Members 
    } 
 
    #// CSV'ye Hash table tanimliyoruz.  
    $CSVOutput += New-Object PSObject -Property $HashTab 
} 
 
#// CSV dosyasini export ediyoruz. 
$CSVOutput | Sort-Object Name | Export-Csv $CSVFile -NoTypeInformation 
 
#// Script Sonu