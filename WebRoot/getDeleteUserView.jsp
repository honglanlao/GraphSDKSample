<%@ page language="java" contentType="text/html" import="java.util.HashMap" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.UserList" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.User" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.config.SdkConfig" %>

<!DOCTYPE html> 
<html> 
<head> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="Site.css" />
    <title>Delete</title>
        
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
            

<h2>Delete</h2>

<h3>Are you sure you want to delete this?</h3>
<fieldset>
    <legend>User</legend>
	<% 
    		User user = (User)session.getAttribute("user");
			String displayName = user.getDisplayName().toString();
    		String UPN = user.getUserPrincipalName().toString();
    		String accountEnabled = user.getAccountEnabled();
    		if(accountEnabled == null) accountEnabled = "Not Set";
    		String objectId = user.getObjectId();
    	%>
    <div class="display-label">DisplayName</div>
    <div class="display-field"><%=displayName%></div>

    <div class="display-label">UserPrincipalName</div>
    <div class="display-field"><%=UPN%></div>

    <div class="display-label">AccountEnabled</div>
    <div class="display-field">
        <select class="tri-state list-box" disabled="disabled">
        	<option selected="selected" value="true"><%=accountEnabled%></option>
        	
        </select>
    </div>
    
   
</fieldset>
<form action="/GraphSDKSample/User?op=deleteUser&objectId=<%=objectId%>&displayName=<%=displayName%>" method="post"> <p>
        <input type="submit" value="Delete" /> |
        <a href="javaScript:history.go(-1);">Back to List</a>
    </p>
</form> 
        </div> 
        <div id="footer"> 
        </div> 
    </div> 
</body> 
</html>