<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
	$put(
		"classroom_info",
		new function() {
			var svc = ProxyService.lookup("ClassService");
			this.class = {}	
			this.editmode = "new";
			this.save = function() {
				var o = svc.create( this.class );
			}
		}
	);
</script>
<style>

</style>

<t:content title="New Classroom">
	
	<table width="100%">
		<tr>
			<td>Class URL</td>
			<td>
				<input type="text" r:context="classroom_info" r:name="class.classurl" r:required="true" r:caption="Class Code"/>	
			</td>
		</tr>
		<tr>
			<td>Class name</td>
			<td><input type="text" r:context="classroom_info" r:name="class.name" r:caption="Name" r:required="true"/></td>
		</tr>
		<tr>
			<td valign="top">Description</td>
			<td><textarea r:context="classroom_info" r:name="class.description"/></td>
		</tr>
		
		<tr>
			<td valign="top">School</td>
			<td><input type="text" r:context="classroom_info" r:name="class.school" r:caption="School" r:required="true"/></td>
		</tr>
		<tr>
			<td valign="top">Timezone</td>
			<td><input type="text" r:context="classroom_info" r:name="class.timezone" r:caption="Timezone" r:required="true"/></td>
		</tr>

		<tr>
			<td valign="top">Start date</td>
			<td><input type="text" r:context="classroom_info" r:datatype="date" r:name="class.startdate" r:required="true"/></td>
		</tr>
		<tr>
			<td valign="top">End date</td>
			<td><input type="text" r:context="classroom_info" r:datatype="date"  r:name="class.enddate" r:required="true"/></td>
		</tr>
		
		<tr>
			<td>&nbsp;</td>
			<td>
				<input type="button" value="Save" r:context="classroom_info" r:name="save"/>	
			</td>
		</tr>
	</table>
	
</t:content>	