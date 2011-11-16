<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<t:popup>
	<jsp:attribute name="script">
		$put(
			"new_class",
			new function() {
				this.saveHandler;
				var svc = ProxyService.lookup("ClassService");
				this.class = {}	
				this.editmode = "new";
				this._controller;
				this.save = function() {
					var o = svc.create( this.class );
					if(this.saveHandler) this.saveHandler();
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
				<td><input type="text" r:context="new_class" r:name="class.name" maxlength="50" r:caption="Name" r:required="true"/></td>
			</tr>
			<tr>
				<td valign="top">Room Schedule</td>
				<td><input type="text" r:context="new_class" r:name="class.schedules" style="width:80%;" r:caption="Schedule" r:required="true"></td>
			</tr>
			<tr>
				<td valign="top">&nbsp;</td>
				<td><i style="font-size:11px;">Ex. 8:30-9:30 MWF Rm 101</i></td>
			</tr>
			<tr>
				<td valign="top">School</td>
				<td><input type="text" r:context="new_class" r:name="class.school" maxlength="50" r:caption="School" style="width:80%;"/></td>
			</tr>
			<tr>
				<td valign="top">Short Description</td>
				<td><textarea r:context="new_class" r:name="class.description" style="width:80%;"></textarea></td>
			</tr>
			
		</table>
	</jsp:body>	
</t:popup>	