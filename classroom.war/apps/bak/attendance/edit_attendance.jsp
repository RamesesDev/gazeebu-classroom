<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<script>
	$put("edit_attendance",
		new function(){
			var svc = ProxyService.lookup("AttendanceService");
			this.classid = "${param['classid']}";
			this.date;
			this.list;
			this._controller;
			var self = this;
			
			this.onload = function() {
				//this.list = svc.getAttendance( this.classid, null );
			}
			this.save = function() {
			}
			
			this.propertyChangeListener = {
				"date" : function(o) {
					self.date = o;
					self.list = svc.getAttendance( self.classid, self.date );
					//self._controller.refresh();
				}
			}
			this.test = function(){}
		}
	);
</script>
<style>
	.attendance {
		font-size: 12px;
	}
	.attendance td {
		padding:2px;
	}
</style>


<t:popup>

	<jsp:attribute name="leftactions">
		<input type="button" r:context="edit_attendance" r:name="save" value="Save" /> 
	</jsp:attribute>

	<jsp:body>
		<div>Date: <input type="text" r:context="edit_attendance" r:name="date" r:datatype="date"/></div>
		<table r:depends="date" border="1" cellpadding="0" cellspacing="0" class="attendance" r:context="edit_attendance" r:items="list" r:varName="item" r:varStatus="stat" width="100%">
			<thead>
				<tr>
					<td>Student</td>
					<td valign="top" align="center" width="50">Present</td>
					<td valign="top" align="center" width="50">Late</td>
					<td valign="top" align="center" width="50">Late<br>Excused</td>
					<td valign="top" align="center" width="50">Absent</td>
					<td valign="top" align="center" width="50">Absent<br>Excused</td>
					<td valign="top" align="left">Remarks</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>#{item.lastname}, #{item.firstname}</td>
					<td align="center"><input type="radio" r:context="edit_attendance" r:name="list[#{stat.index}].status" value="present"/></td>
					<td align="center"><input type="radio" r:context="edit_attendance" r:name="list[#{stat.index}].status" value="late"/></td>
					<td align="center"><input type="radio" r:context="edit_attendance" r:name="list[#{stat.index}].status" value="late-excused"/></td>
					<td align="center"><input type="radio" r:context="edit_attendance" r:name="list[#{stat.index}].status" value="absent"/></td>
					<td align="center"><input type="radio" r:context="edit_attendance" r:name="list[#{stat.index}].status" value="absent-excused"/></td>
					<td><input type="text" r:context="edit_attendance" r:name="list[#{stat.index}].comment" style="width:100%"/></td>
				</tr>
			</tbody>
		</table>
		<button r:context="edit_attendance" r:name="test">Test</button>
	</jsp:body>
	
</t:popup>


