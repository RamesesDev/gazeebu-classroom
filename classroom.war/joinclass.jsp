<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<s:invoke service="ClassService" method="getClassByUrl" params="${param['url']}" var="result"/>
<t:public redirect_session="false">

		<c:if test="${!empty error}">
			<h2>An Error occured</h2>
			<p class="error">${error.message}</p>
		</c:if>
		
		<c:if test="${!empty result}">
			<script>
				$put(
					"student_register",
					new function() {
						this.status;
						var self = this;
						this._controller;
						this.confirmpassword;
						
						var svc = ProxyService.lookup("StudentRegistrationService");
						
						this.verify = function() {
							try {
								this.status = svc.checkEmail( {classid:"${result.objid}", email:this.entry.email} );
								
								if(this.status.ok) {
									this._controller.focus('entry.firstname');
									this.verified = "true";
								}
								else if(this.status.info) {
									this.verified = "true";
								}
								else {
									this._controller.focus('entry.email');
								}
								
							}
							catch(e) {
								this.status = {error:"Error " + e.message};
							}	
						}
						
						this.genderList = ["M", "F"];
						
						this.entry = {classid: "${result.objid}" };
						this.submit = function() {
							if(this.status.info) {
								var c = {studentid: this.status.info.objid, classid: this.entry.classid};
								svc.registerClass(c);
							}
							else {
								if( this.entry.password != this.confirmpassword ) {
									alert("Password must be the same as the confirm password. Please try again");
									return;	
								}
								svc.register( this.entry );
								
							}	
							WindowUtil.load("thankyou.jsp");
						}
						
						this.verified = "false";
						
						this.retry = function() {
							this.status.info = null;
							this.status.ok = null;
							this.verified = "false";
						}
					}	
				);	
				</script>
	
			<h2>${result.teacher.firstname} ${result.teacher.lastname} has invited you to join class ${result.name}</h2>
			
			<div r:context="student_register" r:visibleWhen="#{verified == 'false'}">	
				<table>
					<tr>
						<td colspan="3">
							Please enter your email:
						</td>
					</tr>
					<tr>
						<td width="100">Email</td>
						<td>
							<input type="text" r:context="student_register" r:name="entry.email" r:caption="Email" r:required="true" style="width:250px;"/>
							<input type="button" r:context="student_register" r:name="verify" value="Verify" r:visibleWhen="#{!status.ok}"/>	
						</td>
						<td>
							<label r:context="student_register" r:depends="entry.email" r:visibleWhen="#{status.error}" class="error"> 
								#{status.error}
							</label>
							<label r:context="student_register" r:depends="entry.email" r:visibleWhen="#{status.ok}"> 
								Email is OK!
							</label>
						</td>
					</tr>
				</table>	 
			</div>
			
			<div r:context="student_register" r:depends="entry.email" r:visibleWhen="#{status.ok}">
				<table>
					<tr>
						<td colspan="2" style="padding-bottom:5px;">
							Complete the following information and click submit. To change email click <a r:context="student_register" r:name="retry" r:immediate="true">here</a><br><br> 
						</td>
					</tr>
					<tr>
						<td>Your email</td>
						<td><label r:context="student_register"><b>#{entry.email}</b></label></td>
					</tr>
					<tr>
						<td width="100">First Name</td>
						<td><input type="text" r:context="student_register" r:name="entry.firstname" r:caption="First name" r:required="true" /></td>
					</tr>
					<tr>
						<td>Last Name</td>
						<td><input type="text" r:context="student_register" r:name="entry.lastname"  r:caption="Last name" r:required="true" /></td>
					</tr>
					<tr>
						<td>Gender</td>
						<td>
							<select r:context="student_register" r:name="entry.gender" r:allowNull="true" r:items="genderList" r:required="true" r:caption="Gender">
							</select>
						</td>
					</tr>
					<tr>
						<td>Birthdate (yyyy-MM-dd)</td>
						<td><input type="text" r:context="student_register" r:name="entry.birthdate" r:caption="Birthdate" r:required="true" /></td>
					</tr>
					<tr>
						<td>Password</td>
						<td><input type="password" r:context="student_register" r:name="entry.password"  r:caption="Password" r:required="true" /></td>
					</tr>
					<tr>
						<td>Confirm Password</td>
						<td><input type="password" r:context="student_register" r:name="confirmpassword"  r:caption="Confirm Password" r:required="true" /></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>
							<input type="button" r:context="student_register" value="Submit" r:name="submit" />
						</td>
					</tr>
				</table>
			</div>
			
			<div r:context="student_register" r:depends="entry.email" r:visibleWhen="#{status.info}">
				<br>
				<label r:context="student_register">
				Is the information below correct? Please verify and click on submit. 
				If not click <a r:context="student_register" r:name="retry">here</a> to try again.<br><br>
				Your email: <b>#{status.info.email}</b><br>
				Your name : <b>#{status.info.lastname}, #{status.info.firstname}</b>
				</label>
				<br><br>	
				<input type="button" r:context="student_register" value="Submit" r:name="submit" />
			</div>	
			
		</c:if>
		
</t:public>