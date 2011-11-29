<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<%@ attribute name="before_rendering" fragment="true" %>
<%@ attribute name="head" fragment="true" %>
<%@ attribute name="script" fragment="true" %>
<%@ attribute name="style" fragment="true" %>
<%@ attribute name="header_middle" fragment="true" %>

<c:if test="${empty SESSIONID}">
	<%
		String uri = request.getRequestURI();
		String qs = request.getQueryString();
		if( qs != null )
			uri = uri + "?" + qs;
		
		response.sendRedirect("authenticate.jsp?u=" + uri);
	%>
</c:if>

<c:if test="${!empty SESSIONID}">
	<s:invoke service="SessionService" method="getInfo" params="${SESSIONID}" var="SESSION_INFO"/>

	<jsp:invoke fragment="before_rendering"/>
	<!DOCTYPE html>
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
				Registry.add( {id:"#usermenu", context:"session"} );
				
				$put("session",
					new function() {

						this.logout = function() {
							try {
								var svc = ProxyService.lookup('LogoutService');
								svc.logout( Env.sessionid ); 
							}
							catch(e) {
								if( window.console ) console.log( e );
							}
						}
						this.showProfileMenu = function() {
							var popup = new DropdownOpener( '#usermenu' );
							popup.styleClass = 'usermenu';
							popup.options = {
								position: {my: 'right top', at: 'right bottom'},
								onClose : function() { select( false ); },
								onShow  : function() { select( true ); }
							};
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
						
						function select( value ) {
							if( value )
								$('#useraccountmenu').addClass('dropdown_open');
							else
								$('#useraccountmenu').removeClass('dropdown_open');
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

			<!--[if IE]>
			<style>
				html, body { height: 100%; overflow: hidden; }
				.header-wrapper { position: absolute; top: 0; left: 0; width: 100%; }
				.header { position: relative; margin-right: 17px; width: auto; text-align: center; }
				.wrapper { height: 100%; overflow: auto; text-align: left; position: relative; }
				
				#feedback { position: absolute; }
			</style>
			<![endif]-->
		</head>
		
		<body>
			<div class="wrapper ie-scroller">
				<table class="main-container" width="930px" align="center" cellpadding="0" cellspacing="0" height="100%">
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
			<div class="header-wrapper">
				<div class="header">
					<table cellpadding="0" cellspacing="0" width="930px" height="100%" align="center">
						<tr>
							<td width="165">
								<a href="${pageContext.servletContext.contextPath}">
									<img src="${pageContext.servletContext.contextPath}/img/biglogo25.png">
								</a>
							</td>
							<td align="left">
								<jsp:invoke fragment="header_middle"/>
							</td>
							<td align="right" class="mainmenu">
								<a href="home.jsp">Home</a>
								<a href="profile.jsp">Profile</a>
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
											<a r:context="session" r:name="logout">Logout</a>
										</li>
									</ul>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- feedback panel 
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
							this.entity = {};
							$('#feedback .info').fadeIn().delay(1000).fadeOut('', function(){
								self.toggleFeedbackBox();
							});
						}
						
					}
				);
				
				//calculate feedback box position
				$(function(){
					var fb = $('#feedback').css('opacity', 0).show();
					var box = fb.find('.box');
					fb.css({left: -(box[0].offsetWidth+3)})
					  .animate({opacity: 1});
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
												  r:name="entity.comments" 
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
			-->
		</body>
	</html>	
</c:if>
