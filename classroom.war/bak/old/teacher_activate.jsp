<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="server" %>

<server:invoke service="TeacherActivationService" method="activate" params="${param['id']}" var="result"/>

<t:public redirect_session="false">
	<style>
		p {
			font-size:12px; 
			font-family:arial; 
		}
		h2 { 
			color:darkslateblue;
			font-family:tahoma;
			font-size:15px;
		}
		i{
			font-size: 12px;
		}
		.error{
			color:red;
			font-weight: bold;
		}
	</style>
	
	<c:if test="${empty result.error}">
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
		<input type="button" context="login-activate" name="login" value="Continue"/>
		</p>
	</c:if>

	<c:if test="${result.error == 'reg-not-found'}">
		<h2 class="error">Error</h2>
		<p>
		We cannot find your registration. 
		Maybe you are already registered or this registration has expired. 
		We do clean up unactivated registrations from time to time.
		Kindly try registering again and activate it immediately. 
		If this problem occurs again, please send us an email. Thanks	
		</p>
	</c:if>
		
</t:public>