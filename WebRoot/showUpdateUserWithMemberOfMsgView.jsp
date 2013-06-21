<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="Site.css" />
<% 	
	// redirected from RoleServlet.java 
	
	String servletName = (String)request.getSession().getAttribute("servletName");
	if(servletName.equalsIgnoreCase("Role")) servletName = "User";
	String userDisplayName = (String)request.getSession().getAttribute("memberOfDisplayName");
	JSONArray feedBack = (JSONArray)request.getSession().getAttribute("feedBack");
    String mssg = "";
	String backButtonType = "hidden";
	String title = "Success";
	
    if(feedBack.length() == 0){
    	mssg = "<h2>None added or removed !</h2>";
    }else{
        for(int i = 0; i <feedBack.length(); i ++){
        	JSONObject obj = feedBack.optJSONObject(i);
        	int responseCode = obj.optInt("responseCode");
        	if( responseCode != 200 && responseCode != 204 ){
        		
        		mssg = "<h2>An error occurred while processing your request !</h2>";
				mssg += "<div><label>Controller Name: </label>" +  servletName + "</div>" 
			        + "<div><label> Name: </label>" + "add" + "</div>" 
			        + "<div><label> Error Code: </label>" + obj.optString("errorCode") + "</div>" 
			        + "<div><label> Name: </label>" +  obj.optString("errorMsg") + "</div><p></p>";
			    
				backButtonType = "button";
				title = "Error";
				break;
			}     
        }
        if(! title.equals("Error")){
        	 mssg += "<h2>" + servletName + " " + userDisplayName + " updated successfully !</h2>";
        }
       
    	
    }
%>

<title><%=title %></title>
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
			<div> <%=mssg%></div>	
			 	<input style="margin-left:400px;margin-right:10px;" class="button" type="<%=backButtonType %>" value="Back" onClick="javaScript:history.go(-1);">
				<input style="margin-left:10px;margin-right:10px" class="button" type="Submit" value="OK" onclick="location.href='/GraphSDKSample/<%=servletName%>?op=getMulti<%=servletName%>s'">
		</div>
		<div id="footer"></div> 
    </div> 
</body> 
</html>