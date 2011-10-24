<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<t:public redirect_session="false">
	<script>
		$put(
			"teacher_register",
			new function() {
				this.status;
				var self = this;
				this._controller;
				this.confirmpassword;
				this.genderList = ["M", "F"];
				this.entry = {};
				this.verified = "false";

				var svc = ProxyService.lookup("TeacherRegistrationService");
				
				this.verify = function() {
					try {
						this.status = svc.checkEmail( {email:this.entry.email} );
						if(this.status.ok) {
							this._controller.focus('entry.firstname');
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
				
				this.submit = function() {
					if( this.entry.password != this.confirmpassword ) {
						alert("Password must be the same as the confirm password. Please try again");
						return;	
					}
					svc.register( this.entry );
					WindowUtil.load("thankyou.jsp");
				}
				
				this.retry = function() {
					this.status.ok = null;
					this.verified = "false";
				}
			}	
		);	
	</script>
			
	<div r:context="teacher_register" r:visibleWhen="#{verified == 'false'}">	
		<table>
			<tr>
				<td colspan="3">
					<h2>Sign up for Teachers Only</h2>
					Please enter your valid email below. 
				</td>
			</tr>
			<tr>
				<td width="100">Email</td>
				<td>
					<input type="text" r:context="teacher_register" r:name="entry.email" r:caption="Email" r:required="true" style="width:250px;"/>
					<input type="button" r:context="teacher_register" r:name="verify" value="Verify" r:visibleWhen="#{!status.ok}"/>	
				</td>
				<td>
					<label r:context="teacher_register" r:depends="entry.email" r:visibleWhen="#{status.error}" class="error"> 
						#{status.error}
					</label>
				</td>
			</tr>
		</table>	 
	</div>
			
	<div r:context="teacher_register" r:depends="entry.email" r:visibleWhen="#{status.ok}">
		<table>
			<tr>
				<td colspan="2" style="padding-bottom:5px;">
					Complete the following information and click submit. To change email click <a r:context="teacher_register" r:name="retry" r:immediate="true">here</a><br><br> 
				</td>
			</tr>
			<tr>
				<td>Your email</td>
				<td><label r:context="teacher_register"><b>#{entry.email}</b></label></td>
			</tr>
			<tr>
				<td width="100">First Name</td>
				<td><input type="text" r:context="teacher_register" r:name="entry.firstname" r:caption="First name" r:required="true" /></td>
			</tr>
			<tr>
				<td>Last Name</td>
				<td><input type="text" r:context="teacher_register" r:name="entry.lastname"  r:caption="Last name" r:required="true" /></td>
			</tr>
			<tr>
				<td>Gender</td>
				<td>
					<select r:context="teacher_register" r:name="entry.gender" r:allowNull="true" r:items="genderList" r:required="true" r:caption="Gender">
					</select>
				</td>
			</tr>
			<tr>
				<td>Birthdate (yyyy-MM-dd)</td>
				<td><input type="text" r:context="teacher_register" r:name="entry.birthdate" r:caption="Birthdate" r:required="true" /></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" r:context="teacher_register" r:name="entry.password"  r:caption="Password" r:required="true" /></td>
			</tr>
			<tr>
				<td>Confirm Password</td>
				<td><input type="password" r:context="teacher_register" r:name="confirmpassword"  r:caption="Confirm Password" r:required="true" /></td>
			</tr>
			<tr>
				<td colspan="2" style="padding-top:50px;">
					<b>Note:</b>Please tell us a little about yourself, what school you are working for and how you learned about this service.
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea style="width:100%;height:50;" type="text" r:context="teacher_register" r:name="entry.note" r:caption="Note" r:required="true"></textarea>
				</textarea>
			</tr>
			
			<tr>
				<td>&nbsp;</td>
				<td>
					<input type="button" r:context="teacher_register" value="Submit" r:name="submit" />
				</td>
			</tr>
		</table>
	</div>
		
</t:public>