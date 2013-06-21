<%@ page language="java" contentType="text/html" import="java.util.HashMap" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.GroupList" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="Site.css" />
<title>Group Management</title>

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
			<h2>Group Management</h2>
			<p>
			    <a href="/GraphSDKSample/Group?op=getCreateGroupView">Create New</a> 
			</p>
			<form action="/GraphSDKSample/Group" method="GET">     
		    	<p>Query by Display Name:<select class="list-box" id="attributeName" name="attributeName" hidden="hidden">
						        <option value="DisplayName" selected="selected">Display Name</option>
							</select>
							<select name="opName" hidden="hidden">
								<option value="eq" selected="selected">=</option>
							</select>	
						<input required="required" id="searchString" name="searchString" type="text" value="" />					   
			        <input type="hidden" Name ="op" type="submit" value="queryGroup" />
			        <input type="submit" value="Search" />
		    	</p> 
			</form>
			
			
 	
 	<table id="users">
 	<tr>
 		<th>DisplayName</th>
 		<th>Description</th>
 		<th>MailEnabled</th>
 		<th>SecurityEnabled</th>
		<th>DirSyncEnabled</th>
		
		<th></th>
 	</tr>
 	<%
 		GroupList groupList = (GroupList) session.getAttribute("groupList");	
 	 	 	 	
 	 	 			if(groupList == null){
 			 	 		out.println("Sorry! Fetching Groups Error Encountered.");
 			 	 		return;
 	 	 			}

 	 	 			for(int i = 0; i < groupList.getListSize(); i++){
 	 	 				
 	 	 				String dirSyncEnabled = groupList.getGroupDirSyncEnabled(i);
 	 	 				if(dirSyncEnabled == null || dirSyncEnabled.length() == 0) dirSyncEnabled = "Not Set";
 	 	 				String mailEnabled = groupList.getGroupMailEnabled(i);
 	 	 				if(mailEnabled == null || mailEnabled.length() == 0) mailEnabled = "Not Set";
 	 	 				String securityEnabled = groupList.getGroupSecurityEnabled(i);
 	 	 				if(securityEnabled == null || securityEnabled.length() == 0) securityEnabled = "Not Set";
 	 	 				String displayName = groupList.getGroupDisplayName(i);
 	 	 				String objectId = groupList.getGroupObjectId(i);
 	 	 				
 			 	 		out.println("<tr>");
 			 	 		out.println("<td>" + displayName + "</td>");
 			 	 		out.println("<td>" + groupList.getGroupDescription(i) + "</td>");
 			 	 		out.println("<td><select class=\"tri-state list-box\" disabled=\"disabled\">"
 		 	 				     + "<option value=\"\" selected=\"selected\">" + mailEnabled + "</option>"
 		 	 				     + "</select></td>");
 			 	 		out.println("<td><select class=\"tri-state list-box\" disabled=\"disabled\">"
 		 	 				     + "<option value=\"\" selected=\"selected\">" + securityEnabled + "</option>"
 		 	 				     + "</select></td>");
 			 	 		out.println("<td><select class=\"tri-state list-box\" disabled=\"disabled\">"
 			 	 				     + "<option value=\"\" selected=\"selected\">" + dirSyncEnabled + "</option>"
 			 	 				     + "</select></td>");
 			 	 		
 			 	 		out.println("<td><a href=\"/GraphSDKSample/Group?op=getUpdateGroupView&index=" + i + "\">Edit</a>"
 			 	 				+ "|<a href=\"/GraphSDKSample/Group?op=getSingleGroup&objectId=" + objectId + "&index=" + i + "\">Details</a>"
 			 	 				+ "|<a href=\"/GraphSDKSample/Group?op=getDeleteGroupView&index=" + i + "\">Delete</a>"
 			 	 				+ "|<a  href=\"/GraphSDKSample/Group?op=getUsersForGroup&DisplayName=" + displayName + "&objectId=" + objectId + "\">User Management</a></td>");
 			 	 		out.println("</tr>");
 	 	 			}
 	%>
 	</table>
		  	<a href="/GraphSDKSample/Group?op=getMultiGroups">Return to complete list</a> 
		</div>
	 <div class="footer"></div>
 </div> 

</body>
</html>