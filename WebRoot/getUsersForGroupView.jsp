<%@ page language="java" contentType="text/html" import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html" import="java.util.Map" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.UserList" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.User" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="Site.css" />
<script src="http://code.jquery.com/jquery-latest.js"></script>

<title>User Management</title>

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
	  <%
 	  	UserList usersInGroup = (UserList) session.getAttribute("usersInGroup");
 	  	if (usersInGroup == null) {
 	  		out.println("Sorry! Fetching UsersError Encountered.");
 	  		return;
 	  	}
 	  	UserList usersAll = (UserList) session.getAttribute("usersAll");
 	 
 	  	// build map for userUsersPage
 	  	Map<String, User> groupUsersMap = new HashMap<String, User>();
 	  	for (int i = 0; i < usersInGroup.getListSize(); i++) {
 	  		String objectId = usersInGroup.getDirectoryObjectObjectId(i);
 	  		User user = usersInGroup.getSingleDirectoryObject(i);
 	  		groupUsersMap.put(objectId, user);
 	  	}
 	  	String groupDisplayName = session.getAttribute("displayName").toString();
 	  	String groupObjectId = session.getAttribute("objectId").toString();
 	  	String usersToAdd = "";
 	  	String usersToRemove = "";
 	  	for (int i = 0; i < usersAll.getListSize(); i++) {
 	  		String objectId = usersAll.getDirectoryObjectObjectId(i);
 	  		String displayName = usersAll.getDirectoryObjectDisplayName(i);
 	  		if (!groupUsersMap.containsKey(objectId)) {
 	  			usersToAdd += "<input type=\"checkbox\" name=\"addUsers\" value=\"" + objectId + "\"/>" + displayName + "<br />";
 	  		} else {
 	  			usersToRemove += "<input type=\"checkbox\" name=\"removeUsers\" value=\"" + objectId + "\"/>" + displayName + "<br />";
 	  		}
 	  	}
 	  %>
     <div id="main">  
		<h2>Manage Users for <%=groupDisplayName%></h2>

		<h3>Assign User</h3>
  		<form action="/GraphSDKSample/Group?op=updateUserWithGroup" method="post">
			<input id="groupObjectId" name="groupObjectId" type="hidden" value="<%=groupObjectId %>" />  
			<input id="groupDisplayName" name="groupDisplayName" type="hidden" value="<%=groupDisplayName %>" /> 
			
			<div id="usersToAdd">
			<label >Add User to group:</label><br/>
		    	<%=usersToAdd %>
		    <br/>
		    </div>
		    <div id="usersToRemove">
		    <label>Remove User from group:</label><br/>
		    	<%=usersToRemove %>
		    </div>
		    <p>
		        <input type="submit" id ="submit" value="Submit" /> | 
		        <a href="javaScript:history.go(-1);">Back to List</a>
		    </p>        
 		</form> 
		</div>
	 <div class="footer"></div>
 </div> 
</body>
</html>