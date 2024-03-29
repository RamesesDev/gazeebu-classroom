<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ attribute name="before_rendering" fragment="true" %>
<%@ attribute name="head" fragment="true" %>
<%@ attribute name="script" fragment="true" %>
<%@ attribute name="style" fragment="true" %>
<%@ attribute name="header_middle" fragment="true" %>
<%@ attribute name="pageTitle" fragment="false"%>
<%@ attribute name="sections" fragment="true"%>


<c:if test="${empty SESSIONID}">
	<%
		String uri = request.getRequestURI();
		String qs = request.getQueryString();
		if( qs != null )
			uri = uri + "?" + qs;
		
		response.sendRedirect("authenticate.jsp?u=" + java.net.URLEncoder.encode(uri));
	%>
</c:if>

<c:if test="${!empty SESSIONID and empty SESSION_INFO}">
	<s:invoke service="SessionService" method="getInfo" params="${SESSIONID}" var="SESSION_INFO"/>
	<c:if test="${empty SESSION_INFO}">
	<%		
		String uri = request.getRequestURI();
		String qs = request.getQueryString();
		if( qs != null )
		uri = uri + "?" + qs;
		
		//remove the cookie
		Cookie cookie = new Cookie("sessionid", "");
		cookie.setMaxAge(0);
		response.addCookie( cookie );
		
		response.sendRedirect(request.getContextPath() + "/authenticate.jsp?u=" + java.net.URLEncoder.encode(uri));
	%>
	</c:if>
</c:if>

<%

//get the app version
request.setAttribute("APP_VERSION", application.getInitParameter("app.version"));

%>

<c:if test="${!empty SESSIONID}">
	<s:invoke service="SessionService" method="getInfo" params="${SESSIONID}" var="SESSION_INFO"/>

	<jsp:invoke fragment="before_rendering"/>
	<!DOCTYPE html>
	<html>
		<head>
			<title>Gazeebu Classroom<c:if test="${not empty pageTitle}"> - ${pageTitle}</c:if></title>
			
			<link href="${pageContext.servletContext.contextPath}/js/lib/css/jquery-ui/jquery.css?v=${APP_VERSION}" type="text/css" rel="stylesheet" />
			<link href="${pageContext.servletContext.contextPath}/js/lib/css/rameses-lib.css?v=${APP_VERSION}" type="text/css" rel="stylesheet" />
			<link href="${pageContext.servletContext.contextPath}/js/ext/jscrollpane/jscrollpane.css?v=${APP_VERSION}" type="text/css" rel="stylesheet" />
			<link href="${pageContext.servletContext.contextPath}/css/secured.css?v=${APP_VERSION}" type="text/css" rel="stylesheet" />
			
			<script src="${pageContext.servletContext.contextPath}/js/lib/jquery-all.js?v=${APP_VERSION}"></script>
			<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-ext-lib.js?v=${APP_VERSION}"></script>
			<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-ui.js?v=${APP_VERSION}"></script>
			<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-proxy.js?v=${APP_VERSION}"></script>
			<script src="${pageContext.servletContext.contextPath}/js/lib/strophe.min.js?v=${APP_VERSION}"></script>
			<script src="${pageContext.servletContext.contextPath}/js/ext/jscrollpane/jscrollpane.js?v=${APP_VERSION}"></script>
			
			<script>
				Env.sessionid = $.cookie("sessionid");
				var Session = new Notifier( Env.sessionid, '/xmpp-httpbind' );
				Registry.add( {id:"#usermenu", context:"session"} );				
				ProxyService.contextPath = '${pageContext.request.contextPath}';
				
				//global options
				PopupOpener.options = {show:'', hide:''};
				
				//init scrollpanes
				$(function(){
					$('.scrollpane').jScrollPane({
						autoReinitialise: true,
						hideFocus: true
					});
				});
				
				
				$put("session",
					new function() 
					{
						var profileMenu;						
						this.showProfileMenu = function() {
							if( !profileMenu ) {
								profileMenu = new DropdownOpener( '#usermenu' );
								profileMenu.options = {
									styleClass: 'dropdownmenu',
									handleClassOnOpen: 'menu_open',
									position: {my: 'right top', at: 'right bottom'}
								};
							}
							return profileMenu;
						}
						
						this.onload = function() {
							Session.handlers.onmessage = function(o) {
								if( typeof o == 'string' && o.startsWith("_:ended:") ) {
									var sessid = o.replace("_:ended:", '');
									if( sessid == Env.sessionid ) {
										window.location.reload();
									}
								}
							}	
							Session.connect();
						}
					}
				);	
			</script>

			<jsp:invoke fragment="head"/>
			<c:if test="${! empty script}">
			<script>
				<jsp:invoke fragment="script"/>	
			</script>	
			</c:if>

			<c:if test="${! empty style}">
			<style>
				<jsp:invoke fragment="style"/>	
			</style>	
			</c:if>
		</head>
		
		<body>			
			<!-- header -->
			<div class="header">
				<table cellpadding="0" cellspacing="0" width="100%" height="100%" align="center">
					<tr>
						<td width="180">
							<a href="${pageContext.servletContext.contextPath}">
								<img src="${pageContext.servletContext.contextPath}/img/biglogo25.png">
							</a>
						</td>
						<td align="left">
							<jsp:invoke fragment="header_middle"/>
						</td>
						<td align="right" class="mainmenu">
							<a href="home.jsp#main">Home</a>
							<a href="home.jsp#connections">My Connections</a>
							<a href="profile.jsp">Profile</a>
							<a href="library.jsp">Library</a>
							<a href="#" id="useraccountmenu" r:context="session" r:name="showProfileMenu">
								Hi ${SESSION_INFO.username}&nbsp;&nbsp;&#9660;
							</a>
							<!-- useraccount menu panel -->
							<div id="usermenu" style="display:none">
								<ul>
									<li>
										<a href="profile.jsp">Edit Profile</a>
									</li>
									<li>
										<a href="logout.jsp">Logout</a>
									</li>
								</ul>
							</div>
						</td>
					</tr>
				</table>
			</div>

			<!-- feedback panel -->
			<script type="text/javascript">
				$put(
					'feedback',
					new function() {
						
						var self = this;
						var shown = false;
						this.entity = {};
						
						this.toggleFeedbackBox = function() {
							var fb = $('#feedback');
							var left = shown? -(fb.find('.box')[0].offsetWidth+3) : 0;
							fb.stop().animate({left: left});
							shown = !shown;
						};
						
						this.submit = function() {
							ProxyService.lookup("FeedbackService").send( this.entity );
							this.entity = {};
							$('#feedback .info').fadeIn().delay(1000).fadeOut('', function(){
								self.toggleFeedbackBox();
							});
						}
						
					}
				);
				
				//calculate feedback box position
				$(window).ready(function(){
					var fb = $('#feedback').show();//.css('opacity', 0).show();
					var box = fb.find('.box');
					fb.css({left: -(box[0].offsetWidth+3)})
					  //.animate({opacity: 1});
				});
			</script>
			<table id="feedback" style="display:none">
				<tr>
					<td>
						<div class="box">
							<div class="info" style="display:none">Feedback sucessfully posted.</div>
							<table cellspacing="0" height="100%" width="100%">
								<tr>
									<td height="10px">
										<em>*</em> <label for="comments">Leave a Feedback</label>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<textarea id="comments" 
										          r:context="feedback" 
												  r:name="entity.comment" 
												  r:required="true" 
												  r:caption="Feedback"
												  rows="6">
										</textarea>
									</td>
								</tr>
								<tr>
									<td align="right" height="10px">
										<button r:context="feedback" r:name="submit">Submit</button>
									</td>
								</tr>
							</table>
						</div>
					</td>
					<td>
						<a r:context="feedback" r:name="toggleFeedbackBox" r:immediate="true">
							<img src="${pageContext.servletContext.contextPath}/img/feedback.gif">
						</a>
					</td>
				</tr>
			</table>
		
			<!-- content area -->
			<div class="wrapper">
				<table class="main-container" width="100%" align="center" cellpadding="0" cellspacing="0" height="100%">
					<tr>
						<td height="100%">
							<jsp:doBody/>
						</td>
					</tr>
					<tr>
						<td class="footer" width="980" valign="top">
							<table width="100%" cellpadding="0" cellspacing="0" class="footer">
								<tr>
									<td width="165">&nbsp;</td>
									<td>
										About Terms Privacy								
									</td>
									</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			
			<jsp:invoke fragment="sections"/>
		</body>
	</html>	
</c:if>
