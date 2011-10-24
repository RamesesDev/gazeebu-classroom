<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="server" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>



<server:invoke service="AttendanceService" method="getSummaryByClass" params="${param['classid']}" var="result"/>
<c:set  var="monthSize" value="${fn:length( result.months )}"/>

<script>
	$put( "attendance_summary",
		new function() {

		}
	);
</script>


<t:content title="Attendance Romel">
	<jsp:attribute name="actions">
	
	</jsp:attribute>
	
	<jsp:body>
		<table border="1" width="750px" style="border-collapse:collapse;">
			<thead>
				<tr>
					<th rowspan="2">Student</th>
					<th colspan="${monthSize}" height="50px">
						<fmt:formatDate value="${result.fromdate}" pattern="MMMM yyyy"/>-
						<fmt:formatDate value="${result.todate}" pattern="MMMM yyyy"/>
					</th>
				</tr>
				<tr>
					<c:forEach items="${result.months}" var="month">
						<th>
							<fmt:formatDate value="${month.date}" pattern="MMM"/><br/>
							<b style="font-size:10px;">(${month.schooldays})</b><br/>
							<fmt:formatDate value="${month.date}" pattern="yyyyMM" var="id"/>
							<a href="#attendance:attendance_month?monthid=${id}">View</a>
						</th>
					</c:forEach>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${result.students}" var="student">
					<tr>
						<td>${student.lastname}, ${student.firstname}</td>
						<c:forEach items="${result.months}" var="month">
							<td align="center">
								<fmt:formatDate value="${month.date}" pattern="yyyyMM" var="dtname"/>
								<div style="font-size:11px;">${student.attendance[dtname].present}</div>
							</td>
						</c:forEach>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</jsp:body>
</t:content>
