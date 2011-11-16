<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<t:popup>
	<jsp:attribute name="head">
		<script>
		   $put("editaddress", 
			  new function() {
				 var svc = ProxyService.lookup("UserProfileService");
				 this.user = {};
				 this.handler;
			  
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
		   r:context="editaddress" 
		   r:name="save" 
		   value="Save"/>
	</jsp:attribute>

	<jsp:body>
		<table class="page-form-table" cellpadding="0" cellspacing="0" border="0">
		   <tr>
			  <td class="caption right">
				 Address: &nbsp;&nbsp;
			  </td>
			  <td>
				 <input type="text" 
					   class="text" 
					   r:context="editaddress" 
					   r:name="user.homeaddress.address"
					   size="40"/>
			  </td>
		   </tr>
		   <tr>
			  <td class="caption right">
				 Zip: &nbsp;&nbsp;
			  </td>
			  <td>
				 <input type="text" 
					   class="text" 
					   r:context="editaddress" 
					   r:name="user.homeaddress.zip"
					   size="40"/>
			  </td>
		   </tr>
		</table>
	</jsp:body>
</t:popup>
