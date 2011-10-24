<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%
	request.setAttribute( "id", java.net.URLDecoder.decode(request.getParameter("id")));
%>
<s:invoke service="StudentRegistrationService" method="activate" params="${id}" var="result"/>

<t:public redirect_session="false">
	<c:if test="${error.message == 'reg-not-found'}">
		<h2 class="error">Error</h2>
		<p>
		We cannot find your registration. 
		Maybe you are already registered or this registration has expired. 
		We do clean up unactivated registrations from time to time.
		Kindly try registering again and activate it immediately. 
		If this problem occurs again, please send us an email. Thanks	
		</p>
	</c:if>
	
	<c:if test="${empty error}">
		<script>
			$put( "login-activate",
				new function() {
					var svc = ProxyService.lookup("LoginRegistrationService");
					this.login = function() {	
						var id = svc.login( {objid: '${result.objid}'} );
						if(id.sessionid != null) {
							var date = new Date();
							date.setTime(date.getTime() + (60 * 1000 * 5));
							$.cookie("sessionid",id.sessionid, { expires: date })
							window.location = "home.jsp";
						}
					}
				}
			) 
		</script>
		<h2>Congratulations! ${result.firstname}. </h2>
		
		<p>
		You have successfully signed up to Gazeebu.<br><br>
		To start, click 
		<input type="button" r:context="login-activate" r:name="login" value="Continue"/>
		</p>
	</c:if>

	
		
</t:public>