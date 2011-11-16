<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<t:popup>
	<jsp:attribute name="head">
		<script>
			$put(
				"editsecurity", 
				new function() 
				{
					var svc = ProxyService.lookup("UserProfileService");
					var self = this;
					this.user = {};
					this.handler;
					
					this.questions = [
						"What is the name of your bestfriend from childhood?",
						"What was the name of your first teacher?"
					];
					
					this.save = function() {
						svc.update(this.user);
						if(this.handler)
						this.handler();

						return "_close";
					}
				}
			);
		</script>
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<input type="button" 
			r:context="editsecurity" 
			r:name="save" 
			value="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td class="left caption text-top" width="30%" style="padding:5px">Security Quesion: </td>
				<td>
					<select class="text" 
							r:context="editsecurity" 
							r:name="user.info.security_question" 
							r:caption="Security Question" 
							r:items="questions" 
							r:required="false"/></select><br/>
					<span style="color:#6b6d6b;">If you forget your password we will ask for the answer to your security question.</span><br/>
				</td>
			</tr>
			<tr>
				<td class="left caption text-top" style="padding:5px">Answer: </td>
				<td>
					<input type="text" class="text" size="40"
							r:context="editsecurity" 
							r:name="user.info.security_answer" 
							r:required="false"
							r:caption="Answer to Security Question"/>
				</td>
			</tr>
		</table>
	</jsp:body></t:popup>