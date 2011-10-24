<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="server" %>
<%@ page import="java.util.*" %>

<%
	
	Map map = new HashMap();
	map.put("date", request.getParameter("date"));
	map.put("classid", request.getParameter("classid"));
	
	request.setAttribute("PARAMS", map);
%>

<server:invoke service="AttendanceService" method="getByDay" params="${PARAMS}" var="result"/>
<script>
	$put( "attendance_edit",
		new function() {
			this.day;			
			this.monthid;
			
			this.entity = {entries: []};
			<c:forEach items="${result.entries}" var="student">
				this.entity.entries.push( {objid:"${student.objid}", date:"${param['date']}", studentid:"${student.studentid}", classid:"${param['classid']}"} );
			</c:forEach>
			
			this.save = function() {
				var svc = ProxyService.lookup("AttendanceService");
				svc.save(this.entity);
				return "_close";
			
			}
		}
	);
</script>

<t:popup>
	<jsp:attribute name="rightactions">
		<input type="button" value="save" context="attendance_edit" name="save">
	</jsp:attribute>
	
	<jsp:body>
		<table border="1" width="100%" style="border-collapse:collapse;">
			<thead> 
				<tr style="font-size:11px;">
					<th width="20%">Student</th>
					<th width="130px">Present</th>
					<th width="130px">Late</th>
					<th width="130px">Late/Excused</th>
					<th width="130px">Absent</th>
					<th width="130px">Absent/Excused</th>
					<th width="20%">Comment(s)</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${result.entries}" var="student" varStatus="stat">
					<tr>
						<td>${student.lastname}, ${student.firstname}</td>
						<td align="center"><input type="radio" context="attendance_edit" name="entity.entries[${stat.index}].status" value="present" /></td>
						<td align="center"><input type="radio" context="attendance_edit" name="entity.entries[${stat.index}].status" value="late" /></td>
						<td align="center"><input type="radio" context="attendance_edit" name="entity.entries[${stat.index}].status" value="late-excused" /></td>
						<td align="center"><input type="radio" context="attendance_edit" name="entity.entries[${stat.index}].status" value="absent" /></td>
						<td align="center"><input type="radio" context="attendance_edit" name="entity.entries[${stat.index}].status" value="absent-excused" /></td>
						<td align="center"><input type="text" context="attendance_edit" name="entity.entries[${stat.index}].comment"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</jsp:body>
</t:popup>
