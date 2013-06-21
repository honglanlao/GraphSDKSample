<%@ page language="java" contentType="text/html" import="java.util.HashMap" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.GroupList" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.Group" %>
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
    <legend>Group</legend>
	<% 
    		Group group = (Group)session.getAttribute("group");
	
			String displayName = group.getDisplayName().toString();    	
    		String description = group.getDescription();
    		String objectId = group.getObjectId();
    	%>
    <div class="display-label">DisplayName</div>
    <div class="display-field"><%=displayName%></div>

    <div class="display-label">Description</div>
    <div class="display-field"><%=description%></div>
   
</fieldset>
<form action="/GraphSDKSample/Group?op=deleteGroup&objectId=<%=objectId%>&displayName=<%=displayName%>" method="post"> <p>
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