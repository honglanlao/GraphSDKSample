package com.microsoft.windowsazure.activedirectory.sdk.sample.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.microsoft.windowsazure.activedirectory.sdk.graph.config.SdkConfig;
import com.microsoft.windowsazure.activedirectory.sdk.graph.helper.ServletHelper;
import com.microsoft.windowsazure.activedirectory.sdk.sample.config.SampleConfig;

/**
 * This servlet works as the Home controller of this web application. All the user
 * http requests are caught by this servlet and dispatched to the appropriate
 * business logic. Again, this servlet redirects the users to the appropriate
 * views, i.e., jsp pages based on the user request.
 * 
 * @author Azure Active Directory Contributor
 */
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public HomeServlet() {
		super();
	}

	@Override
	public void init() throws ServletException {
		
	//	ServletHelper.loadConfig(this.getServletConfig());
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 * @param request
	 *            The Http Request object
	 * @param response
	 *            The Http Response object
	 * @exception ServletException
	 *                Throws the ServletException
	 * @exception IOException
	 *                Throws the IOException
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");

		int retryRemaining = SampleConfig.MAX_RETRY_ATTEMPTS;
		
		// Receive the operation from the Request Object.
		String action = request.getParameter("op");
		while (retryRemaining > 0) {
			switch (action){

				//Just print a short About message to the user.
				case "about":
					request.getSession().setAttribute("message", SdkConfig.ABOUT_MESSAGE);
					response.sendRedirect("showAbout.jsp");
					return;

				// The request is not familiar. Just show an Error Message to the user.
				default:
					request.getSession().setAttribute("message", "Error: Unknown Request Encountered!");
					response.sendRedirect("showDefaultMessageView.jsp");
					return;
			}
		}
	}

	/*
	 * @param request This is the http request object.
	 * @param response This is the http response object. 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponseresponse)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response){}

}
