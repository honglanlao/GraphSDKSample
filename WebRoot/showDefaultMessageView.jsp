<%@ page language="java" contentType="text/html" import="java.util.HashMap" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.UserList" %>
<%@ page import="org.json.JSONObject" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="Site.css" />
<% 	

	String mssg = (String)request.getSession().getAttribute("message");
	if(mssg == null){
		mssg = "Unexpected Error Occured!";
	}
	String title = "Error";
	
%>

<title><%=title %></title>
</head>
<body>

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
			
			<div class="main">
				<div><h2> <%=mssg%></h2></div>	
				 	<input style="margin-left:400px;margin-right:10px;" class="button" type="button" value="Back" onClick="javaScript:history.go(-1);">						
			</div>
 		 	<div id="footer"></div> 
    	</div> 
    </div>
</body> 
</html>