<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<t:popup>
	<jsp:attribute name="script">
		$put(
			"new_class",
			new function() {
				var svc = ProxyService.lookup("ClassService");
				this.class = {}	
				this.editmode = "new";
				this._controller;
				this.save = function() {
					var o = svc.create( this.class );
					return "_close";
				}
			}
		);
	</jsp:attribute>

	<jsp:attribute name="leftactions">
		<input type="button" value="Save" r:context="new_class" r:name="save"/>	
	</jsp:attribute>
	
	<jsp:body>
		<table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td width="100">Class name</td>
				<td><input type="text" r:context="new_class" r:name="class.name" r:caption="Name" r:required="true"/></td>
			</tr>
			<tr>
				<td valign="top">Short Description</td>
				<td><textarea r:context="new_class" r:name="class.description" style="width:80%;"></textarea></td>
			</tr>
			<tr>
				<td valign="top">School</td>
				<td><input type="text" r:context="new_class" r:name="class.school" maxlength="50" r:caption="School" r:required="true" style="width:80%;"/></td>
			</tr>
		</table>
	</jsp:body>	
</t:popup>	