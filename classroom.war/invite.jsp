<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%
	request.setAttribute( "id", java.net.URLDecoder.decode(request.getParameter("id")));
%>
<s:invoke service="TeacherInviteService" method="getInvitation" params="${id}" var="result"/>
<t:public redirect_session="false">

		<c:if test="${!empty error}">
			<h2>An Error occured</h2>
			<p class="error">${error.message}</p>
		</c:if>

		<c:if test="${empty error}">
			<script>
				$put(
					"teacherinfo",
					new function() {
						this.status;
						var self = this;
						this._controller;
						var svc = ProxyService.lookup("TeacherInviteService");
						
						this.genderList = ["M", "F"];
						
						this.entry = {email: "${result.email}", regid: "${result.objid}"};
						this.submit = function() {
							svc.save( this.entry );
							WindowUtil.load("thankyou.jsp");
						}
						
					}	
				);	
				</script>
	
			<h2>${result.message}</h2>
			Please fill in the information below and click on submit when finished.<br><br>
			<br>	
			
			<table>
				<tr>
					<td width="250">Your Email (Please confirm)</td>
					<td><b>${result.email}</b></td>
				</tr>
			
				<tr>
					<td>First Name</td>
					<td><input type="text" context="teacherinfo" name="entry.firstname" caption="First name" required="true" /></td>
				</tr>
				<tr>
					<td>Last Name</td>
					<td><input type="text" context="teacherinfo" name="entry.lastname"  caption="Last name" required="true" /></td>
				</tr>
				<tr>
					<td>Gender</td>
					<td>
						<select context="teacherinfo" name="entry.gender" allowNull="true" items="genderList" required="true" caption="Gender">
						</select>
					</td>
				</tr>
				<tr>
					<td>Birthdate</td>
					<td><input type="text" datatype="date" context="teacherinfo" name="entry.birthdate" caption="Birthdate" required="true" /></td>
				</tr>
				<tr>
					<td>Password</td>
					<td><input type="password" context="teacherinfo" name="entry.password"  caption="Password" required="true" /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<input type="button" context="teacherinfo" value="Submit" name="submit" />
					</td>
				</tr>
			</table>
		</c:if>	
		
</t:public>