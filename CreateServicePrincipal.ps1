#
#  this is a PS1 script that creates a service principal for webSSO and 
# accessing the Windows Azure Active Directory Graph API
#


# Warning/disclaimer about creation of service principals
""
"--------------------------------------------------------------------"
"WARNING: you are about to create a service principal that allows an application to access your Azure Active Directory Tenant's information. This includes access to your company's directory, staff heirarchy, and company license information. Please proceed only if you are an Administrator for the company and understand the permissions that you will grant for the application"
"-------------------------------------------------------------------"
" "
"NOTE: Once Servicer Principals are created, you can view them by using the Get-MsolServicePrincipal cmdlet from this PowerShell window. For a full list of commands available, including removing Service Principals, run get-help//-msolserviceprincipal* after this script is complete. "
""

$accept = Read-Host "Do you still wish to proceed?  (Y/N)"

if ($accept.ToLower() -ne "y" -And $accept.ToLower() -ne "yes" ){exit}
 



#ask the user for the Service Principal Name he wants to use. This ensures that during multiple runs we don't run in to conflicts
""
"--------------- Service Principal Name -------------------- "
" "
"Please enter a descriptive name for the Service Principal you wish to create."
""
"If you've created a Service Principal for this account before, you should use a new name or you will get an error that it already exists in this tenant."
""
"Example: Graph API Application"
""
$servicePrincipalName = Read-Host "Enter a Service Principal Name"


# prompt for Tenant Admin credentials, then connect to the Azure AD tenant, enable PowerShell
# commandlets to support Service prinicpal managementy
#
" "
"--------------- Provide Your Administrator Credentials -------------------"
""
"You will need your Administrator account information for the next step. You will be prompted with a login screen that you will enter these credentials in to."
""
"Hit any key when ready"
" "
$null = Read-Host
$cr=get-credential
connect-msolservice -credential $cr
Import-Module MSOnlineExtended -force

# this section is used to create a service principal credential using a symmetric key
" "
"--------------- Symmetric Key ---------------------"
""
"A Random Symmetric Key value will be generated - use this, along with your ApplPrincipalId, TenantContextId, TenantDomainName to configure your application"
" "

#Generating the symmetric key
$cryptoProvider = new-object System.Security.Cryptography.RNGCryptoServiceProvider
$byteArr = new-object byte[] 32
$cryptoProvider.GetBytes($byteArr)
$signingKey = [Convert]::ToBase64String($byteArr)
Write-Output $signingKey | Out-File symmetrickey.txt


$credValue = $signingKey
$credType = "Symmetric"

# replyURL is used to for configuring webSSO
$replyHost = "aadexpensedemo.cloudapp.net"
$replyAddress = "https://" + $replyHost + "/"
$replyUrl = New-MsolServicePrincipalAddresses –Address $replyAddress
" "
" -- the URL of the application we will return to after Single Sign On (not used for Graph API access) --"
" For more more information about web single sign on "
" Visit http://blogs.msdn.com/b/vbertocci/archive/2012/07/12/single-sign-on-with-windows-azure-active-directory-a-deep-dive.aspx "
""
"Using: $replyAddress as the application endpoint we will redirect to after sigle sign-on is complete."
"This should be the location of the demo app for web single sign on (not for Graph API access). You can change it in the PowerShell script."
" "

# creating service principal using 
" "
"--------------- Creating the Service Principal inside of Azure --------------------"
" "
"We are ready to create the Service Principal for your tenant."
""

"Press any key when you are ready to proceed or Cntl-C to end."
""
$null = Read-Host
""
""
"Creating the Service Principal inside your Azure Active Directory tenant"
" "
""
$sp = New-MsolServicePrincipal -ServicePrincipalNames @("$servicePrincipalName/$replyHost") -DisplayName "$ServicePrincipalName" -Addresses $replyUrl -Type $credType -Value $credValue

# grant the Client app calling the Graph, Read or Write permissions
# add the Service Principal to a Role, to enable specific application permissions
$Read = "Directory Readers"
$ReadWrite = "User Account Administrator"

" "
"NOTE: Once Servicer Principals are created, you can view them by using the Get-MsolServicePrincipal cmdlet from this PowerShell window. For a full list of commands available, including removing Service Principals, run get-help//-msolserviceprincipal* after this script is complete. "
""

$permmission = Read-Host "Do wish to grant your application Read or Read+Write permissions (R or W)? "

if ($permmission.ToLower() -eq "w" -Or $permmission.ToLower() -eq "write" )
{
" "
"Setting permissions to allow the Application Service Principal to have Read+Write permissions for your tenant. Review the Script to see how this authorization is done."
" "
Add-MsolRoleMember -RoleMemberType ServicePrincipal -RoleName $ReadWrite -RoleMemberObjectId $sp.objectid
}
else 
{
" "
"Setting permissions to allow the Application Service Principal to have Read permissions for your tenant. Review the Script to see how this authorization connfiguration is set."
" "
Add-MsolRoleMember -RoleMemberType ServicePrincipal -RoleName $Read -RoleMemberObjectId $sp.objectid
}

$c = get-msolcompanyinformation

"--------------- Script is complete ----------------------"
" You will need to update the following values in the Graph API sampe application's web.config file"
"TenantDomainName: " + $c.InitialDomain
"TenantContextId: " + $c.objectId
"AppPrincipalId: " + $sp.AppPrincipalId
if ($credType = "Symmetric"){"SymmetricKey: " + $credValue}
"Audience URI: " + $sp.AppPrincipalID + "@" + $c.objectId
""
