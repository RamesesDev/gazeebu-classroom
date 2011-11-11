<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ page import="java.util.*" %>


New Schedule 2
<br/>
<b>Start date: ${param['startdate']}</b>
<b>End date: ${param['enddate']}</b>
<br/>

Your date is : 
<%
	Date d1 = java.sql.Date.valueOf(request.getParameter("startdate"));
	Date d2 = java.sql.Date.valueOf(request.getParameter("enddate"));
	
	
%>;
S is ${s}. <br>
Days are: <label r:context="newschedule">#{entity.days}</label><br>

<input type="button" r:context="newschedule" r:name="_default" value="Next"/>
<br>
<c:forEach begin="1" end="10" var="item">
	${item}<br>
</c:forEach>