package com.microsoft.windowsazure.activedirectory.sdk.sample.controllers;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.json.JSONObject;

import com.microsoft.windowsazure.activedirectory.sdk.graph.config.SdkConfig;
import com.microsoft.windowsazure.activedirectory.sdk.graph.config.TenantConfiguration;
import com.microsoft.windowsazure.activedirectory.sdk.graph.exceptions.SdkException;
import com.microsoft.windowsazure.activedirectory.sdk.graph.helper.ServletHelper;
import com.microsoft.windowsazure.activedirectory.sdk.graph.models.User;
import com.microsoft.windowsazure.activedirectory.sdk.graph.models.UserList;
import com.microsoft.windowsazure.activedirectory.sdk.graph.services.CommonService;
import com.microsoft.windowsazure.activedirectory.sdk.graph.services.UserService;
import com.microsoft.windowsazure.activedirectory.sdk.graph.token.TokenGenerator;
import com.microsoft.windowsazure.activedirectory.sdk.sample.config.SampleConfig;

 /**
  * This servlet works as the User controller of this web application. All the user
  * http requests are caught by this servlet and dispatched to the appropriate
  * business logic. Again, this servlet redirects the users to the appropriate
  * views, i.e., jsp pages based on the user request.
  * @author Azure Active Directory Contributor
  *
  */
public class UserServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static UserList userList = null;
	
	private Logger logger  = Logger.getLogger(UserServlet.class);	
	
	public UserServlet() {
		
		super();
		 
	}

	/**
	 *
	 */	
	@Override
	public void init() throws ServletException {

	//	ServletHelper.loadConfig(this.getServletConfig());
		PropertyConfigurator.configure(getServletContext().getRealPath("/") + "/../src/main/resource/log4j.properties");
	}


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @param request The Http Request object
	 * @param response The Http Response object
	 * @exception ServletException  Throws the ServletException
	 * @exception IOException Throws the IOException
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");

		int retryRemaining = SampleConfig.MAX_RETRY_ATTEMPTS;

		// Receive the operation from the Request Object.
		String action = request.getParameter("op");
		UserList userList = null;
		int index = 0;
		User selectedUser = null;
		String servletName = this.getServletName();
		while (retryRemaining > 0) {
			try {
				switch (action){
					
					// get all users, could be filtered by $top=
					case "getMultiUsers":
						String skiptoken = request.getParameter("skiptoken");
						userList =  (UserList)CommonService.getDirectoryObjectList(UserList.class, User.class, true, skiptoken);
					//	logger.info(userList);
						UserServlet.userList = userList;	
						request.getSession().setAttribute("userList", userList);
						request.getSession().setAttribute("servletName", servletName);
						if(userList.getErrorObject() == null){							
							response.sendRedirect("getMultiUsersView.jsp");
						}else{
							request.getSession().setAttribute("feedBack", userList.getErrorObject());
							response.sendRedirect("error.jsp");
						}
						
						return;

					// get only one user request. Comes with the parameter objectId
					case "getSingleUser":
						index = Integer.parseInt(request.getParameter("index").toString());
						User user = (User)CommonService.getSingleDirectoryObject(User.class, request.getParameter("objectId"));
						request.getSession().setAttribute("user", user);
						request.getSession().setAttribute("index", index);
						response.sendRedirect("getSingleUserView.jsp");
						return;	
					
					case "getThumbnail":
						response.setContentType("image/jpg");
						byte[] imageInByte = UserService.getThumbnail(request.getParameter("objectId"));
						OutputStream os = response.getOutputStream();
						os.write(imageInByte, 0, imageInByte.length);						
						return;

					// queryUser is the request where if 'x.attributeName operatorName searchString' is satisfied. 
					//	For example, if attributeName = DisplayName, operator=eq and searchString="John Doe", then an user x
					// would be in the resultset if and only if the condition "x.DisplayName eq 'John Doe'" holds.
					case "queryUser":
						userList = UserService.queryUsers(
								request.getParameter("attributeName"),
								request.getParameter("opName"),
								request.getParameter("searchString"));
						UserServlet.userList = userList;	
						request.getSession().setAttribute("userList", userList);
						response.sendRedirect("getQueryUserView.jsp");
						return;
						
					// updateUser is the update User properties request. Comes with
					// the parameter ObjectId: the ObjectId of the user requested.	
					case "getUpdateUserView":
						index = Integer.parseInt(request.getParameter("index").toString());
						selectedUser = UserServlet.userList.getSingleDirectoryObject(index);
						request.getSession().setAttribute("user", selectedUser);
						response.sendRedirect("getUpdateUserView.jsp");	
						return;
						
					// The request for creating user.	
					case "getCreateUserView":
						request.getSession().setAttribute("TenantDomainName", TenantConfiguration.getTenantDomainName());
						response.sendRedirect("getCreateUserView.jsp");
						return;
					
					// The request for creating user.	
					case "getDeleteUserView":
						index = Integer.parseInt(request.getParameter("index").toString());
						selectedUser = UserServlet.userList.getSingleDirectoryObject(index);
						request.getSession().setAttribute("user", selectedUser);
						response.sendRedirect("getDeleteUserView.jsp");					
						return;
						
					// The request is not familiar. Just show an Error Message to the user.
					default:
						request.getSession().setAttribute("message", "Error: Unknown Request Encountered!");
						response.sendRedirect("showDefaultMessageView.jsp");
						return;
				}
			} catch (SdkException e) {
				
				// We take different actions based on different type of exceptions.
				switch (e.getCode()) {
					// For the following long list of exceptions, there is nothing
					// too much we can do. So, we do not prefer to retry. We just
					// want to display an error message to the user and exit.
					case SdkConfig.MessageIdAuthorizationIdentityDisabled:
					case SdkConfig.MessageIdAuthorizationIdentityNotFound:
					case SdkConfig.MessageIdAuthorizationRequestDenied:
					case SdkConfig.MessageIdBadRequest:
					case SdkConfig.MessageIdBindingRedirectionInternalServerError:
					case SdkConfig.MessageIdContractVersionHeaderMissing:
					case SdkConfig.MessageIdHeaderNotSupported:
					case SdkConfig.MessageIdInternalServerError:
					case SdkConfig.MessageIdInvalidApiVersion:
					case SdkConfig.MessageIdInvalidReplicaSessionKey:
					case SdkConfig.MessageIdInvalidRequestUrl:
					case SdkConfig.MessageIdMediaTypeNotSupported:
					case SdkConfig.MessageIdMultipleObjectsWithSameKeyValue:
					case SdkConfig.MessageIdObjectNotFound:
					case SdkConfig.MessageIdResourceNotFound:
					case SdkConfig.MessageIdThrottledPermanently:
					case SdkConfig.MessageIdUnknown:
					case SdkConfig.MessageIdUnsupportedQuery:
					case SdkConfig.MessageIdUnsupportedToken:
						retryRemaining = 0;
						break;

					// This means the replica we are trying to go to is unavailable,
					// retry will possibly go to another replica and work.
					case SdkConfig.MessageIdReplicaUnavailable:
						retryRemaining--;
						break;
	
					// This means that the tenant is throttled temporarily, the
					// error message will display back off time, the user of this
					// application should wait that time and retry.
					case SdkConfig.MessageIdThrottledTemporarily:
						retryRemaining = 0;
						break;
	
					case SdkConfig.MessageIdUnauthorized:
					case SdkConfig.MessageIdExpired:
						// Try to generate a new Access Token and try again.
						TenantConfiguration.setAccessToken(TenantConfiguration.getAccessToken());
						retryRemaining--;
						break;

					default:
						retryRemaining--;
						break;

				}
				
				// If there is no retryRemaining left, Just return an error message to the user and return from the servlet.
				if (retryRemaining == 0) {
					request.getSession().setAttribute("message",
							"Error:" + e.getCode() + "! " + e.getMessage());
					response.sendRedirect("showDefaultMessageView.jsp");
					return;
				}
			}

		}
	}

	
	/**
	 * This is the overridden doPost method. This method would receive all the create objects
	 * requests such as create user, create group etc. Upon receiving a request, this method
	 * would dispatch the request to the appropriate business logic and finally redirect the user
	 * to the appropriate view page.
	 * @param request This is the http request object.
	 * @param response This is the http response object. 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponseresponse)
	 */
	 
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		
		response.setContentType("text/html");
		
		int retryRemaining = SampleConfig.MAX_RETRY_ATTEMPTS;

		// Retrieve the operation requested.		
		String op = request.getParameter("op");
		JSONObject feedBack = null;
		String servletName = "";
		while(retryRemaining-- > 0){
			try{
				switch(op){
			
				// If createUser request is received.
				case "createUser":
					// If the request is successfully carried out, send a success message to the user.
					servletName = this.getServletName();
					request.setAttribute("UserPrincipalName", request.getAttribute("emailAlias") + "@" + request.getAttribute("selectedDomain"));
					feedBack = CommonService.createDirectoryObject(request, servletName);
					request.getSession().setAttribute("servletName", servletName);
					request.getSession().setAttribute("feedBack", feedBack);
					request.getSession().setAttribute("displayName", request.getParameter("displayName"));
					response.sendRedirect("showCreateMessageView.jsp");	
					return;
					
				case "deleteUser":
					// If the request is successfully carried out, send a success message to the user.
					servletName = this.getServletName();
					feedBack = CommonService.deleteDirectoryObject(request, servletName);
					request.getSession().setAttribute("servletName", servletName);
					request.getSession().setAttribute("feedBack", feedBack);
					request.getSession().setAttribute("displayName", request.getParameter("displayName"));
					response.sendRedirect("showDeleteMessageView.jsp");	
					return;

				// If the request is update User.
				case "updateUser":
					servletName = this.getServletName();
					feedBack = CommonService.updateDirectoryObject(request.getParameter("objectId"), request, this.getServletName());
					request.getSession().setAttribute("servletName", servletName);
					request.getSession().setAttribute("feedBack", feedBack);
					request.getSession().setAttribute("oldDisplayName", request.getParameter("oldDisplayName"));
					response.sendRedirect("showUpdateMessageView.jsp");
					return;
				}	
			} catch (IOException | SdkException e) {
				e.printStackTrace();
			}
		}
	}
}
