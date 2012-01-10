<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:public redirect_session="false">
	<div style="color:red;">
		<h2>Error Login.</h2>
		<p>Your username or password is incorrect.</p>
	</div>
	
	<form action="login.jsp" method="post">
		<table cellspacing="0" cellpadding="1" class="loginform">
			<tr>
				<td>Username: </td>
				<td>
					<input id="uid" type="text" name="username" value="${param['username']}"/>
				</td>	
			</tr>
			<tr>
				<td>Password: </td>
				<td>
					<input id="pwd" type="password" name="password"/>
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
		$("#${empty param['username']? 'uid' : 'pwd'}").focus();
	</script>
</t:public>