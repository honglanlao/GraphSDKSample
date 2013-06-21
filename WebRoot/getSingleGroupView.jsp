<%@ page language="java" contentType="text/html" import="java.util.HashMap" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.Group" %>
<!DOCTYPE html> 
<html> 
<head> 
    <title>Details</title> 
   <link rel="stylesheet" type="text/css" href="Site.css" />
    <script src="/Scripts/jquery-1.5.1.min.js" type="text/javascript"></script> 
</head> 
<body> 
    <div class="page"> 
       <div id="header"> 
           <h1>Windows Azure Active Directory Graph Sample</h1> 
 
            <div id="menucontainer"> 
                <ul id="menu"> 
                     <li><a href="/GraphSDKSample/">Home</a></li> 
                  <li><a href="/GraphSDKSample/Home?op=about">About</a></li>  
                </ul> 
            </div> 
        </div> 
        <div id="main"> 
        <%
        	Group group = (Group)session.getAttribute("group");
    		String index = session.getAttribute("index").toString();
    		
        	String description = group.getDescription();
        	if(description == null) description = "";
        	String dirSyncEnabled = group.getDirSyncEnabled();
        	if(dirSyncEnabled == null || dirSyncEnabled.length() == 0) dirSyncEnabled = "Not Set";
        	String displayName = group.getDisplayName();
        	String lastDirSyncTime = group.getLastDirSyncTime();
        	String mail = group.getMail();
        	String mailNickname = group.getMailNickname();
        	String mailEnabled = group.getMailEnabled();
        	if(mailEnabled == null || mailEnabled.length() == 0) mailEnabled = "Not Set";
        	String securityEnabled = group.getSecurityEnabled();
        	if(securityEnabled == null || securityEnabled.length() == 0) securityEnabled = "Not Set";
        	String objectId = group.getObjectId();
        	String objectType = group.getObjectType();
        %>
        
<h2>Details</h2>

 <fieldset>
    <legend>Group</legend>
		<div>Description : <%=description %> </div>
		<div>DirSyncEnabled : <select class="tri-state list-box" disabled="disabled">
														<option value=""><%=dirSyncEnabled %></option></select> </div>
		<div>DisplayName : <%=displayName %></div>
		<div>LastDirSyncTime : <%=lastDirSyncTime %></div>
		<div>Mail: <%=mail %></div> 
		<div>MailNickname : <%=mailNickname %></div>
		<div>MailEnabled : <select class="tri-state list-box" disabled="disabled">
														<option value=""><%=mailEnabled %></option></select></div>		
		<div>SecurityEnabled : <select class="tri-state list-box" disabled="disabled">
		                                                <option value=""><%=securityEnabled %></option></select></div>
		<div>ObjectId : <%=objectId %></div>
		<div>ObjectType : <%=objectType %></div>
</fieldset>
<p>
 <a href="/GraphSDKSample/Group?op=getUpdateGroupView&index=<%=index%>">Edit</a> |
   <a href="javaScript:history.go(-1);">Back to List</a>
   </p>
        </div> 
        <div id="footer"> 
        </div> 
    </div> 
</body> 
</html>