<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	$put("select_student",
		new function() {
			this.classid;
			this.handler;
			this.students = [];
			this.selectedStudents;
			
			var svc = ProxyService.lookup("StudentService");
			this.onload = function() {
				var _students = svc.getListByClass( {classid: this.classid} );
				if( this.selectedStudents != null ) {
					this.selectedStudents.each(
						function( o ) {
							_students.removeAll( function(x) {  return x.objid == o.objid; } );
						}
					)
				}
				
				this.students = _students;
			}
			
			this.select = function() {
				this.handler( this.students.findAll(function(o) { 
							return o.selected == true; 
						} 
					)
				);
				
				return "_close";
			}
		}
	);
</script>

<t:popup>

	<jsp:attribute name="rightactions">
			<input type="button" value="save" context="select_student" name="select">
			<input type="button" value="cancel" context="select_student" name="_close">
	</jsp:attribute>
	<jsp:body>
		<table context="select_student" items="students" varStatus="stat" cellspacing="5" cellpadding="0" width="100%" border="0">
			<thead>
				<tr>
					<td colspan="2"> Students<br/><hr/> </td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td width="10px"> <input type="checkbox" context="select_student" name="students[#{stat.index}].selected"/></td>
					<td>#{firstname} #{lastname} </td>
				</tr>
			</tbody>
		</table>
	</jsp:body>
</t:popup>