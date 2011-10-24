<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="server" %>
<%@ page import="java.util.*" %>
<%
	Map map = new HashMap();
	map.put("classid", request.getParameter("classid"));
	map.put("monthid", request.getParameter("monthid"));
	request.setAttribute( "PARAMS", map );
%>
<server:invoke service="AttendanceService" method="getByMonth" params="${PARAMS}" var="result"/>
<style>
	.attendance { font-size: 11px;}
	.day-column {
		font-size: 9px;
		background-color: lightyellow;
	}
	
	.present{ background-color: green;}
	.absent{ background-color: red;	}
	.late{ background-color: pink; }
	.late-excused{	background-color: yellow;}
	.absent-excused{background-color: lightblue;}
</style>

<script>
	$put( "attendance_month",
		new function() {
			this.editAttendance = function( d ){
				var handler = function(o){
					alert(o);
				}
				return new PopupOpener("attendance:attendance_edit", {date: "${result.year}-${result.monthid}-" +d, handler: handler});
			}
		}
	);
</script>



<t:content title="Attendance (${result.month})">
	<jsp:attribute name="actions">
			<a href="#attendance:attendance_summary">Back</a>
	</jsp:attribute>
	
	<jsp:body>
		<table class="attendance" border="1" width="780px" style="border-collapse:collapse;">
			<thead>
				<tr>
					<td width="150px">Students</td>
					<c:forEach begin="1" end="${result.days_in_month}" var="day">
						<td width="25px" class="day-column" align="center">
							<a href="#" onclick="$get('attendance_month').invoke(null, 'editAttendance', '${day}');">${day}</a>
						</td>
					</c:forEach>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${result.students}" var="item">
					<tr>
						<td>${item.lastname}, ${item.firstname}</td>
						<c:forEach begin="1" end="${result.days_in_month}" var="day">
							<c:set var="k">${day}</c:set>
							<td class="${item.entries[k]}">&nbsp;</td>
						</c:forEach>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</jsp:body>
</t:content>
