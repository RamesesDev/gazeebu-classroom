<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ tag import="java.util.regex.*" %>

<%@ attribute name="redirect_session" fragment="false" %>
<%@ attribute name="tab" fragment="false" %>
<%@ attribute name="script" fragment="true"%>
<%@ attribute name="style" fragment="true"%>
<%@ attribute name="pageTitle" fragment="false"%>

<%

String userAgent = request.getHeader("user-agent");
if( userAgent.contains("MSIE") ) {
	String exp = "MSIE(.*?);";
	Pattern p = Pattern.compile(exp);
	Matcher m = p.matcher(userAgent);
	if( m.find() ) {
		int v = Integer.parseInt(m.group(1).replaceAll("^\\s+|\\..*", ""));
		if( v <= 6 ) {
			response.sendRedirect("not-supported.jsp");
		}
	}
}

%>

<c:if test="${!empty SESSIONID and redirect_session=='true'}">
	<%response.sendRedirect("home.jsp");%>
</c:if>

<c:if test="${(empty SESSIONID) || (empty redirect_session) || (redirect_session=='false')}">
	<!DOCTYPE html>
	<html>
		<head>
			<title>Gazeebu Classroom<c:if test="${not empty pageTitle}"> - ${pageTitle}</c:if></title>
			<meta charset="UTF-8" >
			<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/js/lib/css/jquery-ui/jquery.css" type="text/css"/>
			<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/js/lib/css/rameses-lib.css" type="text/css" />
			<script src="${pageContext.servletContext.contextPath}/js/lib/jquery-all.js"></script>
			
			<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-ext-lib.js"></script>
			<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-ui.js"></script>
			<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-proxy.js"></script>
			<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-session.js"></script>

			
			<link href="${pageContext.servletContext.contextPath}/css/index.css" type="text/css" rel="stylesheet"/>	
			
			
			<script>
				$put("login",
					new function() {
						this.username = '${param['u']}';
						this.password;
						this.onload = function() {
							<c:if test="${redirect_session=='true'}">
								if($.cookie('sessionid')) {
									window.location.reload();
								}
							</c:if>
						}
					}
				);
				
				//focus login text
				$(function(){
					$('#uid').focus();
				});
			</script>
			
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
			<table width="100%" height="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td class="head" valign="top">&nbsp;</td>
					<td class="head" width="850" height="55" align="right" valign="top">
						<table width="100%" height="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td id="topmenu" align="left" valign="top">
									<a href="/classroom">
										<img src="img/biglogo.png" style="border:none;">	
									</a>
								</td>
								<td id="topmenu" align="right" valign="top">

									<c:if test="${empty SESSIONID}">
										<form class="login" action="login.jsp" method="post">
											<table cellspacing="0" cellpadding="1" class="loginform">
												<tr>
													<td valign="top">
														<input id="uid" type="text" r:name="username" name="username" r:hint="User Name" class="logininput" r:context="login"/>
													</td>	
													<td valign="top">
														<input id="pwd" type="password" r:name="password" name="password"  r:hint="Password" class="logininput"  r:context="login"/>
													</td>
													<td valign="top" style="padding-top:3px;">
														<button type="submit">
															Login
														</button>
													</td>
												</tr>
												<tr>
													<td align="left">
														<a href="signup.jsp">New User? Sign Up</a>
													</td>
													
													<td align="left"><a href="resetpass.jsp">Forgot Password?</a></td>
													<td valign="top">&nbsp;</td>
												</tr>
											</table>
										</form>
									</c:if>

								</td>
							</tr>
						</table>
					</td>
					<td class="head">&nbsp;</td>		
				</tr>
				
				<tr>
					<td class="head">&nbsp;</td>
					<td class="head">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td class="${ (empty tab || tab=='home') ? 'tabmenu-selected' : 'tabmenu'}" style="padding-left:25px;padding-right:25px">
									<a href="index.jsp">Home</a>
								</td>
								<td class="tabmenu-space">&nbsp;</td>
								<td class="${tab=='community' ? 'tabmenu-selected' : 'tabmenu'}">
									<a href="community.jsp">Community</a>
								</td>
								<td class="tabmenu-space">&nbsp;</td>
								<td class="${tab=='developer' ? 'tabmenu-selected' : 'tabmenu'}">
									<a href="developer.jsp">Developer</a>
								</td>
							</tr>
						</table>
					</td>
					<td class="head">&nbsp;</td>
				</tr>
				
				<tr>
					<td class="middle">&nbsp;</td>
					<td class="middle" height="320" valign="top"  style="padding-top: 20px;">
						<jsp:doBody/>
					</td>
					<td class="middle">&nbsp;</td>		
				</tr>
				
				<tr>
					<td class="foot" id="footdeco" colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td class="foot">&nbsp;</td>
					<td class="foot" height="100%">
						<p id="footmenu">
							About &nbsp;&nbsp;
							Privacy &nbsp;&nbsp;
							Terms
						</p>
					</td>
					<td class="foot">&nbsp;</td>				
				</tr>
			</table>
		</body>	
	</html>
</c:if>