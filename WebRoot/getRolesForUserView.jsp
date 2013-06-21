<%@ page language="java" contentType="text/html" import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html" import="java.util.Map" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.RoleList" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.Role" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="Site.css" />
<title>User Management</title>
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
	   <%
 	   	RoleList allRolesPage = (RoleList)session.getAttribute("AllRolesList");
   		if (allRolesPage == null) {
		   	out.println("Sorry! Fetching Roles Error Encountered.");
		   	return;
   		}		
   		RoleList userRolesList = (RoleList)session.getAttribute("UserRolesList");
   		// build map for userRolesPage
   		Map<String, Role> userRolesMap = new HashMap<String, Role>();
   		for(int i = 0 ; i < userRolesList.getRolesSize(); i ++){
	 	   	String objectId = userRolesList.getRoleObjectId(i);
	 	   	Role role = userRolesList.getRole(i);
	 	   	userRolesMap.put(objectId, role);
   		}
   		String userDisplayName = session.getAttribute("displayName").toString();
   		String userObjectId = session.getAttribute("objectId").toString();
   		String rolesToAdd = "";
   		String rolesToRemove = "";
       	for(int i = 0; i < allRolesPage.getRolesSize(); i++){
       		String objectId = allRolesPage.getRoleObjectId(i);
       		String displayName = allRolesPage.getRoleDisplayName(i);
       		if( !userRolesMap.containsKey(objectId)){
       			rolesToAdd +="<input type=\"checkbox\" name=\"addRoles\" value=\"" + objectId + "\"/>" + displayName + "<br />";
       		}else{
       			rolesToRemove += "<input type=\"checkbox\"  name=\"removeRoles\" value=\"" + objectId + "\"/> " + displayName + "<br />";
       		}
       	}
 	   %>
     <div id="main"> 
  
		<h2>Manage Roles for <%=userDisplayName%></h2>

		<h3>Assign Role</h3>
	 <form action="/GraphSDKSample/Role?op=updateUserWithRole" method="post">  
			<input id="userObjectId" name="userObjectId" type="hidden" value="<%=userObjectId %>" />  
			<input id="userDisplayName" name="userDisplayName" type="hidden" value="<%=userDisplayName %>" /> 
			<div id="rolesToAdd">
			<label >Add User to role:</label><br/>
		    	<%=rolesToAdd %>
		    <br/>
		    </div>
		    <div id="rolesToRemove">
			    <label>Remove User from role:</label><br/>
			    	<%=rolesToRemove %>
		    </div>     
		    <p>
		        <input type="submit"  value="Submit" /> | 
		        <a href="javaScript:history.go(-1);">Back to List</a>
		    </p>  
	 	</form> 
		</div>
	 <div class="footer"></div>
 </div> 
</body>
</html>