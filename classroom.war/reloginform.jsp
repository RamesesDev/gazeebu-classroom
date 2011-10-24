<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:public redirect_session="false">
	<h2 style="color:red;">Error Login.</h2>
	<p>Your email or password is incorrect. Please re-enter and submit</p>
	
	<form action="login.jsp" method="post">
		<table cellspacing="0" cellpadding="1" class="loginform">
			<tr>
				<td>Email: </td>
				<td>
					<input id="uid" type="text" name="username" hint="Email" />
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
	</form>
	<script type="text/javascript">
		$('#uid').focus();
	</script>
</t:public>