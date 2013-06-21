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
	var isGreen = validate();
	return isGreen;
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
		<h2>Create Group</h2>
		<form action="/GraphSDKSample/Group?op=createGroup" onsubmit="return preProcess();" method="post"><label style="color: #FF0000" >*</label><label>indicates a mandatory field</label><br />
    <fieldset>
        <legend>Group</legend>

        <div class="editor-label">
            <label for="displayName">DisplayName</label> <label style="color: #FF0000" >*</label>
        </div>
        <div class="editor-field">
            <input required="required" class="text-box single-line" id="displayName" name="displayName" type="text" value="" />
        </div>

        <div class="editor-label">
            <label for="mailNickname">MailNickname</label> <label style="color: #FF0000" >*</label>
        </div>
        <div class="editor-field">
            <input required="required" class="text-box single-line" id="mailNickname" name="mailNickname" type="text" value="" />
        </div>
        
        <div class="editor-label">
            <label for="securityEnabled">MailEnabled</label> <label style="color: #FF0000" >*</label>
        </div>
        <div class="editor-field">
            <select required="required" class="list-box tri-state" id="mailEnabled" name="mailEnabled">
            	<option selected="selected" value="">Not Set</option>
				<option value="true">True</option>
				<option value="false">False</option>
			</select>
        </div>

       <div class="editor-label">
            <label for="securityEnabled">SecurityEnabled</label> <label style="color: #FF0000" >*</label>
        </div>
        <div class="editor-field">
            <select required="required" class="list-box tri-state" id="securityEnabled" name="securityEnabled">
            	<option selected="selected" value="">Not Set</option>	
				<option value="true">True</option>
				<option value="false">False</option>
			</select>
        </div>
        
        <div class="editor-label">
            <label for="Description">Description</label>
        </div>
        <div class="editor-field">
            <input class="text-box single-line" id="description" name="description" type="text" value="" />
        </div>

        <p>
            <input type="submit" value="Create" />
        </p>
    </fieldset>
</form>
		<div>
		    <a href="/GraphSDKSample/Group?op=getMultiGroups">Back to List</a>
		</div>
	</div> 
    <div id="footer"></div> 
</div>

</body>
</html>