<%@ page language="java" contentType="text/html" import="java.util.HashMap" %>
<%@ page import="com.microsoft.windowsazure.activedirectory.sdk.graph.models.UserList" %>
<%@ page import="org.json.JSONObject" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="Site.css" />
<% 	
	//redirected from UserServlet.java and GroupServlet.java
	JSONObject feedBack = (JSONObject)request.getSession().getAttribute("feedBack");
	int responseCode = feedBack.optInt("responseCode");
	String title = "";
	if( responseCode == 200 || responseCode == 204 ){
		title = "Success";
	}else{
		title = "Error";	
	}	
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
			<%
				String servletName = request.getSession().getAttribute("servletName").toString();
				String oldDisplayName = request.getSession().getAttribute("oldDisplayName").toString();
				String mssg = "";
				String backButtonType = "";
				if( responseCode == 200 || responseCode == 204 ){
					mssg= servletName + " " + oldDisplayName + " updated successfully !";
					backButtonType = "hidden";
				}else{
					mssg = "<h2>An error occurred while processing your request !</h2>";
					mssg += "<div><label>Controller Name: </label>" +  servletName + "</div>" 
				        + "<div><label> Name: </label>" + "Submit" + "</div>" 
				        + "<div><label> Error Code: </label>" + feedBack.optString("errorCode") + "</div>" 
				        + "<div><label> Name: </label>" +  feedBack.optString("errorMsg") + "</div><p></p>";
					backButtonType = "button";
				}	
			%>
			
			<div class="main">
				<div><h2> <%=mssg%></h2></div>	
			
				
				 	<input style="margin-left:400px;margin-right:10px;" class="button" type="<%=backButtonType %>" value="Back" onClick="javaScript:history.go(-1);">
					<input style="margin-left:10px;margin-right:10px" class="button" type="Submit" value="OK" onclick="location.href='/GraphSDKSample/<%=servletName%>?op=getMulti<%=servletName%>s'">
			
					
			</div>
 		 	<div id="footer"></div> 
    	</div> 
    </div>
</body> 
</html>