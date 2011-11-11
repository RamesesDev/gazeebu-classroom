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
		
	<jsp:body>
		<table width="40%">
			<tr>
				<td><b>Activity</b></td>
				<td width="100"><b>Score Result</b></td>
			</tr>
			<c:forEach items="${INFO.activities}" var="item">
				<tr>
					<td>${item.title}</td>
					<td>${empty item.score ? 'NR' : item.score} / ${item.totalscore}</td>
				</tr>
			</c:forEach>
		</table>
	</jsp:body>
	
</t:content>


	