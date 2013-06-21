<%@ page language="java" contentType="text/html" import="java.util.HashMap" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.UserList" %>
<%@ page import="org.json.JSONObject" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="Site.css" />
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
     <div id="main"> 
		<h2>User Management</h2>
		<p>
		    <a href="/GraphSDKSample/User?op=getCreateUserView">Create New</a> 
		</p>
		<form action="/GraphSDKSample/User" method="GET">     
		    <p>Query by Display Name: <select class="list-box" id="attributeName" name="attributeName" hidden="hidden">
								        <option value="displayName" selected="selected">Display Name</option>
									</select>
									<select name="opName" hidden="hidden">
										<option value="eq" selected="selected" >=</option>
									</select>	
						<input required="required" id="searchString" name="searchString" type="text" value="" />					   
		        <input type="hidden" Name ="op" type="submit" value="queryUser" />
		        <input type="submit" value="Search" />
		    </p> 
		</form>
		<table>
		    <tr>
		        <th>DisplayName</th>
		        <th>UserPrincipalName</th>
		        <th>AccountEnabled</th>
		        <th>MailNickname</th>
		        <th></th>
		    </tr>
		 	<%
		 		UserList userList = (UserList) session.getAttribute("userList");
		 		String servletName = (String)session.getAttribute("servletName");
		 		if (userList == null) {
		 			out.println("Sorry! Fetching UsersError Encountered.");
		 			return;
		 		}		
		 		
		 		for (int i = 0; i < userList.getListSize(); i++) {
		 			String accountEnabled = userList.getUserAccountEnabled(i);
		 			String displayName = userList.getDirectoryObjectDisplayName(i);
		 			String upn = userList.getUserPrincipalName(i);
		 			String objectId = userList.getDirectoryObjectObjectId(i);
 	 				if(accountEnabled == null || accountEnabled.length() == 0) accountEnabled = "Not Set";		 			
		 			out.println("<tr>");
		 	 		out.println("<td>" + displayName + "</a></td>");
		 	 		out.println("<td>" + upn + "</td>");
		 	 		out.println("<td><select class=\"tri-state list-box\" disabled=\"disabled\">"
	 	 				     + "<option value=\"\" selected=\"selected\">" + accountEnabled + "</option>"
	 	 				     + "</select></td>");
		 	 		out.println("<td>" + userList.getUserMailNickname(i) + "</td>");
		 	 		out.println("<td><a href=\"/GraphSDKSample/User?op=getUpdateUserView&index=" + i + "\">Edit</a>"
		 	 				+ "|<a href=\"/GraphSDKSample/User?op=getSingleUser&objectId=" + objectId + "&index=" + i + "\">Details</a>"
		 	 				+ "|<a href=\"/GraphSDKSample/User?op=getDeleteUserView&index=" + i + "\">Delete</a>"
		 	 				+ "|<a href=\"/GraphSDKSample/Role?op=getRolesForUser&displayName=" + displayName + "&objectId=" + objectId + "\">Manage Roles</a></td>");
		 	 		out.println("</tr>");
		 		}
		 		
		 	%>
		</table>
		<%  String nextSkiptoken = userList.getNextSkipToken();
			if (nextSkiptoken != null && nextSkiptoken.length() > 0) {
				String urlNextPage = "\"/GraphSDKSample/User?op=getMultiUsers&skiptoken=" + nextSkiptoken + "\"";
		%> 
		<a  href=<%=urlNextPage%>><b>next&gt;</b></a>
		<%
			} else {
		%>
				<b>next&gt;</b>
		<%
			}
		%>
		</div>
	 <div class="footer"></div>
 </div> 
</body>
</html>