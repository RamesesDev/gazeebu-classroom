<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>


<t:popup>

	<jsp:attribute name="style">
		.edit_result td {
			font-size:11px;
		}
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put("edit_info",
			new function() 
			{
				this.handler;
				this.classinfo;
				
				this.onload = function() {
					if( !this.classinfo.info ) {
						this.classinfo.info = {};
					}
				}
				
				this.save = function() {
					var svc = ProxyService.lookup('ClassService');
					svc.update(this.classinfo);
					if( this.handler ) this.handler();
					return '_close';
				}
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<input type="button" r:context="edit_info" r:name="save" value="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<table>
			<tr>
				<td width="100">Class name</td>
				<td><input type="text" r:context="edit_info" r:name="classinfo.name" maxlength="50" style="width:250px" r:caption="Name" r:required="true"/></td>
			</tr>
			<tr>
				<td valign="top">Short Description</td>
				<td><textarea r:context="edit_info" r:name="classinfo.description" style="width:250px;height:50px;"></textarea></td>
			</tr>
			<tr>
				<td valign="top">No. of Units</td>
				<td><input type="text" r:context="edit_info" r:name="classinfo.info.units" size="4"/></td>
			</tr>
			<tr>
				<td valign="top">Room Schedule</td>
				<td><input type="text" r:context="edit_info" r:name="classinfo.schedules" style="width:250px" r:caption="Schedule" r:required="true"></td>
			</tr>
			<tr>
				<td valign="top">&nbsp;</td>
				<td><i style="font-size:11px;">Ex. 8:30-9:30 MWF Rm 101</i></td>
			</tr>
			<tr>
				<td valign="top">School</td>
				<td><input type="text" r:context="edit_info" r:name="classinfo.school" maxlength="50" r:caption="School" style="width:250px;"/></td>
			</tr>
		</table>
	</jsp:body>
	
</t:popup>


