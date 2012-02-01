<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<%
	Map m = new HashMap();
	m.put("classid", request.getParameter("classid") );
	if( request.getParameter("periodid")!=null && request.getParameter("periodid").toString().trim().length() > 0 ) {
		m.put("periodid", request.getParameter("periodid") );
	}
	request.setAttribute( "params", m );
%>

<s:invoke service="ClassrecordService2" method="getSummary" params="${params}" var="INFO" debug="true"/>

<t:content title="Class Record">

	<jsp:attribute name="style">
		.students {
			font-size:11px;
			border: solid 1px #888;
			box-shadow: 0 4px 10px #aaa;
			-moz-box-shadow: 0 4px 10px #aaa;
			-webkit-box-shadow: 0 4px 10px #aaa;
		}
		
		.students th,
		.students td {
			padding: 2px 3px;
			border-bottom: solid 1px #aaa;
			border-right: solid 1px #bbb;
		}
		
		.students .title {
			padding: 4px;
			font-weight:bold;
			border-bottom: 1px solid lightgrey;
		}
		.students .activitytext {
			writing-mode:tb-rl;
			filter: flipV flipH;
			-webkit-transform:rotate(-90deg);
			-moz-transform:rotate(-90deg);
			-o-transform: rotate(-90deg);
			transform: rotate(-90deg);
			bottom:0;
			display: block;
			font-size: 9px;
		}
		
		.students .row-num {
			position:absolute; left:-7px; top:0;
			color: #fff;
			background: #555;
			border: solid 1px #ccc;
			border-radius: 4px;
			-moz-border-radius: 4px;
			-webkit-border-radius: 4px;
			font-size: 9px;
			height: 14px; line-height: 14px;
			width: 14px;
			text-align: center;
		}
		
		.students .link { text-decoration: none; }
		.students .link:hover { text-decoration: underline; }
		.students tr.separator td { border-bottom: solid 2px #888; }
		.students tr.first-row td { border-top: solid 1px #aaa; }		
		.students .failed { color:red; }
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$register( {id:"new_activity", page:"classroom/classrecord/new_activity.jsp", context:"new_activity", title:"Add New Activity" , options:{width:500,height:400}} );
		$register( {id:"edit_activity", page:"classroom/classrecord/edit_activity.jsp", context:"edit_result", title:"Edit Scores", options:{width:500,height:400}} );
		
		$put("classrecord",
			new function() {
				var self = this;
				this._controller;
				this.periodid;
				this.periods = [];
				<c:forEach items="${INFO.gradingPeriods}" var="p"> 
				this.periods.push( {objid:"${p.objid}", title:"${p.title}" } );
				</c:forEach>
				
				var afterSave = function() {
					self._controller.reload();
				}
				this.addEntry = function() {
					return new PopupOpener("new_activity", {saveHandler: afterSave});
				}	
				this.editEntry = function() {
					return new PopupOpener("edit_activity", {activityid: this.activityid, saveHandler:afterSave});
				}
				
				var firstLoad = true;
				this.propertyChangeListener = {
					"periodid" : function(o) {
						if( !firstLoad ) {
							location.hash='classrecord:classrecord?periodid='+o;
						}
						firstLoad = false;
					}
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="actions">
		<c:if test="${! empty INFO.gradingPeriods}">
		Period: <select r:context="classrecord" r:items="periods" r:itemKey="objid" r:itemLabel="title" r:name="periodid" 
			r:allowNull="true" r:emptyText="All" />
		</c:if>
		<input class="button" type="button" r:context="classrecord" r:name="addEntry" value="Add Entry" /> 
	</jsp:attribute>
	
	<jsp:body>
		Legend<br>
		<table>
			<tr>
			<c:forEach items="${INFO.gradingCriteria}" var="c">
				<td style="padding:2px;"><div style="background-color:${c.colorcode};width:10px;height:10px;">&nbsp;</div></td>
				<td>${c.title}</td>
				<td>&nbsp;&nbsp;&nbsp;</td>
			</c:forEach>
			</tr>
		</table>
		
		
		<br>
		<table class="students" cellpadding="0" cellspacing="0" width="100%" border="0">
			<tr>
				<td width="150" height="120" valign="top">Students</td>
				<c:forEach items="${INFO.activities}" var="item" varStatus="stat">
					<td align="center" width="50px" height="100px" title="${item.title}" style="background-color:${item.colorcode}">
						<a r:context="classrecord" r:name="editEntry" r:params="{activityid: '${item.objid}'}">
							<div class="activitytext">${item.title}</div>
						</a>
					</td>
				</c:forEach>
				<td>&nbsp;</td>
			</tr>	
			<tr>
				<td align="right">Date Taken</td>
				<c:forEach items="${INFO.activities}" var="item"  varStatus="stat">
					<td align="center" style="background-color:${item.colorcode}">${item.activitydate}</td>
				</c:forEach>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align="right">Highest Possible Score</td>
				<c:forEach items="${INFO.activities}" var="item" varStatus="stat">
					<td align="center" style="background-color:${item.colorcode}">${item.totalscore}</td>
				</c:forEach>
				<td>&nbsp;</td>
			</tr>
			<tr class="separator">
				<td align="right">Passing Score</td>
				<c:forEach items="${INFO.activities}" var="item" varStatus="stat">
					<td align="center" style="background-color:${item.colorcode}">
						${empty item.passingscore? '-' : item.passingscore}
					</td>
				</c:forEach>
				<td>&nbsp;</td>
			</tr>
			
			<!-- display the students -->
			<c:forEach items="${INFO.students}" var="student" varStatus="stat">
				<tr class="${stat.first? 'first-row' : ''}" title="${student.lastname},${student.firstname}">
					<td>
						<div style="position:relative;padding-left:15px;">
							<span class="row-num">
								${stat.index+1}
							</span>
							<a href="#classrecord:student_record?studentid=${student.objid}"
							   class="capitalized link">
								${student.lastname},${student.firstname}
							</a>
						</div>
					</td>
					<c:forEach items="${INFO.activities}" var="item">
						<c:set var="activityid">${item.objid}</c:set>
						<c:set var="activity" value="${student.entries[activityid]}"/>
						<td align="center" class="${activity.scorestate}" style="background-color:${item.colorcode}" title="${activity.remarks}">
							${empty activity.score? '-' : activity.score}
						</td>
					</c:forEach>
					<td>&nbsp;</td>
				</tr>
			</c:forEach>
			
		</table>
		
	</jsp:body>
	
</t:content>
