<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:public redirect_session="false">
	
	<h2 style="color:red;">Your session has expired.</h2>
	<p>Please specify your username and password</p>
	
	<form action="login.jsp" method="post">
		<table cellspacing="0" cellpadding="1" class="loginform">
			<tr>
				<td>Username: </td>
				<td>
					<input id="uid" type="text" name="username" hint="Username" />
				</td>	
			</tr>
			<tr>
				<td>Password: </td>
				<td>
					<input id="pwd" type="password" name="password" hint="Password" />
				</td>	
			<tr>
				<td>&nbsp;</td>
				<td valign="top">
					<button type="submit">
						Login
					</button>
				</td>
			</tr>
		</table>
		<c:if test="${! empty param['u']}">
			<input type="hidden" name="u" value="${param['u']}"/>
		</c:if>
	</form>
	<script type="text/javascript">
		$(function(){ $('#uid').focus(); });
	</script>
	
</t:public>

