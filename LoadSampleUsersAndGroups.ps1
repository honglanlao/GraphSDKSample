
<#
This script adds sample users, groups, contacts.
#>

$cred = get-credential
 connect-msolservice -credential $cred
$c = get-msolcompanyinformation
$domain = $c.initialdomain

# Load in new users 
new-msoluser -UserPrincipalName ("Mark@"+$domain) -DisplayName "Mark Alexieff" -FirstName Mark -LastName "Alexieff" -StreetAddress "123 Main" -State WA -City Seattle -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Sales Manger"
new-msoluser -UserPrincipalName ("Ed@"+$domain) -DisplayName "Ed Banti" -FirstName "Ed" -LastName "Banti" -StreetAddress "123 Main Street" -State WA -City Seattle -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Sales"
new-msoluser -UserPrincipalName ("Adam@"+$domain) -DisplayName "Adam Barr" -FirstName "Adam" -LastName "Barr" -StreetAddress "123 Main Street" -State WA -City Seattle -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Sales"
new-msoluser -UserPrincipalName ("Derek@"+$domain) -DisplayName "Derek Brown" -FirstName "Derek" -LastName "Brown" -StreetAddress "123 Main Street" -State WA -City Seattle -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Administrator"
new-msoluser -UserPrincipalName ("Marcus@"+$domain) -DisplayName "Marcus Bryer" -FirstName "Marcus" -LastName "Bryer" -StreetAddress "123 Main Street" -State WA -City Seattle -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Administrator"
new-msoluser -UserPrincipalName ("Martin@"+$domain) -DisplayName "Martin Spona" -FirstName "Martin" -LastName "Spona" -StreetAddress "123 Main Street" -State WA -City Seattle -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Email Support"
new-msoluser -UserPrincipalName ("Ivo@"+$domain) -DisplayName "Ivo Haemels" -FirstName "Ivo" -LastName "Haemels" -StreetAddress "123 Main Street" -State WA -City Seattle -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Engineering"
new-msoluser -UserPrincipalName ("Carlos@"+$domain) -DisplayName "Carlos Grilo" -FirstName "Carlos" -LastName "Grilo" -StreetAddress "123 Main Street" -State WA -City Seattle -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Engineering"
new-msoluser -UserPrincipalName ("Peter@"+$domain) -DisplayName "Peter Bankov" -FirstName "Peter" -LastName "Bankov" -StreetAddress "123 Main Street" -State WA -City Seattle -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Marketing Manager"
new-msoluser -UserPrincipalName ("Janet@"+$domain) -DisplayName "Janet Galore" -FirstName "Janet" -LastName "Galore" -StreetAddress "123 Main Street" -State OR -City Portland -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Marketing Representative"
new-msoluser -UserPrincipalName ("Vernon@"+$domain) -DisplayName "Vernon Hui" -FirstName "Vernon" -LastName "Hui" -StreetAddress "123 Main Street" -State OR -City Portland -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Operations"
new-msoluser -UserPrincipalName ("David@"+$domain) -DisplayName "David Longmuir" -FirstName "David" -LastName "Longuir" -StreetAddress "123 Main Street" -State OR -City Portland -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Operations"
new-msoluser -UserPrincipalName ("Jesper@"+$domain) -DisplayName "Jesper Herp" -FirstName "Jesper" -LastName "Herp" -StreetAddress "123 Main Street" -State OR -City Portland -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Email Support"
new-msoluser -UserPrincipalName ("Ayla@"+$domain) -DisplayName "Ayla Kol" -FirstName "Ayla" -LastName "Kol" -StreetAddress "123 Main Street" -State OR -City Portland -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Neo Rep"
new-msoluser -UserPrincipalName ("Thiti@"+$domain) -DisplayName "Thiti Wang" -FirstName "Thiti" -LastName "Wang" -StreetAddress "123 Main Street" -State OR -City Portland -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Neo Rep"
new-msoluser -UserPrincipalName ("Anna@"+$domain) -DisplayName "Anna Lidman" -FirstName "Anna" -LastName "Lidman" -StreetAddress "123 Main Street" -State OR -City Portland -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "NEO Rep"
new-msoluser -UserPrincipalName ("Rene@"+$domain) -DisplayName "Rene Valdez" -FirstName "Rene" -LastName "Valdez" -StreetAddress "123 Main Street" -State OR -City Portland -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Inside Sales"
new-msoluser -UserPrincipalName ("Daniel@"+$domain) -DisplayName "Daniel Durrer" -FirstName "Daniel" -LastName "Durrer" -StreetAddress "123 Main Street" -State OR -City Portland -PostalCode 98052 -Country US -UsageLocation US -PhoneNumber "425-555-0100" -Title "Inside Sales"

# Assign Licenses to users
$sku = Get-MsolAccountSku
get-msoluser | where{$_.userprincipalname -iNotLike "Admin*"} | set-msoluserlicense -addLicenses $sku.accountSkuId

$Users = Get-msoluser

# Load in 10 new Groups

New-MsolGroup -ManagedBy $users[1].objectid -DisplayName "All Users" -Description "All Employees" 
New-MsolGroup -ManagedBy $users[2].objectid -DisplayName "Sales Team" -Description "Members of the Sales Team"
New-MsolGroup -ManagedBy $users[3].objectid -DisplayName "Wash State" -Description "Uses in Washington State"
New-MsolGroup -ManagedBy $users[4].objectid -DisplayName "Email Support" -Description "Email Support Team"
New-MsolGroup -ManagedBy $users[5].objectid -DisplayName "Engineering" -Description "Engineering Team"
New-MsolGroup -ManagedBy $users[6].objectid -DisplayName "Marketing" -Description "Marketing Department"
New-MsolGroup -ManagedBy $users[7].objectid -DisplayName "Operations Team" -Description "Operations Team"
New-MsolGroup -ManagedBy $users[9].objectid -DisplayName "New Employee Orientation" -Description "New Employee Training Team"
New-MsolGroup -ManagedBy $users[9].objectid -DisplayName "Insides Sales Team" -Description "Members of the Inside Sales Team"

"Loading Group Memebership"

$Groups = get-msolgroup

foreach ($group in $Groups) {Switch ($Group.DisplayName) {
  "All Users"{
             " Updating " + $group.displayname
             foreach ($user in $Users)
              {
              add-msolgroupmember -GroupObjectId $group.objectid.Guid -GroupMemberType User -GroupMemberObjectId $user.objectid.Guid
              } 
  }
  "Sales Team"{ 
              " Updating " + $group.displayname
              
               foreach ($user in $Users)
                {    
                 if ($user.Title -ilike "*Sales*")
                  {
                   add-msolgroupmember -GroupObjectId $group.objectid.Guid -GroupMemberType User -GroupMemberObjectId $user.objectid.Guid
                  }
                }
  } 
  "Wash State"{ 
              " Updating " + $group.displayname
              
               foreach ($user in $Users)
                {    
                 if ($user.State -ilike "WA")
                  {
                   add-msolgroupmember -GroupObjectId $group.objectid.Guid -GroupMemberType User -GroupMemberObjectId $user.objectid.Guid
                  }
                }
  } 

  "Email Support"{ 
              " Updating " + $group.displayname
              
               foreach ($user in $Users)
                {    
                 if ($user.Title -ilike "Email Support")
                  {
                   add-msolgroupmember -GroupObjectId $group.objectid.Guid -GroupMemberType User -GroupMemberObjectId $user.objectid.Guid
                  }
                }
  } 
  "Engineering"{ 
              " Updating " + $group.displayname
              
               foreach ($user in $Users)
                {    
                 if ($user.Title -ilike "Engineering")
                  {
                   add-msolgroupmember -GroupObjectId $group.objectid.Guid -GroupMemberType User -GroupMemberObjectId $user.objectid.Guid
                  }
                }
  } 
  "Marketing"{ 
              " Updating " + $group.displayname
              
               foreach ($user in $Users)
                {    
                 if ($user.Title -ilike "*Marketing*")
                  {
                   add-msolgroupmember -GroupObjectId $group.objectid.Guid -GroupMemberType User -GroupMemberObjectId $user.objectid.Guid
                  }
                }
  }    
  "Operations Team"{ 
              " Updating " + $group.displayname
              
               foreach ($user in $Users)
                {    
                 if ($user.Title -ilike "Operations")
                  {
                   add-msolgroupmember -GroupObjectId $group.objectid.Guid -GroupMemberType User -GroupMemberObjectId $user.objectid.Guid
                  }
                }
  }    
  "New Employee Orientation"{ 
              " Updating " + $group.displayname
              
               foreach ($user in $Users)
                {    
                 if ($user.Title -ilike "NEO Rep")
                  {
                   add-msolgroupmember -GroupObjectId $group.objectid.Guid -GroupMemberType User -GroupMemberObjectId $user.objectid.Guid
                  }
                }
  }

  "Insides Sales Team"{ 
              " Updating " + $group.displayname
              
               foreach ($user in $Users)
                {    
                 if ($user.Title -ilike "Inside Sales")
                  {
                   add-msolgroupmember -GroupObjectId $group.objectid.Guid -GroupMemberType User -GroupMemberObjectId $user.objectid.Guid
                  }
                }
  }

  }

}




# connect to Exchange Online
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Cred -Authentication Basic -AllowRedirection
Import-PSSession $Session


# Add Contacts

new-mailContact -FirstName "Kevin" -LastName "Cook" -Name "Kevin Cook" -ExternalEmailAddress "Kevin@Contoso.com" 
new-MailContact -FirstName "Phil" -LastName "Spencer" -Name "Phil Spencer" -ExternalEmailAddress "Phil@contoso.com" 
new-MailContact -FirstName "David" -LastName "Strome"-Name "David Strome" -ExternalEmailAddress "David@contoso.com" 
new-MailContact -FirstName "Rui" -LastName "Rapso"-Name "Rui Raposo" -ExternalEmailAddress "Rui@contoso.com" 
new-MailContact -FirstName "Holly" -LastName "Holt" -Name "Holly Holt" -ExternalEmailAddress "Holly@contoso.com" 
new-MailContact -FirstName "Charlie" -LastName "Keen" -Name "Charlie Keen" -ExternalEmailAddress "Charlie@contoso.com" 
new-MailContact -FirstName "Marcus" -LastName "Breyer" -Name "Marcus Breyer" -ExternalEmailAddress "Marcus@contoso.com" 
new-MailContact -FirstName "Toni" -LastName "Poe" -Name "Toni Poe" -ExternalEmailAddress "Toni@contoso.com" 
new-MailContact -FirstName "Yossi" -LastName "Ran" -Name "Yossi Ran" -ExternalEmailAddress "Yossi@contoso.com" 
new-MailContact -FirstName "Scott" -LastName "Culp" -Name "Scott Culp" -ExternalEmailAddress "Scott@contoso.com" 
new-MailContact -FirstName "Alex" -LastName "Darrow" -Name "Alex Darrow" -ExternalEmailAddress "Alex@contoso.com" 
new-MailContact -FirstName "Jeremy" -LastName "Nelson" -Name "Jeremy Nelson" -ExternalEmailAddress "Jeremy@contoso.com" 


# Configure Relationships
# Mark, Ed, Adam report to Derek
# Derek reports to Marcus

set-user -Identity Mark -Manager Derek
set-user -Identity Ed -Manager Derek
set-user -Identity Adam -Manager Derek
set-user -Identity Derek -Manager Marcus

# Vernon, David, Jesper report to Ayla
# Ayla reports to Rene

set-user -Identity Vernon -Manager Ayla
set-user -Identity David -Manager Ayla
set-user -Identity Jesper -Manager Ayla
set-user -Identity Ayla -Manager Rene

# Martin, Ivo, Carlos, Peter, Janet, Thiti report to Daniel
set-user -Identity Martin -Manager Daniel
set-user -Identity Ivo -Manager Daniel
set-user -Identity Carlos -Manager Daniel
set-user -Identity Peter -Manager Daniel
set-user -Identity Janet -Manager Daniel
set-user -Identity Thiti -Manager Daniel


# Rene, Marcus report to Anna
set-user -Identity Rene -Manager Anna
set-user -Identity Marcus -Manager Anna
set-user -Identity Daniel -Manager Anna