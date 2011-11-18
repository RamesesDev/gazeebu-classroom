<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<t:popup>
	<jsp:attribute name="script">
		$put("getting_started",
			new function() 
			{
				this.locations = [];
				
				this.questions = [
					"What is the name of your bestfriend from childhood?",
					"What was the name of your first teacher?"
				];
				
				this.info;
				this.userid;
				
				var svc = ProxyService.lookup('UserProfileService');
				var usrinfo;
				
				this.onload = function() {
					usrinfo = svc.getInfo({objid: this.userid});
					if( !usrinfo.info ) usrinfo.info = {};
					this.info = usrinfo.info;
				}
				
				this.skip = function() {
					usrinfo.info.has_set_security = 1;
					svc.update( usrinfo );
					return '_close';
				}
				
				this.save = function() {
					if( this.info.security_question && !this.info.security_answer ) {
						alert('Please provide an answer for the specified question.');
						$('#ans').focus();
						return;
					}

					usrinfo.info.has_set_security = 1;					
					for( var i in this.info ) usrinfo.info[i] = this.info[i];
					svc.update(usrinfo);
					
					$.cookie(this.userid, true);
					return '_close';
				}
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<button r:context="getting_started" r:name="skip">Skip</button>
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<button r:context="getting_started" r:name="save">Save</button>
	</jsp:attribute>
	
	<jsp:body>
		<h2>Security Settings</h2>
		<table>
			<tr>
                <td valign="top" width="100">Security Quesion: </td>
                <td valign="top">
                    <select class="text" 
                            r:context="getting_started" 
                            r:name="info.security_question" 
                            r:caption="Security Question" 
                            r:items="questions"
							r:emptyText="Select a Quesion"
							r:allowNull="true"
                            r:required="false"/>
					</select>
					<br/>
                    <span style="color:#6b6d6b;">If you forget your password we will ask for the answer to your security question.</span><br/>
                </td>
            </tr>
            <tr>
                <td valign="top">Answer: </td>
                <td valign="top">
                    <input id="ans" type="text" class="text" size="40"
                           r:context="getting_started" 
                           r:name="info.security_answer" 
                           r:caption="Answer to Security Question"/>
                </td>
            </tr>
            <tr>
                <td valign="top">Recovery Email: </td>
                <td valign="top">
                    <input type="text" class="text" size="40"
                           r:context="getting_started" 
                           r:name="info.recoveryemail"/><br/>
                    <span style="color:#6b6d6b;">This address is used to authenticate your account should you ever encounter problems or forget your password. If you do not have another email address, you may leave this field blank.</span><br/>
                </td>
            </tr>
            <tr>
                <td valign="top">Location: </td>
                <td valign="top">
                    <select class="text"
                            r:context="getting_started" 
                            r:name="info.location" 
                            r:caption="Location" 
                            r:items="locations"
							r:emptyText="Select Your Location"
							r:allowNull="true"/>
                    </select>
                </td>
            </tr>
		</table>
	</jsp:body>
	
</t:popup>


