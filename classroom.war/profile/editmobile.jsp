<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<t:popup>
	<jsp:attribute name="head">
		<script>
		   $put("editmobile", 
			  new function() 
			  {
				this.handler;
				this.entity = {}; 

				this.save = function() {
					ProxyService.lookup('SMSSubscriptionService').update( this.entity );
					if( this.handler ) this.handler();
					return '_close';
				}
				
			  }
		   );
		</script>
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<input type="button" 
		   r:context="editmobile" 
		   r:name="save" 
		   value="Save"/>
	</jsp:attribute>
		
	<jsp:body>
		<table class="page-form-table" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td class="caption" width="100">
					Mobile No.
				</td>
				<td>
					<input type="text" class="text" size="30"
							r:context="editmobile"
							r:name="entity.phone"/>
					<b id="password-err" style="color:red;display:none;">Wrong password.</b>
				</td>
			</tr>
			<tr>
				<td class="caption">
					Keyword
				</td>
				<td>
					<input type="text" class="text" size="30"
							r:context="editmobile"
							r:name="entity.keyword"/>
				</td>
			</tr>
		</table>
	</jsp:body>
</t:popup>
