<%@ page language="java" contentType="text/html" import="java.util.HashMap" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.User" %>

<!DOCTYPE html> 
<html> 
<head> 
    <title>Details</title> 
    <link rel="stylesheet" type="text/css" href="Site.css" />
	<script src="http://code.jquery.com/jquery-latest.js"></script>
</head> 
<body> 
    <div class="page"> 
       <div id="header"> 
           <h1>Windows Azure Active Directory Graph Sample(Java)</h1> 
 
            <div id="menucontainer"> 
                <ul id="menu"> 
                    <li><a href="/GraphSDKSample/">Home</a></li> 
                  <li><a href="/GraphSDKSample/Home?op=about">About</a></li>  
                </ul> 
            </div> 
        </div> 
        <div id="main"> 
        <%
         	User user = (User)session.getAttribute("user");
        	String index = session.getAttribute("index").toString();
            String dirSyncEnabled = user.getDirSyncEnabled();
            if(dirSyncEnabled == null || dirSyncEnabled.length() == 0) dirSyncEnabled = "Not Set";
           	String accountEnabled = user.getAccountEnabled();
            if(accountEnabled == null || accountEnabled.length() == 0) accountEnabled = "Not Set";
            String city = user.getCity();
            String country = user.getCountry();
            String department = user.getDepartment();
            String displayName = user.getDisplayName();
            String facsimileTelephoneNumber = user.getFacsimileTelephoneNumber();
            String givenName = user.getGivenName();
            String jobTitle = user.getJobTitle();
            String lastDirSyncTime = user.getLastDirSyncTime();
            String mail = user.getMail();
            String mobile = user.getMobile();
            String passwordPolicies = user.getPasswordPolicies();
            String physicalDeliveryOfficeName = user.getPhysicalDeliveryOfficeName();
            String postalCode = user.getPostalCode();
            String preferredLanguage = user.getPreferredLanguage();
            String state = user.getState();
            String streetAddress = user.getStreetAddress();
            String surname = user.getSurname();
            String telephoneNumber = user.getTelephoneNumber();
            String usageLocation = user.getUsageLocation();
            String userPrincipalName = user.getUserPrincipalName();
            String objectId = user.getObjectId();
            String objectType = user.getObjectType();
         %>   

<h2>Details</h2>

 <b>Thumbnail Photo: </b>  <img src="/GraphSDKSample/User?op=getThumbnail&objectId=<%=objectId %>" alt="No Image Exists"/>
            

<fieldset>
    <legend>User</legend>
    <div>
         DirSyncEnabled : <select class="tri-state list-box" disabled="disabled">
         <option selected="selected" value=""><%=dirSyncEnabled %></option>
         </select>
    </div>
    
    <div>
         AccountEnabled : <select class="tri-state list-box" disabled="disabled">
         <option value=""><%=accountEnabled%></option>
         </select>
    </div>
    <div>
         City : <%=city%>
    </div>

    <div>
         Country : <%=country %>
    </div>

   <div>
         Department : <%=department %>
    </div>


    <div>
         DisplayName : <%=displayName %>
    </div>

    <div>
         FacsimileTelephoneNumber : <%=facsimileTelephoneNumber %>
    </div>
    
    <div>
         GivenName : <%=givenName %>
    </div>
    
    <div>
         JobTitle : <%=jobTitle %>
    </div>
    
    <div>
         LastDirSyncTime : <%=lastDirSyncTime %>
    </div>        

    <div>
         Mail : <%=mail %>
    </div>        

    <div>
         Mobile : <%=mobile %>
    </div>        

    <div>
         PasswordPolicies : <%=passwordPolicies %>
    </div>        

    <div>
         PhysicalDeliveryOfficeName : <%=physicalDeliveryOfficeName %>
    </div>        

    <div>
         PostalCode : <%=postalCode %>
    </div>        

    <div>
         PreferredLanguage : <%=preferredLanguage %>
    </div>        

    <div>
         State : <%=state %>
    </div>

    <div>
         StreetAddress : <%=streetAddress %>
    </div>

    <div>
         Surname : <%=surname %>
    </div>

    <div>
         TelephoneNumber : <%=telephoneNumber %>
    </div>

    <div>
         UsageLocation : <%=usageLocation %>
    </div>

    <div>
         UserPrincipalName : <%=userPrincipalName %>
    </div>

    <div>
         ObjectId : <%=objectId %>
    </div>

    <div>
         ObjectType : <%=objectType %>
    </div>
</fieldset>
<p>
    <a href="/GraphSDKSample/User?op=getUpdateUserView&index=<%=index%>">Edit</a> |
   <a href="javaScript:history.go(-1);">Back to List</a>
</p>
 
        </div> 
        <div id="footer"> 
        </div> 
    </div> 
</body> 
</html>