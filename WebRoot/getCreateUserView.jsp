<%@ page language="java" contentType="text/html" import="java.util.HashMap" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.UserList" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.config.SdkConfig" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="Site.css" />
<title>Create</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="scripts/validation.js"></script>
<script type="text/javascript">


function preProcess(){
	generateUserPrincipalName();
	var isGreen = validate();
	return isGreen;
}




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
	              <li><a href="/GraphSDKSample">Home</a></li> 
                  <li><a href="/GraphSDKSample/Home?op=about">About</a></li>  
	          </ul> 
	      </div> 
	  </div> 
     <div id="main"> 
		<h2>Create</h2>
		<form id="queryUser" name="queryUser" action="/GraphSDKSample/User?op=createUser" onsubmit="return preProcess();" method="post"><label style="color: #FF0000" >*</label><label>indicates a mandatory field</label><br />
	    <fieldset>
	        <legend>User</legend>
	
	        <div class="editor-label">
	            <label for="displayName">DisplayName</label>  <label style="color: #FF0000" >*</label>
	        </div>
	        <div class="editor-field">
	            <input required="required" class="text-box single-line required" id="displayName" name="displayName" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="UserPrincipalName">UserPrincipalName</label><label style="color: #FF0000" >*</label>
	            <input type="hidden" id=userPrincipalName name="userPrincipalName" value="" />
	        </div>
	        <div class="editor-field">
	            <input required="required" id="emailAlias" name="emailAlias" type="text" value="" />
	            <label>@</label>  <select id="selectedDomain" name="selectedDomain">
	            					<%
	            					 String TenantDomainName =  session.getAttribute("TenantDomainName").toString();
	            					 out.println("<option>" + TenantDomainName + "</option>");
	            					%>
	            				  </select>
	            <span class="field-validation-valid" data-valmsg-for="emailAlias" data-valmsg-replace="true"></span>
	        </div>
	       
	        <div class="editor-label">
	            <label for="AccountEnabled">AccountEnabled</label>  <label style="color: #FF0000" >*</label>
	        </div>
	        <div class="editor-field">
	            <select required="required" class="list-box tri-state" id="accountEnabled" name="accountEnabled"><option selected="selected" value="">Not Set</option>
					<option value="true">True</option>
					<option value="false">False</option>
				</select>
	        </div>

	        <div class="editor-label">
	            <label for="Password">Password</label>  <label style="color: #FF0000" >*</label>
	        </div>
	        <div class="editor-field">
	            <input required="required" id="password" name="password" type="password" />
	        </div>    
	        
	        <div class="editor-label">
	            <label for=mailNickname>MailNickname</label>  <label style="color: #FF0000" >*</label>
	        </div>
	        <div class="editor-field">
	            <input required="required" id="mailNickname" name="mailNickname" type="text" />
	        </div>     
	
	        <div class="editor-label">
	            <label for="City">City</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="city" name="city" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="Country">Country</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="country" name="country" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="Department">Department</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="department" name="department" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="facsimileTelephoneNumber">FacsimileTelephoneNumber</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="facsimileTelephoneNumber" name="facsimileTelephoneNumber" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="givenName">GivenName</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="givenName" name="givenName" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="jobTitle">JobTitle</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="jobTitle" name="jobTitle" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="lastDirSyncTime">LastDirSyncTime</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" data-val="true" data-val-date="The field LastDirSyncTime must be a date." id="lastDirSyncTime" name="lastDirSyncTime" type="datetime" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="mail">Mail</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="mail" name="mail" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="mobile">Mobile</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="mobile" name="mobile" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="passwordPolicies">PasswordPolicies</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="passwordPolicies" name="passwordPolicies" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="physicalDeliveryOfficeName">PhysicalDeliveryOfficeName</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="physicalDeliveryOfficeName" name="physicalDeliveryOfficeName" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="postalCode">PostalCode</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="postalCode" name="postalCode" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="preferredLanguage">PreferredLanguage</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="preferredLanguage" name="preferredLanguage" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="state">State</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="state" name="state" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="streetAddress">StreetAddress</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="streetAddress" name="streetAddress" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="surname">Surname</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="surname" name="surname" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="telephoneNumber">TelephoneNumber</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="telephoneNumber" name="telephoneNumber" type="text" value="" />
	        </div>
	
	        <div class="editor-label">
	            <label for="usageLocation">UsageLocation</label>
	        </div>
	        <div class="editor-field">
	            <input class="text-box single-line" id="usageLocation" name="usageLocation" type="text" value="" />
	        </div>
	
	        <p>
	            <input type="submit" value="Create"  />
	        </p>
	    </fieldset>
		</form>
		<div>
		    <a href="/GraphSDKSample/User?op=getMultiUsers">Back to List</a>
		</div>
	</div> 
    <div id="footer"></div> 
</div>

</body>
</html>