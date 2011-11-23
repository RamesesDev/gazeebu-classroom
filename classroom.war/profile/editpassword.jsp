<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<t:popup>
	<jsp:attribute name="head">
		<script>
		   $put("editpassword", 
			  new function() 
			  {
				var svc = ProxyService.lookup("LoginService");
				
				this.user = {};
				this.handler;
				 
				var self = this;
				this.entity = {};    

				this.propertyChangeListener = {
					"entity.confirmpassword" : function(o) {
						if(self.entity.newpassword != o)
							$('#repassword-err').show();
						else 
							$('#repassword-err').hide();
					},
					
					"entity.newpassword" : function(o) {
						if(self.entity.confirmpassword != o)
							$('#repassword-err').show();
						else
							$('#repassword-err').hide();
					}
				}
					
				this.save = function() {
					if(this.entity.confirmpassword != this.entity.newpassword) {
						alert("New passwords does not match.");
						return;
					}

					this.entity.username = this.user.username;
					svc.changePassword(this.entity);
					
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
		   r:context="editpassword" 
		   r:name="save" 
		   value="Save"/>
	</jsp:attribute>
		
	<jsp:body>
		<table class="page-form-table" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td class="caption" width="150">
					Recent Password
				</td>
				<td>
					<input type="password" class="text" size="30"
							r:context="editpassword"
							r:name="entity.oldpassword"/>
					<b id="password-err" style="color:red;display:none;">Wrong password.</b>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td class="caption">
					New Password
				</td>
				<td>
					<input type="password" class="text" size="30"
							r:context="editpassword"
							r:name="entity.newpassword"/>
				</td>
			</tr>
			<tr>
				<td class="caption">
					Re-enter Password
				</td>
				<td>
					<input type="password" class="text" size="30"
							r:context="editpassword"
							r:name="entity.confirmpassword"/>
					<b id="repassword-err" style="color:red;display:none;">Not matched.</b>
				</td>
			</tr>
		</table>
	</jsp:body>
</t:popup>
