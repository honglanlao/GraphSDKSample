<%@ page language="java" contentType="text/html" import="java.util.HashMap" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.User" %>

<!DOCTYPE html> 
<html> 
<head> 
    <title>Details</title> 
   	<link rel="stylesheet" type="text/css" href="Site.css" />
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script type="text/javascript" src="scripts/validation.js"></script>
	<script>

	function generateUserPrincipalName(){
		var emailAlias = $('#emailAlias').val();
		var selectedDomain =  $('#selectedDomain').val();
		$('#userPrincipalName').val(emailAlias + "@" + selectedDomain);
		return true;
		
	}
	</script>
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
            String accountEnabled = user.getAccountEnabled();
            if(accountEnabled == null) accountEnabled = "Not Set";
            
            String city = user.getCity();
            if(city == null) city = "";
            
            String country = user.getCountry();
            if(country == null) country = "";

            String department = user.getDepartment();
            if(department == null) department = "";

            String displayName = user.getDisplayName();           
            if(displayName == null) displayName = "";

            String facsimileTelephoneNumber = user.getFacsimileTelephoneNumber();
            if(facsimileTelephoneNumber == null) facsimileTelephoneNumber = "";

            String givenName = user.getGivenName();
            if(givenName == null) givenName = "";

            String jobTitle = user.getJobTitle();
            if(jobTitle == null) jobTitle = "";

            String lastDirSyncTime = user.getLastDirSyncTime();
            if(lastDirSyncTime == null) lastDirSyncTime = "";

            String mail = user.getMail();
            if(mail == null) mail = "";

            String mailNickname = user.getMailNickname();
            if(mailNickname == null) mailNickname = "";

            String mobile = user.getMobile();
            if(mobile == null) mobile = "";

            String password = user.getPassword();
            if(password == null) password = "";

            String passwordPolicies = user.getPasswordPolicies();           
            if(passwordPolicies == null) passwordPolicies = "";

            String physicalDeliveryOfficeName = user.getPhysicalDeliveryOfficeName();
            if(physicalDeliveryOfficeName == null) physicalDeliveryOfficeName = "";

            String postalCode = user.getPostalCode();
            if(postalCode == null) postalCode = "";

            String preferredLanguage = user.getPreferredLanguage();
            if(preferredLanguage == null) preferredLanguage = "";

            String state = user.getState();
            if(state == null) state = "";

            String streetAddress = user.getStreetAddress();
            if(streetAddress == null) streetAddress = "";

            String surname = user.getSurname();
            if(surname == null) surname = "";

            String telephoneNumber = user.getTelephoneNumber();
            if(telephoneNumber == null) telephoneNumber = "";

            String usageLocation = user.getUsageLocation();
            if(usageLocation == null) usageLocation = "";

            String userPrincipalName = user.getUserPrincipalName();
            String emailAlias = "";
            String selectedDomain = "";
            if(userPrincipalName == null){
            	userPrincipalName = "";
            }else{
            	String[] arr = userPrincipalName.split("@");
            	emailAlias = arr[0];
            	selectedDomain = arr[1];
            }

            String objectId = user.getObjectId();           
            if(objectId == null) objectId = "";

      
            String objectType = user.getObjectType();
            if(objectType == null) objectType = "";

         %>   

<h2>Edit</h2>

 <b>Thumbnail Photo: </b> <img src="" alt="No Image Exists"/>
            
<form id="updateUser" name="updateUser" action="/GraphSDKSample/User?op=updateUser&objectId=<%=objectId%>&oldDisplayName=<%=displayName%>" onsubmit="return generateUserPrincipalName();" method="post"><label style="color: #FF0000" >*</label><label>indicates a mandatory field</label><br/>	
	<fieldset>
    <legend>User</legend>

   		<div class="editor-label">
            <label for="displayName">DisplayName</label><label style="color: #FF0000" >*</label>
        </div>
        <div class="editor-field">
            <input required="required" class="text-box single-line" id="displayName" name="displayName" type="text" value="<%=displayName %>" />
        </div>

        <div class="editor-label">
            <label for="userPrincipalName">UserPrincipalName</label><label style="color: #FF0000" >*</label>
            <input type="hidden" id=userPrincipalName name="userPrincipalName" value="" />
        </div>
        <div class="editor-field">
             <input required="required" id="emailAlias" name="emailAlias" type="text" value="<%=emailAlias %>" />
	            <label>@</label>  <select id="selectedDomain" name="selectedDomain">            					
	            					<option><%=selectedDomain %></option>
	            				  </select>
	            <span class="field-validation-valid" data-valmsg-for="emailAlias" data-valmsg-replace="true"></span>
        </div>

        <div class="editor-label">
            <label for="accountEnabled">AccountEnabled</label>  <label style="color: #FF0000" >*</label>
        </div>
        <div class="editor-field">
             <select required="required" class="tri-state list-box" id="accountEnabled" name="accountEnabled" >
            
				          <option <%if(accountEnabled.equalsIgnoreCase("Not Set")) out.print("selected='selected'"); %> id="1" value="">Not Set</option>
				         <option <%if(accountEnabled.equalsIgnoreCase("True")) out.print("selected='selected'"); %> id="2" value="True">True</option>
				         <option <%if(accountEnabled.equalsIgnoreCase("False")) out.print("selected='selected'"); %> id="3" value="False">False</option>
			 </select>
        </div>

        <div class="editor-label">
            <label for="password">Reset Password</label>
        </div>
        <div class="editor-field">
            <input id="password" name="password" type="password" value="<%=password %>"/>
        </div>    
        
        <div class="editor-label">
            <label for=mailNickname>MailNickname</label>  <label style="color: #FF0000" >*</label>
        </div>
        <div class="editor-field">
            <input required="required" class="text-box single-line" id="mailNickname" name="mailNickname" type="text" value="<%=mailNickname %>" />
        </div>     

        <div class="editor-label">
            <label for="city">City</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="city" name="city" type="text" value="<%=city %>" />
        </div>

        <div class="editor-label">
            <label for="country">Country</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="country" name="country" type="text" value="<%=country %>" />
        </div>

        <div class="editor-label">
            <label for="Department">Department</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="department" name="department" type="text" value="<%=department %>" />
        </div>

        <div class="editor-label">
            <label for="facsimileTelephoneNumber">FacsimileTelephoneNumber</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="facsimileTelephoneNumber" name="facsimileTelephoneNumber" type="text" value="<%=facsimileTelephoneNumber %>" />
        </div>

        <div class="editor-label">
            <label for="givenName">GivenName</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="givenName" name="givenName" type="text" value="<%=givenName %>" />
        </div>

        <div class="editor-label">
            <label for="jobTitle">JobTitle</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="jobTitle" name="jobTitle" type="text" value="<%=jobTitle %>" />
        </div>

        <div class="editor-label">
            <label for="lastDirSyncTime">LastDirSyncTime</label>
        </div>
        <div class="editor-field">
            <input disabled="disabled" class="text-box single-line  bg-grey" data-val="true" data-val-date="The field LastDirSyncTime must be a date." id="lastDirSyncTime" name="lastDirSyncTime" type="datetime" value="<%=lastDirSyncTime %>" />
        </div>

        <div class="editor-label">
            <label for="mail">Mail</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="mail" name="mail" type="text" value="<%=mail %>" />
        </div>

        <div class="editor-label">
            <label for="Mobile">Mobile</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="Mobile" name="Mobile" type="text" value="<%=mobile %>" />
        </div>

        <div class="editor-label">
            <label for="passwordPolicies">PasswordPolicies</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="passwordPolicies" name="passwordPolicies" type="text" value="<%=passwordPolicies %>" />
        </div>

        <div class="editor-label">
            <label for="physicalDeliveryOfficeName">PhysicalDeliveryOfficeName</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="physicalDeliveryOfficeName" name="physicalDeliveryOfficeName" type="text" value="<%=physicalDeliveryOfficeName %>" />
        </div>

        <div class="editor-label">
            <label for="postalCode">PostalCode</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="PostalCode" name="postalCode" type="text" value="<%=postalCode %>" />
        </div>

        <div class="editor-label">
            <label for="preferredLanguage">PreferredLanguage</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="preferredLanguage" name="preferredLanguage" type="text" value="<%=preferredLanguage %>" />
        </div>

        <div class="editor-label">
            <label for="state">State</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="state" name="state" type="text" value="<%=state %>" />
        </div>

        <div class="editor-label">
            <label for="streetAddress">StreetAddress</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="streetAddress" name="streetAddress" type="text" value="<%=streetAddress %>" />
        </div>

        <div class="editor-label">
            <label for="surname">Surname</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="surname" name="surname" type="text" value="<%=surname %>" />
        </div>

        <div class="editor-label">
            <label for="TelephoneNumber">TelephoneNumber</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="telephoneNumber" name="telephoneNumber" type="text" value="<%=telephoneNumber %>" />
        </div>

        <div class="editor-label">
            <label for="usageLocation">UsageLocation</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="usageLocation" name="usageLocation" type="text" value="<%=usageLocation %>" />
        </div>
</fieldset>
<p>
    
    <input type="submit" value="Update"> | 
    <a href="javaScript:history.go(-1)">Back to List</a>
</p>
</form>

        </div> 
        <div id="footer"> 
        </div> 
    </div> 
</body> 
</html>