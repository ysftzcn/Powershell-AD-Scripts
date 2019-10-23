# Import active directory module for running AD cmdlets
Import-Module activedirectory
  
#Store the data from ADUsers.csv in the $ADUsers variable
$ADUsers = Import-csv C:\****************************.csv # Path for csv


#Loop through each row containing user details in the CSV file 
foreach ($User in $ADUsers)
{

	#Read user data from each field in each row and assign the data to a variable as below
		
	$GivenName 	= $User.Givenname
	$Surname	= $User.Surname
	$SamAccountName	= $User.sAmAccountName
	$Name 		= $User.Name
	$DisplayName	= $User.displayName
	$Department	= $User.department
	$Password 	= $User.Password
	$Description	= $User.description
	$EmailAddress = $User.EmailAddress
	$OU		= "***************" # Organization Unit

	#Check to see if the user already exists in AD
	if (Get-ADUser -F {SamAccountName -eq $sAmAccountName})
	{
		 #If user does exist, give a warning
		 Write-Warning "A user account with username $DisplayName already exist in Active Directory."
	}
	else
	{

         $write = "Importing account " + $DisplayName + " ..."
        Write-Host $write

		#User does not exist then proceed to create the new user account
		
        #Account will be created in the OU provided by the $OU variable read from the CSV file
		New-ADUser `
            -SamAccountName $sAmAccountName `
			-UserPrincipalName "$sAmAccountName@********" ` #Domain Name 
            -Name $Name `
            -GivenName $Givenname `
            -Surname $Surname `
            -Enabled $True `
            -PasswordNeverExpires $True `
            -DisplayName $displayName `
			-Department $department `
			-Description $description `
			-EmailAddress $EmailAddress `
            -Path $OU `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force)
            
            
	}
}
