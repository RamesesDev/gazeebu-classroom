<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<t:popup>
	<jsp:attribute name="head">
		<script src="js/ext/datetime.js"></script>
		<script>
			$put("editinfo", 
			  new function() 
			  {
				var svc = ProxyService.lookup("UserProfileService");
				this.user = {};
				this.handler;
				
				this.gender = [ 
					{id:"M", name:"Male"}, 
					{id:"F", name:"Female"}
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
		   r:context="editinfo" 
		   r:name="save" 
		   value="Save"/>
	</jsp:attribute>
		
	<jsp:body>
		<table class="page-form-table" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td class="caption right">
					Firstname: &nbsp;&nbsp;
				</td>
				<td>
					<input type="text" 
							class="text" 
							r:context="editinfo" 
							r:name="user.firstname"
							size="40"/>
				</td>
			</tr>
			<tr>
				<td class="caption right">
					Lastname: &nbsp;&nbsp;
				</td>
				<td>
					<input type="text" 
							class="text" 
							r:context="editinfo" 
							r:name="user.lastname"
							size="40"/>
				</td>
			</tr>
			<tr>
			  <td class="caption right">
				 Email: &nbsp;&nbsp;
			  </td>
			  <td>
				 <input type="text" 
					   class="text" 
					   r:context="editinfo" 
					   r:name="user.email"
					   size="50"/>
			  </td>
		   </tr>
		   <tr>
			  <td class="caption right">
				 Gender: &nbsp;&nbsp;
			  </td>
			  <td>
				 <select r:context="editinfo" 
					   r:name="user.gender" 
					   r:caption="Gender" 
					   r:items="gender" 
					   r:itemKey="id" 
					   r:itemLabel="name" 
					   r:required="true">
				 </select>
			  </td>
		   </tr>
		   <tr>
			  <td class="caption right">
				 Birthday: &nbsp;&nbsp;
			  </td>
			  <td>
				 <span r:type="datetime" r:context="editinfo" r:name="user.birthdate" r:mode="date"/>
			  </td>
		   </tr>
		   <tr>
			  <td class="caption right">
				 Language: &nbsp;&nbsp;
			  </td>
			  <td>
				 <input type="text" 
					   class="text" 
					   r:context="editinfo" 
					   r:name="user.languages"
					   size="40"/>
			  </td>
		   </tr>
		   <tr>
			  <td class="caption right" valign="top">
				 About Me: &nbsp;&nbsp;
			  </td>
			  <td>
				<textarea type="text" 
						  class="text" 
						  r:context="editinfo" 
						  r:name="user.aboutme"
						  cols="39" rows="8">
				</textarea>
			  </td>
		   </tr>
		</table>
	</jsp:body>
</t:popup>
