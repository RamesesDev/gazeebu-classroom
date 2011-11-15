<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:public redirect_session="false">
    <jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/css/signup.css" rel="stylesheet"/>
        <script src="${pageContext.servletContext.contextPath}/js/ext/datetime.js"></script> 
		<script>
            $put(
				"createaccount", 
				new function() {
					var upssvc = ProxyService.lookup("UserProfileService");
					var loginsvc = ProxyService.lookup("LoginService");
					this.account = {
						firstname: "${param['firstname']}",
						middlename: "${param['middlename']}",
						lastname: "${param['lastname']}"
					};
					this.info = {};
					var self = this;
				
					this.passwordsecurity;
					this.username;
					this._controller;
					/*
						0 - available
						1 - not available
						2 - initial, not decided yet
					 */
					this.isusernameavailable = 2;
				
					this.questions = [
						"What is the name of your bestfriend from childhood?",
						"What was the name of your first teacher?"
					];
				
					this.locations = [
						"-",
						"Philippines",
						"Pitcairn",
						"Poland"
					];
				
					this.isteacher = false;
					this.isstudent = false;
					this.isparent = false;
				
					this.gender = [
						"-",
						"Male",
						"Female"
					];
				
					this.propertyChangeListener = {
						"passwordsecurity" : function(o) { 
							if(o != self.account.password)
								alert("The passwords you enter does not match.");
						},
							
						"username" : function(o) {
							self.account.username = self.username;
							   
							this.checkavailability = loginsvc.checkAvailability(self.username);
							   
							if(this.checkavailability)
								self.isusernameavailable = 1;
							else
								self.isusernameavailable = 0;
							  
							self._controller.refresh();
						}
					}
				
					this.createaccount = function() {
						if(this.account.password != this.passwordsecurity) {
							alert("The passwords you enter does not match.");
							return;
						}
				   
						if(this.isusernameavailable == 1) {
							alert("Username is already taken.");
							return;
						}
				   
						this.account.roles = "";
						if(this.isteacher)
							this.account.roles =  "teacher";
						if(this.isstudent) {
							if(this.account.roles != "")
								this.account.roles = this.account.roles + "|student";
							else
								this.account.roles = "student";
						}
						if(this.isparent) {
							if(this.account.roles != "")
								this.account.roles = this.account.roles + "|parent";
							else
								this.account.roles = "parent";
						}
				   
						if(this.account.roles == "") {
							alert("Please specify a role.");
							return;
						}
				   
						this.account.info = this.info;
				   
						upssvc.register(this.account);
					}
				
				}
	   
			);
			
			$(function(){
				$('#fname').focus();
			});
        </script>
    </jsp:attribute>

    <jsp:body>
        <h1>Get started with Gazeebu</h1>
        <table class="page-form-table" cellpadding="2" cellspacing="2" border="0">
            <tr>
                <td width="150" class="left caption text-top">First Name: </td>
                <td>
                    <input type="text" class="text" size="40" id="fname"
                           r:context="createaccount" 
                           r:name="account.firstname" 
                           r:required="true"
                           r:caption="First Name"/>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Middle Name: </td>
                <td>
                    <input type="text" class="text" size="40"
                           r:context="createaccount" 
                           r:name="account.middlename" 
                           r:required="true"
                           r:caption="Middle Name"/>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Last Name: </td>
                <td>
                    <input type="text" class="text" size="40"
                           r:context="createaccount" 
                           r:name="account.lastname" 
                           r:required="true"
                           r:caption="Last Name"/>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Desired Login Name: </td>
                <td>
                    <input type="text" class="text" size="40"
                           r:context="createaccount" 
                           r:name="username"
                           r:required="true"
                           r:caption="Desired Login Name"/>
                    <label r:context="createaccount"
                           r:depends="isusernameavailable"
                           r:visibleWhen="#{isusernameavailable == 0}"
                           style="font-weight:bold;color:green;">
                        Available
                    </label>
                    <label r:context="createaccount"
                           r:depends="isusernameavailable"
                           r:visibleWhen="#{isusernameavailable == 1}"
                           style="font-weight:bold;color:red;">
                        Not Available
                    </label>
                    <br/>
                    <span style="color:#6b6d6b;">Examples: JohnDoe, John.Doe</span>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Role: </td>
                <td>
                    <input type="checkbox" 
                           r:context="createaccount" 
                           r:name="isteacher"/>Teacher<br>
                    <input type="checkbox" 
                           r:context="createaccount" 
                           r:name="isstudent"/>Student<br>
                    <input type="checkbox" 
                           r:context="createaccount" 
                           r:name="isparent"/>Parent<br>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Password: </td>
                <td>
                    <input type="password" class="text" size="40"
                           r:context="createaccount" 
                           r:name="account.password"
                           r:required="true"
                           r:caption="Password"/><br/>
                    <span style="color:#6b6d6b;">Minimum of 8 characters in length.</span><br/>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Re-enter Password: </td>
                <td>
                    <input type="password" class="text" size="40"
                           r:context="createaccount" 
                           r:name="passwordsecurity"/><br/>
					<!--
                    <input type="checkbox" 
                           r:context="createaccount" 
                           r:name="info.staysignedin" 
                           r:checkedValue="1" 
                           r:uncheckedValue="0"/>Stay signed in.<br>
                    <input type="checkbox" 
                           r:context="createaccount" 
                           r:name="info.enablewebhistory" 
                           r:checkedValue="1" 
                           r:uncheckedValue="0"/>Enable Web History.<br>
					-->
                </td>
            </tr>
			<!--
            <tr>
                <td class="left caption text-top">Security Quesion: </td>
                <td>
                    <select class="text" 
                            r:context="createaccount" 
                            r:name="info.question" 
                            r:caption="Security Question" 
                            r:items="questions" 
                            r:required="false"/></select><br/>
                    <span style="color:#6b6d6b;">If you forget your password we will ask for the answer to your security question.</span><br/>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Answer: </td>
                <td>
                    <input type="text" class="text" size="40"
                           r:context="createaccount" 
                           r:name="info.answersecurity" 
                           r:required="false"
                           r:caption="Answer to Security Question"/>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Your Email: </td>
                <td>
                    <input type="text" class="text" size="40"
                           r:context="createaccount" 
                           r:name="account.email" 
                           r:required="false"
                           r:caption="Your Email"/>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Recovery Email: </td>
                <td>
                    <input type="text" class="text" size="40"
                           r:context="createaccount" 
                           r:name="info.recoveryemail"/><br/>
                    <span style="color:#6b6d6b;">This address is used to authenticate your account should you ever encounter problems or forget your password. If you do not have another email address, you may leave this field blank.</span><br/>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Location: </td>
                <td>
                    <select class="text" 
                            r:context="createaccount" 
                            r:name="info.location" 
                            r:caption="Location" 
                            r:items="locations" 
                            r:required="false"/>
                    </select><br/>
                </td>
            </tr>
			-->
            <tr>
                <td class="left caption text-top">Birthday: </td>
                <td>
                    <!--
                    <input type="text" class="text" size="40"
                              r:context="createaccount" 
                              r:name="account.birthdate" 
                              r:required="true"
                              r:caption="Birthday"/><br/>
                    -->
                    <span r:context="createaccount" 
                          r:type="datetime" 
                          r:name="account.birthdate"
                          r:options="{mode:'date'}">
                    </span><br/>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Gender: </td>
                <td>
                    <select class="text" 
                            r:context="createaccount" 
                            r:name="info.gender" 
                            r:caption="Gender" 
                            r:items="gender" 
                            r:required="false"/>
                </td>
            </tr>
            <tr>
                <td class="left caption text-top">Terms of Service: </td>
                <td>
                    <textarea cols="100" rows="12">
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
            <tr>
                <td class="left caption text-top"></td>
                <td>
					<span class="btn">
						<button r:context="createaccount" 
								r:name="createaccount">
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
