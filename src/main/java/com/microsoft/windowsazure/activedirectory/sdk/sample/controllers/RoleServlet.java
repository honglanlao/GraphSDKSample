package com.microsoft.windowsazure.activedirectory.sdk.sample.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.json.JSONArray;

import com.microsoft.windowsazure.activedirectory.sdk.graph.config.SdkConfig;
import com.microsoft.windowsazure.activedirectory.sdk.graph.config.TenantConfiguration;
import com.microsoft.windowsazure.activedirectory.sdk.graph.exceptions.SdkException;
import com.microsoft.windowsazure.activedirectory.sdk.graph.helper.JSONHelper;
import com.microsoft.windowsazure.activedirectory.sdk.graph.helper.ServletHelper;
import com.microsoft.windowsazure.activedirectory.sdk.graph.models.Role;
import com.microsoft.windowsazure.activedirectory.sdk.graph.models.RoleList;
import com.microsoft.windowsazure.activedirectory.sdk.graph.services.CommonService;
import com.microsoft.windowsazure.activedirectory.sdk.graph.services.GroupService;
import com.microsoft.windowsazure.activedirectory.sdk.graph.services.UserService;
import com.microsoft.windowsazure.activedirectory.sdk.graph.token.TokenGenerator;
import com.microsoft.windowsazure.activedirectory.sdk.sample.config.Config;

/**
 * This servlet works as the controller of this web application. All the role
 * http requests are caught by this servlet and dispatched to the appropriate
 * business logic. Again, this servlet redirects the roles to the appropriate
 * views, i.e., jsp pages based on the role request.
 * 
 * @author Azure Active Directory Contributor
 */
public class RoleServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private static final TenantConfiguration CONFIG = TenantConfiguration.getInstance(Config.tenantPropertiesPath);
	private static final TenantConfiguration tenant = TenantConfiguration.getInstance(Config.tenantPropertiesPath);
	private CommonService commonService = new CommonService(tenant);
	private UserService userService = new UserService(tenant);
	private Logger logger  = Logger.getLogger(RoleServlet.class);

	public RoleServlet() {
		super();
	}

	/**
	 
	 */
	@Override
	public void init() throws ServletException {
		
	//	ServletHelper.loadConfig(this.getServletConfig());
		PropertyConfigurator.configure(getServletContext().getRealPath("/") + "/../src/main/resource/log4j.properties");

	}

	/**
	 * This is the overridden version of the doGet Method. This method catches
	 * all the get http requests and dispatches them to the appropriate
	 * background services depending on the request. Finally, this method
	 * redirects the roles to the appropriate view, i.e., the JSP page based on
	 * the role request.
	 * 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @param request The Http Request object
	 * @param response The Http Response object
	 * @exception ServletException  Throws the ServletException
	 * @exception IOException Throws the IOException
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

		response.setContentType("text/html");

		int retryRemaining = Config.MAX_RETRY_ATTEMPTS;

		// Receive the operation from the Request Object.
		String action = request.getParameter("op");
		RoleList allRolesList = null;
		while (retryRemaining > 0) {
			try {
				switch (action){
					// showRolesForUser is the 'show all roles enrolled by user' request. Comes with
					case "getRolesForUser":
						String userDisplayName = request.getParameter("displayName");
						String userObjectId = request.getParameter("objectId");
						
						String skiptoken = request.getParameter("skiptoken");
						allRolesList =  (RoleList)commonService.getDirectoryObjectList(RoleList.class, Role.class, false, skiptoken); // Role does not support paging
						
					//	allRolesList = RoleService.getRoleList();
						RoleList userRolesList = userService.getRolesForUser(userObjectId);
						logger.info("userRolesList ->" + userRolesList);
						request.getSession().setAttribute("AllRolesList", allRolesList);
						request.getSession().setAttribute("UserRolesList", userRolesList);
						request.getSession().setAttribute("displayName", userDisplayName);
						request.getSession().setAttribute("objectId", userObjectId);						
						response.sendRedirect("getRolesForUserView.jsp");
						return;

					// The request is not familiar. Just show an Error Message to the role.
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
					// want to display an error message to the role and exit.
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
					// error message will display back off time, the role of this
					// application should wait that time and retry.
					case SdkConfig.MessageIdThrottledTemporarily:
						retryRemaining = 0;
						break;
	
					case SdkConfig.MessageIdUnauthorized:
						
					case SdkConfig.MessageIdExpired:
					// Try to generate a new Access Token and try again.
						CONFIG.setAccessToken(CONFIG.getAccessToken());

					retryRemaining--;
					break;
					default:
						retryRemaining--;
						break;
				}

				// If there is no retryRemaining left, Just return an error
				// message to the role and return from the servlet.
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
	 * requests such as create role, create group etc. Upon receiving a request, this method
	 * would dispatch the request to the appropriate business logic and finally redirect the role
	 * to the appropriate view page.
	 * @param request This is the http request object.
	 * @param response This is the http response object. 
	 * @throws IOException 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponseresponse)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		response.setContentType("text/html");
		
		int retryRemaining = Config.MAX_RETRY_ATTEMPTS;

		// Retrieve the operation requested.		
		String op = request.getParameter("op");		
		String servletName = ""; 
		String userObjectId = "";
		String userDisplayName = "";
		while(retryRemaining-- > 0){
			try{
				switch(op){
				// If request is add user to Role
				case "updateUserWithRole":
					servletName = this.getServletName();
					userObjectId = request.getParameter("userObjectId");
				    userDisplayName = request.getParameter("userDisplayName");
				    
				    String[] rolesToAdd = request.getParameterValues("addRoles");
				    JSONArray addRolesFeedBack = commonService.addDirectoryObjectsToMemberOf(userObjectId, rolesToAdd, this.getServletName());
				    
					String[] rolesToRemove = request.getParameterValues("removeRoles");
				    JSONArray removeRolesFeedBack = commonService.removeDirectoryObjectsFromMemberOf(userObjectId, rolesToRemove, this.getServletName());
				   
				    JSONArray comb = JSONHelper.joinJSONArrays(addRolesFeedBack, removeRolesFeedBack);
					request.getSession().setAttribute("feedBack", comb);
					request.getSession().setAttribute("servletName", servletName);
					request.getSession().setAttribute("memberOfDisplayName", userDisplayName);
					response.sendRedirect("showUpdateUserWithMemberOfMsgView.jsp");
					return;
				    
				}	
			} catch (SdkException e) {
				e.printStackTrace();
			}
		}
		
	}

}
