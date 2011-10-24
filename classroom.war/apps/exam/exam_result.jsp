<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<s:invoke service="ExamService" method="getSummary" params="${param['classid']}" var="INFO"/>

<t:popup title="Exam Result">

	<jsp:attribute name="style">
	</jsp:attribute>
	
	<jsp:attribute name="script">
	</jsp:attribute>
	
	<jsp:attribute name="actions">
		<input type="button" r:context="exam_results" r:name="addExam" value="Add Exam" /> 
	</jsp:attribute>
	
	<jsp:body>
		<table class="students" cellpadding="1" cellspacing="0" width="100%" border="1">
			<tr>
				<td width="150" height="120" valign="top" class="title">Students</td>
				<c:forEach items="${INFO.exams}" var="item" varStatus="stat">
					<td align="center" width="60" title="${item.title}" id="${stat.index % 2 == 0 ? 'odd-col' : 'even-col'}">
						<a r:context="exam_results" r:name="editExam" r:params="{examid: '${item.objid}'}">
							<div id="examtext">${item.title}</div>
						</a>
					</td>
				</c:forEach>
				<td>&nbsp;</td>
			</tr>	
			<tr>
				<td align="right" class="title">Date Taken</td>
				<c:forEach items="${INFO.exams}" var="item"  varStatus="stat">
					<td align="center" class="title"  id="${stat.index % 2 == 0 ? 'odd-col' : 'even-col'}">${item.examdate}</td>
				</c:forEach>
				<td>&nbsp;</td>
			</tr>
				<td align="right" class="title">Max Score</td>
				<c:forEach items="${INFO.exams}" var="item" varStatus="stat">
					<td align="center"  id="${stat.index % 2 == 0 ? 'odd-col' : 'even-col'}">${item.maxscore}</td>
				</c:forEach>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="${fn:length(INFO.exams)+2}" style="padding:4px;">&nbsp;</td>
			</tr>
			
			<!-- display the students -->
			<c:forEach items="${INFO.students}" var="item">
				<tr>
					<td>${item.lastname},${item.firstname}</td>
					<c:forEach items="${INFO.exams}" var="item">
						<td align="center">x</td>
					</c:forEach>
					<td>&nbsp;</td>
				</tr>
			</c:forEach>
		</table>
	</jsp:body>
	
</t:content>


