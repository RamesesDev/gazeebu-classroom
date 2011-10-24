

<script>
	$put(
		"class_new",
		new function() {
			this.handler;
			this.class = {}	
			
			this.save = function() {
				var svc = ProxyService.lookup("ClassService");
				var o = svc.create( this.class );
				this.handler(o.objid);
				return "_close";
			}
			
		}
	);
</script>
<style>

</style>

<table width="100%">
	<tr>
		<td>Class name</td>
		<td><input type="text" context="class_new" name="class.name" caption="Name" required="true"/></td>
	</tr>

	<tr>
		<td valign="top">Description</td>
		<td><textarea context="class_new" name="class.description"/></td>
	</tr>
	
	<tr>
		<td valign="top">School</td>
		<td><input type="text" context="class_new" name="class.school" caption="School" required="true"/></td>
	</tr>
	<tr>
		<td valign="top">Timezone</td>
		<td><input type="text" context="class_new" name="class.timezone" caption="Timezone" required="true"/></td>
	</tr>

	<tr>
		<td valign="top">Start date</td>
		<td><input type="text" context="class_new" datatype="date" name="class.startdate" required="true"/></td>
	</tr>
	<tr>
		<td valign="top">End date</td>
		<td><input type="text" context="class_new" datatype="date"  name="class.enddate" required="true"/></td>
	</tr>
	<tr>
		<td colspan="2">Class URL(use this url to send to invite students to join this class)</td>
	</tr>
	<tr>
		<td colspan="2" style="font-size:12px;">
			http://www.gazeebu.com/classroom/join_class.jsp?url=
			<input type="text" context="class_new" name="class.classurl" required="true" caption="Class URL" style="font-size:12px;width:200px;"/>	
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="Save" context="class_new" name="save"/>	
		</td>
	</tr>
</table>