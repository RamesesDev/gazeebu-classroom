<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<s:invoke service="ExamService" method="getSummary" params="${param['classid']}" var="INFO"/>

<t:content title="Exams">

	<jsp:attribute name="style">
		.title {
			padding: 4px;
			font-weight:bold;
			border-bottom: 1px solid lightgrey;
		}
		#examtext {
			writing-mode:tb-rl;
			filter: flipV flipH;
			-webkit-transform:rotate(-90deg);
			-moz-transform:rotate(-90deg);
			-o-transform: rotate(-90deg);
			display:block;
			bottom:0;
			white-space: inherit;
			size: 10px;
		}
		#odd-col {
			background-color: lightyellow;
		}
		#even-col {
			background-color: pink;
		}
		.students {
			font-size:12px;
		}
		#fail {
			color:red;
		}
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put("exam_results",
			new function() 
			{
				this.examid;
				this._controller;
				var self = this;
				
				this.addExam = function() {
					var saveHandler = function(o) {
						self._controller.reload();
					}
					return new PopupOpener("exam:new_exam", {saveHandler: saveHandler});
				}
				
				this.editResults = function() {
					var saveHandler = function(o) {
						self._controller.reload();
					}
					return new PopupOpener("exam:edit_result", {examid: this.examid, saveHandler:saveHandler});
				}
			}
		);
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
						<a r:context="exam_results" r:name="editResults" r:params="{examid: '${item.objid}'}">
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
			<tr>
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
			<c:forEach items="${INFO.students}" var="student">
				<tr>
					<td>${student.lastname},${student.firstname}</td>
					<c:forEach items="${INFO.exams}" var="item">
						<c:set var="examid">${item.objid}</c:set>
						<td align="center" id="${student.entries[examid].scorestate}" title="${student.entries[examid].remarks}">
							${student.entries[examid].score}
						</td>
					</c:forEach>
					<td>&nbsp;</td>
				</tr>
			</c:forEach>
		</table>
	</jsp:body>
	
</t:content>


