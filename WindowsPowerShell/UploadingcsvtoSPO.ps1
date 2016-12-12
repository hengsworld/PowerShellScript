#Code from Salaudeen Rajack

#Load SharePoint CSOM Assemblies
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
  
##Variables for Processing
$SiteUrl = "SPO Location"
$ListName= "ListName"
$ImportFile =".csv"
$UserName="UserID "
$Password = Read-Host -Prompt "Please enter you password" -AsSecureString
 
#Setup Credentials to connect
$Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName, $Password)
 
#Set up the context
$Context = New-Object Microsoft.SharePoint.Client.ClientContext($SiteUrl)
$Context.Credentials = $credentials
  
#Get the List
$List = $Context.web.Lists.GetByTitle($ListName)
 
#Get the Data from CSV and Add to SharePoint List
$data = Import-Csv $ImportFile
Foreach ($row in $data) {
     
    #add item to List
    $ListItemInfo = New-Object Microsoft.SharePoint.Client.ListItemCreationInformation
    $Item = $List.AddItem($ListItemInfo)
    $Item["Title"] = $row.Title
    $Item.Update()
    $Context.ExecuteQuery()
    
}
Write-host "CSV data Imported to SharePoint List Successfully!"

