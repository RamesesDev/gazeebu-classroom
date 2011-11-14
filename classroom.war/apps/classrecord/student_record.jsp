<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>


<%
	Map map = new HashMap();
	map.put( "classid", request.getParameter("classid"));
	map.put( "studentid", request.getParameter("studentid") );
	request.setAttribute( "params", map );
%>

<s:invoke service="ClassrecordService" method="getStudentRecord" params="${params}" var="INFO"/>

<t:content>

	<jsp:attribute name="title">
		<c:if test="${! empty param['studentid']}">
			<a href="#classrecord:classrecord" style="font-size:10px;"><< Back to Classrecord</a><br>
		</c:if>
		Student Record for ${INFO.student.lastname}, ${INFO.student.firstname} 
	</jsp:attribute>
	
	<jsp:attribute name="style">
		
	</jsp:attribute>
	
	<jsp:attribute name="script">
		
	</jsp:attribute>
		
	<jsp:attribute name="rightpanel">
		<h2>TOTALS</h2>
		<table style="font-size:10px;">
			<c:forEach items="${INFO.criteriaTitles}" var="item">
				<tr>
					<td>${item.title}(${item.weight}%)</td>
				</tr>
			</c:forEach>
		</table>
	</jsp:attribute>	
		
	<jsp:body>
		Activities<br>
		<table width="80%" border="1">
			<tr>
				<td><b>Activity</b></td>
				<td><b>Date</b></td>
				<td width="100"><b>Score Result</b></td>
				<td width="100"><b>Max Score</b></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<c:forEach items="${INFO.activities}" var="item">
				<c:set var="criteria" value="${INFO.criteria[item.criteriaid]}"/>
				<c:set var="period" value="${(empty item.periodid) ? null : INFO.periods[item.periodid]}"/>
				<tr>
					<td>${item.title}</td>
					<td>${item.activitydate}</td>
					<td>${empty item.score ? '-' : item.score}</td>
					<td>${item.totalscore}</td>
					<td><b>${ criteria.title } (${criteria.weight })</b></td>
					<td>${(empty period)? 'none' : period.title }</td>
				</tr>
			</c:forEach>
		</table>
	</jsp:body>
	
</t:content>


	