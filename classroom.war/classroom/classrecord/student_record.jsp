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
		<table class="page-form-table" width="80%" cellpadding="0" cellspacing="0">
            <tr>
                <td rowspan="4" width="60" style="padding-right:10px;">
					<img src="profile/photo.jsp?id=${INFO.student.objid}&t=thumbnail"/>
                </td>
            </tr>
            <tr>
                <td class="caption" style="font-size:14px;">
                    ${INFO.student.firstname} ${INFO.student.lastname}
                </td>
                <td>
                    <img src="img/phone.png" style="padding-right:5px;"/>
                    ${INFO.student.mobile}
                </td>
            </tr>
            <tr>
                <td>
                    <i>${INFO.student.username}</i>
                </td>
                <td>
                    <img src="img/email.png" style="padding-right:5px;"/>
                    ${INFO.student.email}
                </td>
            </tr>
			<tr>
                <td>
                    ${INFO.student.usertype} ${INFO.student.objid=='${USER_INFO.objid}' ? '(me)' : ''}
                </td>
            </tr>			
        </table>
	</jsp:attribute>
	
	<jsp:attribute name="style">
		
	</jsp:attribute>
	
	<jsp:attribute name="script">
		
	</jsp:attribute>
		
	<jsp:attribute name="rightpanel">
		
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
		
		<h2>TOTALS</h2>
		<table style="font-size:10px;">
			<c:forEach items="${INFO.criteriaTitles}" var="item">
				<tr>
					<td>${item.title}(${item.weight}%)</td>
				</tr>
			</c:forEach>
		</table>
		
		<table style="font-size:11px;" border="1" cellpadding="2" cellspacing="0">
			<tr>
				<td><b>Criteria</b></td>
				<td><b>Period</b></td>
				<td><b>Total Score</b></td>
				<td><b>Score</b></td>
			</tr>
			<c:forEach items="${INFO.totals}" var="item">
				<c:set var="criteria" value="${INFO.criteria[item.criteriaid]}"/>
				<c:set var="period" value="${(empty item.periodid) ? null : INFO.periods[item.periodid]}"/>
				<tr>
					<td>${ criteria.title }</td>
					<td>${(empty period)? 'none' : period.title }</td>
					<td>${item.totalscore}</td>
					<td>${item.score}</td>
				</tr>
			</c:forEach>
		</table>
	</jsp:body>
	
</t:content>


	