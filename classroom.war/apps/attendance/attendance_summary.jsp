<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>


<s:invoke service="AttendanceService" method="getSummary" params="${param['classid']}" var="INFO"/>

<script>
	$put("attendance_summary",
		new function(){
			this.editAttendance = function() {
				return new PopupOpener("attendance:edit_attendance");	
			}
			this.editSchoolDays = function() {
				return new DropdownOpener("attendance:edit_schooldays");	
			}
		}
	);
</script>
<style>
	.title {
		padding: 4px;
		font-weight:bold;
		border-bottom: 1px solid lightgrey;
	}
	.students {
		font-size:12px;
	}
</style>


<t:content title="Attendance Summary">
	
	<jsp:attribute name="actions">
		<input type="button" r:context="attendance_summary" r:name="editSchoolDays" value="Edit School Days" /> 
		<input type="button" r:context="attendance_summary" r:name="editAttendance" value="Edit Attendance" /> 
	</jsp:attribute>

	<jsp:body>
		<br>
		<table class="students" cellpadding="0" cellspacing="0" width="80%" border="1">
			<tr>
				<td width="150" valign="top" class="title">Students</td>
				<c:forEach items="${INFO.months}" var="item">
					<td align="center" width="50"  class="title">${item.title}</td>
				</c:forEach>
				<td class="title" colspan="3">Totals</td>
			</tr>	
			
			<tr>
				<td align="right" class="title">School Days</td>
				<c:forEach items="${INFO.months}" var="item">
					<td align="center"  class="title">${item.school_days}</td>
				</c:forEach>
				<td>Late</td>
				<td>Absent</td>
				<td>Excused</td>
 				
			</tr>
			<tr>
				<td colspan="${fn:length(INFO.months)+2}" style="padding:4px;">&nbsp;</td>
			</tr>
			<c:forEach items="${INFO.students}" var="item">
				<tr>
					<td>${item.lastname},${item.firstname}</td>
					<c:forEach items="${INFO.months}" var="item">
						<td align="center">${item.month}</td>
					</c:forEach>
					<td>&nbsp;</td>
				</tr>
			</c:forEach>
		</table>
	</jsp:body>
	
</t:content>


