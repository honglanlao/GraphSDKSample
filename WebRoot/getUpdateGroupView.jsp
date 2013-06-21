<%@ page language="java" contentType="text/html" import="java.util.HashMap" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.Group" %>
<!DOCTYPE html> 
<html> 
<head> 
    <title>Details</title> 
   	<link rel="stylesheet" type="text/css" href="Site.css" />
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script type="text/javascript" src="scripts/validation.js"></script>
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
        Group group = (Group)session.getAttribute("group");
        
        String description = group.getDescription();
        
    	String dirSyncEnabled = group.getDirSyncEnabled();
    	if( null == dirSyncEnabled || 0 == dirSyncEnabled.length() ) dirSyncEnabled = "Not Set";
    	
    	String displayName = group.getDisplayName();   	
    	String lastDirSyncTime = group.getLastDirSyncTime();   	
    	String mail = group.getMail();   	
    	String mailNickname = group.getMailNickname();
    	
    	String mailEnabled = group.getMailEnabled();
    	if( null == mailEnabled || 0 == mailEnabled.length()) mailEnabled = "Not Set";
    	
    	String securityEnabled = group.getSecurityEnabled();
    	if( null == securityEnabled || 0 == securityEnabled.length()) securityEnabled = "Not Set";
    	
    	String objectId = group.getObjectId();
    	String objectType = group.getObjectType();

         %>   

<h2>Edit</h2>

 <b>Thumbnail Photo: </b> <img src="" alt="No Image Exists"/>
            
<form id="updateGroup" name="updateGroup" action="/GraphSDKSample/Group?op=updateGroup&objectId=<%=objectId%>&oldDisplayName=<%=displayName%>" method="post"><label style="color: #FF0000" >*</label><label>indicates a mandatory field</label><br/>	
	<fieldset>
    <legend>Group</legend>

   		 <div class="editor-label">
            <label for="displayName">DisplayName</label> <label style="color: #FF0000" >*</label>
        </div>
        <div class="editor-field">
            <input required="required" class="text-box single-line" id="displayName" name="displayName" type="text" value="<%=displayName %>" />
        </div>

        <div class="editor-label">
            <label for="MailNickname">MailNickname</label> <label style="color: #FF0000" >*</label>
        </div>
        <div class="editor-field">
            <input required="required" class="text-box single-line" id="mailNickname" name="mailNickname" type="text" value="<%=mailNickname %>" />
        </div>
        
        <div class="editor-label">
            <label for="securityEnabled">MailEnabled</label> <label style="color: #FF0000" >*</label>
        </div>
        <div class="editor-field">
            <select required="required" class="list-box tri-state" id="mailEnabled" name="mailEnabled">
            	<option <%if(mailEnabled.equalsIgnoreCase("Not Set")) out.print("selected=\"selected\""); %> value="">Not Set</option>
				<option <%if(mailEnabled.equalsIgnoreCase("true")) out.print("selected=\"selected\""); %>value="true">True</option>
				<option <%if(mailEnabled.equalsIgnoreCase("false")) out.print("selected=\"selected\""); %>value="false">False</option>
			</select>
        </div>

       <div class="editor-label">
            <label for="securityEnabled">SecurityEnabled</label> <label style="color: #FF0000" >*</label>
        </div>
        <div class="editor-field">
            <select required="required" class="list-box tri-state" id="securityEnabled" name="securityEnabled">
            	<option <%if(securityEnabled.equalsIgnoreCase("Not Set")) out.print("selected=\"selected\""); %> value="">Not Set</option>
				<option <%if(securityEnabled.equalsIgnoreCase("true")) out.print("selected=\"selected\""); %>value="true">True</option>
				<option <%if(securityEnabled.equalsIgnoreCase("false")) out.print("selected=\"selected\""); %>value="false">False</option>
			</select>
        </div>
        
        <div class="editor-label">
            <label for="description">Description</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="description" name="description" type="text" value="<%=description %>" />
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