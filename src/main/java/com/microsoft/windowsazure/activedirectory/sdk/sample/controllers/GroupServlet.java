package com.microsoft.windowsazure.activedirectory.sdk.sample.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.json.JSONArray;
import org.json.JSONObject;

import com.microsoft.windowsazure.activedirectory.sdk.graph.config.SdkConfig;
import com.microsoft.windowsazure.activedirectory.sdk.graph.config.TenantConfiguration;
import com.microsoft.windowsazure.activedirectory.sdk.graph.exceptions.SdkException;
import com.microsoft.windowsazure.activedirectory.sdk.graph.helper.JSONHelper;
import com.microsoft.windowsazure.activedirectory.sdk.graph.models.Group;
import com.microsoft.windowsazure.activedirectory.sdk.graph.models.GroupList;
import com.microsoft.windowsazure.activedirectory.sdk.graph.models.User;
import com.microsoft.windowsazure.activedirectory.sdk.graph.models.UserList;
import com.microsoft.windowsazure.activedirectory.sdk.graph.services.CommonService;
import com.microsoft.windowsazure.activedirectory.sdk.graph.services.GroupService;
import com.microsoft.windowsazure.activedirectory.sdk.graph.services.UserService;
import com.microsoft.windowsazure.activedirectory.sdk.sample.config.Config;

/**
 * This servlet works as the group controller of this web application. All the group
 * http requests are caught by this servlet and dispatched to the appropriate
 * business logic. Again, this servlet redirects the users to the appropriate
 * views, i.e., jsp pages based on the user request.
 * 
 * @author Azure Active Directory Contributor
 */
public class GroupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static GroupList groupList = null;
	private static final TenantConfiguration CONFIG = TenantConfiguration.getInstance(Config.tenantPropertiesPath);
	private static final TenantConfiguration tenant = TenantConfiguration.getInstance(Config.tenantPropertiesPath);
	private CommonService commonService = new CommonService(tenant);
	private GroupService groupService = new GroupService(tenant);
	private Logger logger  = Logger.getLogger(GroupServlet.class);	

	
	public GroupServlet() {
		super();
	}

	/**
	 * 
	 */
	@Override
	public void init() throws ServletException {
		
	//	ServletHelper.loadConfig(this.getServletConfig());
	//	PropertyConfigurator.configure(getServletContext().getRealPath("/") + "/../src/main/resource/log4j.properties");

	}

   /**
	 * 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @param request The Http Request object
	 * @param response The Http Response object
	 * @exception ServletException  Throws the ServletException
	 * @exception IOException Throws the IOException
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");

		int retryRemaining = Config.MAX_RETRY_ATTEMPTS;

		// Receive the operation from the Request Object.
		String reqReceived = request.getParameter("op");
		GroupList groupList = null;
		UserList usersInGroup = null;
		int index = 0;
		Group selectedGroup = null;
		String servletName = this.getServletName();
		while (retryRemaining > 0) {
			try {
				switch (reqReceived) {
				
				// If allusers request is received. Invoke the getUserPage method with the parameter pageNumber. 
				// Put the returned page into the session object and redirect user to the showUserPage view.
				case "getMultiGroups":				
					String skiptoken = request.getParameter("skiptoken");
					groupList = (GroupList)commonService.getDirectoryObjectList(GroupList.class, Group.class, true, skiptoken);
					GroupServlet.groupList = groupList;	
					request.getSession().setAttribute("groupList", groupList);
					request.getSession().setAttribute("servletName", servletName);
					if(groupList.getErrorObject() == null){							
						response.sendRedirect("getMultiGroupsView.jsp");
					}else{
						request.getSession().setAttribute("feedBack", groupList.getErrorObject());
						response.sendRedirect("error.jsp");
					}
					return;
				
				// getGroup is the 'get a single group' request. Comes with the parameter ObjectId: the ObjectId of the group requested.
				case "getSingleGroup":
					String objectId = request.getParameter("objectId");
					index = Integer.parseInt(request.getParameter("index").toString());
					Group group = (Group)commonService.getSingleDirectoryObject(Group.class, objectId);
					request.getSession().setAttribute("group", group);
					request.getSession().setAttribute("index", index);
					response.sendRedirect("getSingleGroupView.jsp");
					return;
					
				
				
				// showUsersForGroup is the show all users in the group. Comes with the parameter ObjectId: the ObjectId of the user requested.
				case "getUsersForGroup":
					String groupDisplayName = request.getParameter("displayName");
					String groupObjectId = request.getParameter("objectId");
					UserList usersAll = (UserList)commonService.getDirectoryObjectList(UserList.class, User.class, false, null);
					usersInGroup= groupService.getUsersForGroup(groupObjectId);
					request.getSession().setAttribute("usersInGroup", usersInGroup);
					request.getSession().setAttribute("usersAll", usersAll);
					request.getSession().setAttribute("displayName",  groupDisplayName);
					request.getSession().setAttribute("objectId", groupObjectId);
					response.sendRedirect("getUsersForGroupView.jsp");
					return;

				case "queryGroup":
					groupList = groupService.queryGroups(
							request.getParameter("attributeName"),
							request.getParameter("opName"),
							request.getParameter("searchString"));
					GroupServlet.groupList = groupList;
					request.getSession().setAttribute("groupList", groupList);
					response.sendRedirect("getQueryGroupView.jsp");
					return;
					
					// updateUser is the update User properties request. Comes with the index of the user
				case "getUpdateGroupView":
					index = Integer.parseInt(request.getParameter("index").toString());
					selectedGroup = GroupServlet.groupList.getGroup(index);
					request.getSession().setAttribute("group", selectedGroup);
					response.sendRedirect("getUpdateGroupView.jsp");	
					return;
					
				// The request for creating Group page.	
				case "getCreateGroupView":
					request.getSession().setAttribute("TenantDomainName", CONFIG.getTenantDomainName());
					response.sendRedirect("getCreateGroupView.jsp");
					return;

				// The request for delete group.	
				case "getDeleteGroupView":
					index = Integer.parseInt(request.getParameter("index").toString());
					selectedGroup = GroupServlet.groupList.getGroup(index);
					request.getSession().setAttribute("group", selectedGroup);

					response.sendRedirect("getDeleteGroupView.jsp");					
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

				
				// This means that the tenant is throttled temporarily, the error message will display back off time, 
				// the user of this application should wait that time and retry.
				case SdkConfig.MessageIdThrottledTemporarily:
					retryRemaining = 0;
					break;

				case SdkConfig.MessageIdUnauthorized:
				case SdkConfig.MessageIdExpired:
					// Try to generate a new Access Token and try again.
//						TenantConfiguration.setAccessToken(TokenGenerator.GetTokenFromUrl(
//								TenantConfiguration.getTenantContextId(),
//								TenantConfiguration.getAppPrincipalId(),
//								TenantConfiguration.getStsUrl(),
//								TenantConfiguration.getAcsPrincipalId(),
//								TenantConfiguration.getSymmetricKey(),
//								TenantConfiguration.getProtectedResourcePrincipalId(),
//								TenantConfiguration.getProtectedResourceHostName()));
					CONFIG.setAccessToken(CONFIG.getAccessToken());
					
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
		
		int retryRemaining = Config.MAX_RETRY_ATTEMPTS;
		
		// Retrieve the operation requested.
		String op = request.getParameter("op");
		JSONObject feedBack = null;
		String servletName = "";
		String groupObjectId = "";
		String groupDisplayName = "";
		while(retryRemaining-- > 0){
			try{
				switch(op){
					
					// If createUser request is received.
					case "createGroup":		
						servletName = this.getServletName();
						feedBack = commonService.createDirectoryObject(request, servletName);
						request.getSession().setAttribute("servletName", servletName);
						request.getSession().setAttribute("feedBack", feedBack);
						request.getSession().setAttribute("displayName", request.getParameter("displayName"));
						response.sendRedirect("showCreateMessageView.jsp");	
						return;
						
					//If the request is delete Group.		
					case "deleteGroup":
						// If the request is successfully carried out, send a success message to the user.
						servletName = this.getServletName();
						feedBack = commonService.deleteDirectoryObject(request, servletName);
						request.getSession().setAttribute("servletName", servletName);
						request.getSession().setAttribute("feedBack", feedBack);
						request.getSession().setAttribute("displayName", request.getParameter("displayName"));
						response.sendRedirect("showDeleteMessageView.jsp");	
						return;
	
					// If the request is update Group.				
					case "updateGroup":
						servletName = this.getServletName();
						feedBack = commonService.updateDirectoryObject(request.getParameter("objectId"), request, servletName);
						request.getSession().setAttribute("servletName", servletName);
						request.getSession().setAttribute("feedBack", feedBack);
						request.getSession().setAttribute("oldDisplayName", request.getParameter("oldDisplayName"));
						response.sendRedirect("showUpdateMessageView.jsp");
						return;
					
					// If the request is add user to Group.				
					case "updateUserWithGroup":
						servletName = this.getServletName();
					    groupObjectId = request.getParameter("groupObjectId");
					    groupDisplayName = request.getParameter("groupDisplayName");
					    String[] usersToAdd = request.getParameterValues("addUsers");
					    JSONArray addRolesFeedBack = commonService.addDirectoryObjectsToMemberOf(usersToAdd, groupObjectId, this.getServletName());
						String[] usersToRemove = request.getParameterValues("removeUsers");
					    JSONArray removeRolesFeedBack = commonService.removeDirectoryObjectsFromMemberOf(usersToRemove, groupObjectId, this.getServletName());

					    JSONArray comb = JSONHelper.joinJSONArrays(addRolesFeedBack, removeRolesFeedBack);
						request.getSession().setAttribute("feedBack", comb);
						request.getSession().setAttribute("servletName", servletName);
						request.getSession().setAttribute("memberOfDisplayName", groupDisplayName);
						response.sendRedirect("showUpdateUserWithMemberOfMsgView.jsp");
						return;
				}
			} catch (IOException | SdkException e) {
				
				e.printStackTrace();
			}
		}		
	}
}
