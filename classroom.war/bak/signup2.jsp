<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<c:if test="${!empty param['url']}">
	<s:invoke service="ClassService" method="getClassByUrl" params="${param['url']}" var="result"/>
</c:if>

<t:public redirect_session="false">
	
	<jsp:attribute name="head">
		<script type="text/javascript" src="js/ext/datetime.js"></script>
	</jsp:attribute>

	<jsp:attribute name="script">
		$put(
			"signup",
			
			new function() {
				this.status;
				var self = this;
				this._controller;
				this.confirmpassword;
				var svc = ProxyService.lookup("UserProfileService");
				this.genderList = ["M", "F"];
				this.entry = {};
				
				this.roles = [];
				
				this.submit = function() {
					if(this.roles.length==0)
						throw new Error("Please choose at least one role");
					this.entry.roles = this.roles.join("|");
					if( this.entry.password != this.confirmpassword ) {
						alert("Password must be the same as the confirm password. Please try again");
						return;	
					}
					svc.register(this.entry);
					WindowUtil.load("register_success.jsp");
				}
			}	
		);	
	</jsp:attribute>
	
	<jsp:body>
		<h1>Sign Up</h1>
		<table>
			<tr>
				<td colspan="2" style="padding-bottom:5px;">
					Complete the following information and click submit<br> 
				</td>
			</tr>
			<tr>
				<td width="100">User Name</td>
				<td><input type="text" r:context="signup" r:name="entry.username" r:caption="User name" r:required="true" /></td>
			</tr>
			<tr>
				<td width="100">First Name</td>
				<td><input type="text" r:context="signup" r:name="entry.firstname" r:caption="First name" r:required="true" /></td>
			</tr>
			<tr>
				<td>Last Name</td>
				<td><input type="text" r:context="signup" r:name="entry.lastname"  r:caption="Last name" r:required="true" /></td>
			</tr>
			<tr>
				<td>Gender</td>
				<td>
					<select r:context="signup" r:name="entry.gender" r:allowNull="true" r:items="genderList" r:required="true" r:caption="Gender">
					</select>
				</td>
			</tr>
			<tr>
				<td>Birthdate (yyyy-MM-dd)</td>
				<td>
					<span r:type="datetime" r:context="signup" r:name="entry.birthdate" r:caption="Birthdate" r:required="true" r:options="{mode:'date'}" />
				</td>
			</tr>
			<tr>
				<td valign="top">Select a Role (Check a least one)</td>
				<td valign="top">
					<input type="checkbox" r:context="signup" r:name="roles" r:mode="set" r:checkedValue="teacher"/>Teacher<br/>
					<input type="checkbox" r:context="signup" r:name="roles" r:mode="set" r:checkedValue="student"/>Student<br/>
					<input type="checkbox" r:context="signup" r:name="roles" r:mode="set" r:checkedValue="parent"/>Parent<br/>
				</td>
			</tr>
			
			<tr>
				<td>Password</td>
				<td><input type="password" r:context="signup" r:name="entry.password"  r:caption="Password" r:required="true" /></td>
			</tr>
			<tr>
				<td>Confirm Password</td>
				<td><input type="password" r:context="signup" r:name="confirmpassword"  r:caption="Confirm Password" r:required="true" /></td>
			</tr>
			<tr>
				<td>Primary email</td>
				<td><input type="text" r:context="signup" r:name="entry.email" r:caption="Email" r:required="true"/>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<input type="button" r:context="signup" value="Submit" r:name="submit" />
				</td>
			</tr>
		</table>
	</jsp:body>
	
</t:public>