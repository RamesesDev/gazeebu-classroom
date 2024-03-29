<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<%
	Map m = new HashMap();
	m.put("classid", request.getParameter("classid") );
	request.setAttribute( "params", m );
%>

<s:invoke service="ClassrecordService" method="getSummary" params="${params}" var="INFO"/>

<t:content title="Class Record">

	<jsp:attribute name="style">
		.title {
			padding: 4px;
			font-weight:bold;
			border-bottom: 1px solid lightgrey;
		}
		#activitytext {
			writing-mode:tb-rl;
			filter: flipV flipH;
			-webkit-transform:rotate(-90deg);
			-moz-transform:rotate(-90deg);
			-o-transform: rotate(-90deg);
			display:block;
			bottom:0;
			white-space: inherit;
			font-size: 9px;
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
		$register( {id:"edit_activity", page:"apps/classrecord/edit_activity.jsp", context:"edit_result", title:"Edit Scores", options:{width:500,height:400}} );
		$register( {id:"new_activity", page:"apps/classrecord/new_activity.jsp", context:"new_activity", title:"Add New Entry" , options:{width:500,height:400}} );
		
		$put("classrecord",
			new function() {
				var svc = ProxyService.lookup("ActivityService");
				var self = this;
				this._controller;
				
				this.criteriaList = [];
				<c:forEach items="${INFO.criteria}" var="c">
				this.criteriaList.push( {objid:"${c.objid}", title:"${c.title}"} );	
				</c:forEach>
				
				this.termList = [];
				<c:forEach items="${INFO.terms}" var="c">
				this.termList.push( {objid:"${c.objid}", term:"${c.term}"} );	
				</c:forEach>
				this.addEntry = function() {
					var saveHandler = function(o) {
						svc.create( o );
						self._controller.reload();
					}
					return new PopupOpener("new_activity", {saveHandler: saveHandler});
				}	
				this.editEntry = function() {
					var saveHandler = function(o) {
						self._controller.reload();	
					}
					return new PopupOpener("edit_activity", {activityid: this.activityid, saveHandler:saveHandler});
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="actions">
		<input type="button" r:context="classrecord" r:name="addEntry" value="Add Entry" /> 
	</jsp:attribute>
	
	<jsp:body>
		Legend<br>
		<table>
			<tr>
			<c:forEach items="${INFO.criteria}" var="c">
				<td style="padding:2px;"><div style="background-color:${c.colorcode};width:10px;height:10px;">&nbsp;</div></td>
				<td>${c.title}</td>
				<td>&nbsp;&nbsp;&nbsp;</td>
			</c:forEach>
			</tr>
		</table>
	
		<table class="students" cellpadding="1" cellspacing="0" width="100%" border="1">
			<tr>
				<td width="150" height="120" valign="top" class="title">Students</td>
				<c:forEach items="${INFO.activities}" var="item" varStatus="stat">
					<td align="center" width="50" title="${item.title}" style="background-color:${item.colorcode}">
						<a r:context="classrecord" r:name="editEntry" r:params="{activityid: '${item.objid}'}">
							<div id="activitytext">${item.title}</div>
						</a>
					</td>
				</c:forEach>
				<td>&nbsp;</td>
			</tr>	
			<tr>
				<td align="right" class="title">Date Taken</td>
				<c:forEach items="${INFO.activities}" var="item"  varStatus="stat">
					<td align="center" class="title"  style="background-color:${item.colorcode}">${item.activitydate}</td>
				</c:forEach>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align="right" class="title">Highest Possible Score</td>
				<c:forEach items="${INFO.activities}" var="item" varStatus="stat">
					<td align="center" style="background-color:${item.colorcode}">${item.totalscore}</td>
				</c:forEach>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="${fn:length(INFO.activities)+2}" style="padding:4px;">&nbsp;</td>
			</tr>
			
			<!-- display the students -->
			<c:forEach items="${INFO.students}" var="student">
				<tr>
					<td>${student.lastname},${student.firstname}</td>
					<c:forEach items="${INFO.activities}" var="item">
						<c:set var="activityid">${item.objid}</c:set>
						<td align="center" id="${student.entries[activityid].scorestate}" style="background-color:${item.colorcode}" title="${student.entries[activityid].remarks}">
							${student.entries[activityid].score}
						</td>
					</c:forEach>
					<td>&nbsp;</td>
				</tr>
			</c:forEach>
		</table>
		
		
		
	</jsp:body>
	
</t:content>
