<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<%@ attribute name="before_rendering" fragment="true" %>
<%@ attribute name="head" fragment="true" %>
<%@ attribute name="header_middle" fragment="true" %>

<c:if test="${empty SESSIONID}">
	<%response.sendRedirect("authenticate.jsp");%>
</c:if>

<c:if test="${!empty SESSIONID}">
	<s:invoke service="SessionService" method="getInfo" params="${SESSIONID}" var="SESSION_INFO"/>

	<jsp:invoke fragment="before_rendering"/>
	<html>
		<head>
			<link href="${pageContext.servletContext.contextPath}/js/lib/css/jquery-ui/jquery.css" type="text/css" rel="stylesheet" />
			<link href="${pageContext.servletContext.contextPath}/js/lib/css/rameses-lib.css" type="text/css" rel="stylesheet" />
			<script src="${pageContext.servletContext.contextPath}/js/lib/jquery-all.js"></script>
			<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-ext-lib.js"></script>
			<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-ui.js"></script>
			<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-proxy.js"></script>
			<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-session.js"></script>
			<link href="${pageContext.servletContext.contextPath}/css/secured.css" type="text/css" rel="stylesheet" />
			
			<script>
				Env.sessionid = $.cookie("sessionid");
				var Session = new Notifier( Env.sessionid );
				$register( {id:"usermenu", page:"useraccount_menu.jsp", context:"session"} );
				$put("session",
					new function() {
						this.logout = function() {
							var svc = ProxyService.lookup('LogoutService');
							svc.logout( Env.sessionid ); 
						}
						this.showProfileMenu = function() {
							var popup = new DropdownOpener( 'usermenu' );
							popup.options.position = {my: 'right top', at: 'right bottom'};
							return popup;
						}
						this.onload = function() {
							Session.connectionListener.ended = function(o) {
								$.cookie( "sessionid", null );
								if( o == "_:ended" ) {
									window.location = "logout.jsp";
								}
								else {
									window.location.reload(true);
								}	
							}	
							Session.connect();
						}
					}
				);	
			</script>

			<jsp:invoke fragment="head"/>
			
			<!--[if IE]>
			
			<style>
				html, body { height: 100%; overflow: hidden; }
				.header-wrapper { position: absolute; top: 0; left: 0; width: 100%; }
				.header { position: relative; margin-right: 17px; width: auto; text-align: center; }
				.header table { margin: 0px auto; }
				.wrapper { height: 100%; overflow: auto; text-align: left; }
			</style>
			<![endif]-->
		</head>
		
		<body>
			<div class="header-wrapper">
				<div class="header">
					<table cellpadding="0" cellspacing="0" width="930px" align="center">
						<tr>
							<td width="165">
								<img src="${pageContext.servletContext.contextPath}/img/biglogo.png" height="30px">
							</td>
							<td align="left">
								<jsp:invoke fragment="header_middle"/>
							</td>
							<td align="right" class="mainmenu">
								<a href="home.jsp">Home</a>&nbsp;&nbsp;
								<a href="profile.jsp">Profile</a>&nbsp;&nbsp;  
								<a r:context="session" r:name="logout">Sign out</a>&nbsp;&nbsp;
								<!--
								<a href="#" id="useraccountmenu" r:context="session" r:name="showProfileMenu">
									Hi ${SESSION_INFO.username}&nbsp;&nbsp;&#9660;
								</a>
								-->
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="wrapper">
				<table class="main-container" width="930px" align="center" cellpadding="0" cellspacing="0" height="100%">
					<tr>
						<td height="100%" style="padding-top:10px;">
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
		</body>
	</html>	
</c:if>
