<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td width="100">Class name</td>
		<td><input type="text" r:context="new_class" r:name="classinfo.name" maxlength="50" r:caption="Name" r:required="true"/></td>
	</tr>
	<tr>
		<td valign="top">Short Description</td>
		<td><textarea r:context="new_class" r:name="classinfo.description" style="width:80%;"></textarea></td>
	</tr>
	<tr>
		<td valign="top">No. of Units</td>
		<td><input type="text" r:context="new_class" r:name="classinfo.info.units" size="4"/></td>
	</tr>	
	<tr>
		<td valign="top">Room Schedule</td>
		<td><input type="text" r:context="new_class" r:name="classinfo.schedules" style="width:80%;" r:caption="Schedule" r:required="true"></td>
	</tr>
	<tr>
		<td valign="top">&nbsp;</td>
		<td><i style="font-size:11px;">Ex. 8:30-9:30 MWF Rm 101</i></td>
	</tr>
	<tr>
		<td valign="top">School</td>
		<td><input type="text" r:context="new_class" r:name="classinfo.school" maxlength="50" r:caption="School" style="width:80%;"/></td>
	</tr>	
</table>