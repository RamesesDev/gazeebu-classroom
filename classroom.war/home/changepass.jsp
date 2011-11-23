<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<t:popup>
	<jsp:attribute name="head">
		<script>
		   $put("changepass", 
			  new function() 
			  {
				var svc = ProxyService.lookup("UserProfileService");
				this.entity = {};
					
				this.save = function() {
					if(this.entity.confirmpassword != this.entity.newpassword) {
						$('#repassword-err').fadeIn();
						return;
					}
					svc.changePassword(this.entity);
					return "_close";
				}
			  }
		   );
		</script>
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<input type="button" 
		   r:context="changepass" 
		   r:name="save" 
		   value="Save"/>
	</jsp:attribute>
		
	<jsp:body>
		<h3>You need to change your temporary password.</h3>
		<table class="page-form-table" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td class="caption">
					New Password
				</td>
				<td>
					<input type="password" class="text" size="30"
							r:context="changepass"
							r:name="entity.newpassword"/>
				</td>
			</tr>
			<tr>
				<td class="caption" style="padding-right:10px;">
					Re-enter Password
				</td>
				<td>
					<input type="password" class="text" size="30"
							r:context="changepass"
							r:name="entity.confirmpassword"/>
					<b id="repassword-err" style="color:red;display:none;">Not matched.</b>
				</td>
			</tr>
		</table>
	</jsp:body>
</t:popup>
