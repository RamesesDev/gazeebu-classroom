<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:public redirect_session="false">
    <jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/css/signup.css" rel="stylesheet"/>
        <script src="${pageContext.servletContext.contextPath}/js/ext/datetime.js"></script> 
		<script>
			$put(
				"signup",				
				new function() 
				{
					this.status;
					var self = this;
					this._controller;
					this.confirmpassword;
					
					var svc = ProxyService.lookup("UserProfileService");
					var user_isavailable;

					this.entity = {
						firstname: "${param['firstname']}",
						middlename: "${param['middlename']}",
						lastname: "${param['lastname']}"
					};
					
					this.roles = [];
					
					this.signup = function() {
						if(this.roles.length==0)
							throw new Error("Please choose at least one role");

						this.entity.roles = this.roles.join("|");
						
						if( !user_isavailable ) {
							alert('Username is not available.');
							return;
						}
						
						if( this.entity.password != this.confirmpassword ) {
							alert("Password must be the same as the confirm password.\nPlease try again");
							return;	
						}
						svc.register(this.entity);
						login(this.entity);
					};
					
					this.propertyChangeListener = {
						"confirmpassword" : function(o) { 
							if(o != self.entity.password) {
								$('#password-err').show();
							}
							else {
								$('#password-err').hide();
							}
						},
							
						"entity.username" : function(o) {
							user_isavailable = svc.verifyUsername(o);							
							$('#username-a').hide();
							$('#username-na').hide();
							if(user_isavailable) {
								$('#username-a').show();
							}								
							else {
								$('#username-na').show();
							}
						}
					}
				}
			);
			
			function login(entity) {
				$('<form method="post" action="login.jsp"></form>')
				 .hide().appendTo('body')
				 .append($('<input type="text" name="username"/>').val(entity.username))
				 .append($('<input type="password" name="password"/>').val(entity.password))
				 .submit();
			};

			
			$(function(){
				$('#fname').focus();
			});
        </script>
    </jsp:attribute>

    <jsp:body>
        <h1>Get started with Gazeebu</h1>
        <table class="signup-form page-form-table" cellpadding="2" cellspacing="2" border="0">
            <tr>
                <td width="150" class="left caption text-top">First Name: </td>
                <td>
                    <input type="text" class="text" size="40" id="fname"
                           r:context="signup" 
                           r:name="entity.firstname" 
                           r:required="true"
                           r:caption="First name"/>
					<em>*</em> 
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Last Name:</td>
                <td>
                    <input type="text" class="text" size="40"
                           r:context="signup" 
                           r:name="entity.lastname" 
                           r:required="true"
                           r:caption="Last name"/>
					 <em>*</em>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Middle Name: </td>
                <td>
                    <input type="text" class="text" size="40"
                           r:context="signup" 
                           r:name="entity.middlename" 
                           r:caption="Middle name"/>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Desired Login Name: </td>
                <td>
                    <input type="text" class="text" size="40"
                           r:context="signup" 
                           r:name="entity.username"
                           r:required="true"
                           r:caption="Desired login name"/>
					 <em>*</em>
                    <b id="username-a" style="color:green;display:none;">
                        Available
                    </b>
                    <b id="username-na" style="color:red;display:none;">
                        Not Available
                    </b>
                    <br/>
                    <span style="color:#6b6d6b;">Examples: JohnDoe, John.Doe</span>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Your Email: </td>
                <td>
                    <input type="text" class="text" size="40"
                           r:context="signup" 
                           r:name="entity.email"
						   r:required="true"
                           r:caption="Your Email"/>
					<em>*</em>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Role: </td>
                <td>
					<label>
						<input type="checkbox" r:context="signup" r:name="roles" r:mode="set" r:checkedValue="teacher"/>
						Teacher
					</label>
					<br/>
					<label>
						<input type="checkbox" r:context="signup" r:name="roles" r:mode="set" r:checkedValue="student"/>
						Student
					</label>
					<br/>
					<label>
						<input type="checkbox" r:context="signup" r:name="roles" r:mode="set" r:checkedValue="parent"/>
						Parent
					</label>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Password: </td>
                <td>
                    <input type="password" class="text" size="40"
                           r:context="signup" 
                           r:name="entity.password"
                           r:required="true"
                           r:caption="Password"/>
					<em>*</em>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Re-enter Password: </td>
                <td>
                    <input type="password" class="text" size="40"
                           r:context="signup"
						   r:required="true"
						   r:caption="Confirm password"
                           r:name="confirmpassword"/>
					<em>*</em>
					<b id="password-err" style="color:red;display:none;">Not matched.</b>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Birthday: </td>
                <td>
                    <span r:context="signup" 
                          r:type="datetime" 
                          r:name="entity.birthdate"
                          r:options="{mode:'date'}">
                    </span><br/>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Gender: </td>
                <td>
                    <select class="text" 
                            r:context="signup" 
                            r:name="entity.gender" 
                            r:caption="Gender">
						<option> - </option>
						<option value="M">Male</option>
						<option value="F">Female</option>
					</select>
                </td>
            </tr>
			<!--
            <tr>
                <td class="left caption text-top">Terms of Service: </td>
                <td>
                    <textarea cols="100" rows="12" readonly="readonly">
Gazeebu Terms of Service

Welcome to Gazeebu!

1. Your relationship with Gazeebu

    1.1 Lorem ipsum dolor sit amet, athenagora ut casus. Ac esse in lucem genero coruscus eum ego esse deprecor cum obiectum invidunt. Plenus redire se in modo cavendum es.

2. Accepting the Terms

    2.1 Lorem ipsum dolor sit amet, lavabat carissime ac ea rege publicum video cum unde meae ad quia ad suis. Lycoridem in lucem in fuerat construeret in rei civibus. Mirantur deo apprehendit in rei civibus in rei completo litus ostendam Apollonio omnino inventa fuit quodam domina tu.

3. Language of the Terms

    3.1 Lorem ipsum dolor sit amet, redde pariter commendare Apollonius non dum veniens indica enim. Me missam canticis in fuerat se sed quod tamen adnuente rediens eam ad nomine Piscatore mihi servitute meam. Patrem alicui proditoris propagata pios aestimativa naturam materiam profusis magna duobus consolabor potest ei sed esse ait.
					</textarea>
                </td>
            </tr>
			-->
            <tr>
                <td class="left caption text-top"></td>
                <td>
					<span class="btn">
						<button type="submit" r:context="signup" 
								r:name="signup">
							I accept. Create my Account
						</button>
					</span>
                </td>
            </tr>
        </table>
		<br/>
		<br/>
    </jsp:body>
</t:public>
