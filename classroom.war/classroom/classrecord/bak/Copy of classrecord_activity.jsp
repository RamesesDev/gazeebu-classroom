<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<%
	Map m = new HashMap();
	m.put("classid", request.getParameter("classid") );
	m.put("criteriaid", request.getParameter("criteriaid") );
	m.put("termid", request.getParameter("termid") );	
	request.setAttribute( "params", m );
%>
<s:invoke service="ActivityService" method="getSummary" params="${params}" var="INFO"/>

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
		$register( {id:"#classrecord_context", context:"classrecord"} );
		
		$put("classrecord",
			new function() {
				var svc = ProxyService.lookup("ActivityService");
			
				this._controller;
				this.criteriaList;
				this.termList;
				this.qry = {};
				
				var self = this;
				this.onload = function() {
					var res = svc.getResources( {classid: "${param['classid']}" });
					this.criteriaList = res.criteriaList;
					this.termList  = res.termList;			
					
					this.qry.termid = "${INFO.termid}";
					this.qry.criteriaid = "${INFO.criteriaid}";
				}

				this.addEntry = function() {
					var saveHandler = function(o) {
						svc.create( o );
						self._controller.reload();
					}
					return new PopupOpener("classrecord:new_activity", {saveHandler: saveHandler});
				}	
				this.editEntry = function() {
					var saveHandler = function(o) {
						self._controller.reload();	
					}
					return new PopupOpener("classrecord:edit_result", {activityid: this.activityid, saveHandler:saveHandler});
				}
				this.changeContext = function() {
					return new DropdownOpener("#classrecord_context");
				}
				this.applyContextChange = function() {
					WindowUtil.loadHash( "classrecord:classrecord", this.qry );
					return "_close";
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div style="display:none" id="classrecord_context">
			Context is :
			Term: <select r:context="classrecord" r:name="qry.termid"  r:items="termList" r:itemLabel="term" r:itemKey="objid"></select><br>
			Activity Type: <select r:context="classrecord" r:name="qry.criteriaid"  r:items="criteriaList" r:itemLabel="title" r:itemKey="objid"></select><br>
			<input type="button" r:context="classrecord" r:name="applyContextChange" value="Apply"/>
		</div>
	</jsp:attribute>	
	
	<jsp:attribute name="actions">
		<label r:context="classrecord">term : #{qry.termid} criteria: #{qry.criteriaid}</label> 
		<input type="button" r:context="classrecord" r:name="addEntry" value="Add Entry" /> 
	</jsp:attribute>
	
	<jsp:body>
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td>Term: </td>
				<td></td>
			</tr>
			<tr>
				<td>Activity Type: </td>
				<td><a r:context="classrecord" r:name="changeContext">Change</a></td>
			</tr>
		</table>
	
		<table class="students" cellpadding="1" cellspacing="0" width="100%" border="1">
			<tr>
				<td width="150" height="120" valign="top" class="title">Students</td>
				<c:forEach items="${INFO.activities}" var="item" varStatus="stat">
					<td align="center" width="60" title="${item.title}" id="${stat.index % 2 == 0 ? 'odd-col' : 'even-col'}">
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
					<td align="center" class="title"  id="${stat.index % 2 == 0 ? 'odd-col' : 'even-col'}">${item.activitydate}</td>
				</c:forEach>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align="right" class="title">Highest Possible Score</td>
				<c:forEach items="${INFO.activities}" var="item" varStatus="stat">
					<td align="center"  id="${stat.index % 2 == 0 ? 'odd-col' : 'even-col'}">${item.totalscore}</td>
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
						<td align="center" id="${student.entries[activityid].scorestate}" title="${student.entries[activityid].remarks}">
							${student.entries[activityid].score}
						</td>
					</c:forEach>
					<td>&nbsp;</td>
				</tr>
			</c:forEach>
		</table>
		
	</jsp:body>
	
</t:content>


