$DLNames =@("itshostadcs", "itshostadops", "DBARole", "itssqleng", "ITSHostSQLOps" )
$Allusers = @()
$date = get-date -Format ("yyyy/MM/dd")

Foreach($DLName in $DLNames){
 $users = get-adgroupmember $DLName -recursive | select SamAccountName 
 $users |   Add-Member -Name  Group -Value $DLName -MemberType NoteProperty 
 $users | add-member -name Date -value  $date -MemberType NoteProperty 
 #$allUsers = $allusers +  $users - use shorthand
 $allUsers += $users

}
$Allusers | export-csv Audits.csv -NoTypeInformation