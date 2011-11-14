<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="common" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<s:invoke service="ClassroomService" method="getClassInfo" params="${param['classid']}" var="CLASS_INFO"/>
<t:secured-master>
	<jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/css/classroom.css" type="text/css" rel="stylesheet" />
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$register({id: "bulletin", page:"classroom/bulletin.jsp", context:"bulletin"});
		$register({id: "discussion", page:"classroom/discussion.jsp", context:"discussion"});
		$register({id: "private_messages", page:"classroom/private_messages.jsp", context:"news"});
		$register({id: "usermessage", page:"classroom/usermessage.jsp", context:"usermessage"});
		
		<common:loadmodules name="apps" role="${CLASS_INFO.usertype}"/>
		$put("apps", 
			new function() {
				this.items = new Array();
				this.onload = function() {
					this.items = Registry.lookup( "class:menu" );
				}
			}
		);
		
		$put("classroom",
			new function() {
				var svc = ProxyService.lookup("ClassroomService");
				var classid = "${param['classid']}";
				this.classInfo;
				this._controller;
				var self = this;
				
				var loadMembers = function() {
					self.classInfo = svc.getClassInfo( classid );
					//remove yourself from the list
					self.classInfo.members.removeAll(
						function(o) { return o.objid == "${SESSION_INFO.userid}" }
					);
				}
				
				this.onload = function() {
					if(! window.location.hash ) {
						window.location.hash = "bulletin";
					}
				
					loadMembers();
					if(classid) {
						Session.handlers.classroom = function(o) {
							if(o.classroom && o.classroom == classid ) {
								loadMembers();
								self._controller.refresh();
							}
						}
					}
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="header_middle">
		<table>
			<tr>
				<td>
					<a style="font-size:14px;" href="#classinfo:classinfo">${CLASS_INFO.name}</a>
				</td>
			</tr>
			<tr>
				<td style="font-size:10px;font-weight:bold;">${CLASS_INFO.description}</td>	
			</tr>	
		</table>	
	</jsp:attribute>
	
	<jsp:body>
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<c:if test="${empty SESSION_INFO.profile}"><img src="blank.jpg"/></c:if>
					<c:if test="${!empty SESSION_INFO.profile}"><img src="${SESSION_INFO.profile}/thumbnail.jpg"/></c:if>
				</td>
				<td style="font-size:11px;padding-left:5px;">
					${SESSION_INFO.lastname}, ${SESSION_INFO.firstname}<br>
					<b>${CLASS_INFO.usertype}</b>
				</td>
			</tr>
		</table>
		<br>	
		
		<div class="menutitle">
			FEEDS
		</div>
		<table class="menuitem" width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td style="padding-left:5px;"><a href="#bulletin">Bulletin</a></td>
			</tr>
			<tr>
				<td style="padding-left:5px;"><a href="#discussion">Discussion</a></td>
			</tr>
			<tr>	
				<td style="padding-left:5px;"><a href="#private_messages">Messages</a></td>
			</tr>
		</table>
		
		
		
		<div class="menutitle">
			CLASSROOM
		</div>
		<table class="menuitem" r:context="apps" r:items="items" r:varName="item" width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td valign="top"  style="padding-left:5px;">
					<a href="##{item.id}" class="menuitem">
						#{item.caption}
					</a>
				</td>
			</tr>
		</table>
		
		<br>
		<table r:context="classroom" r:items="classInfo.members" r:varStatus="stat" r:varName="item" width="95%" cellpadding="0" cellspacing="0">
			<tbody>
				<tr r:visibleWhen="#{item.usertype == 'teacher' && stat.prevItem.usertype!='teacher'}" >
					<td class="menutitle" style="padding-top:10px;">TEACHER</td>
				</tr>
				<tr r:visibleWhen="#{item.usertype == 'student'  && stat.prevItem.usertype!='student'}" >
					<td class="menutitle" style="padding-top:10px;">${CLASS_INFO.usertype=='teacher' ? 'STUDENTS' : 'CLASSMATES'}</td>
				</tr>
				<tr class="menuitem">
					<td valign="top">
						<img src="img/#{item.status}.png"/>
						<a href="#usermessage?objid=#{item.objid}" class="menuitem">
							#{item.lastname}, #{item.firstname}
						</a>
					</td>
					
				</tr>
			</tbody>
		</table>
		
		
	</jsp:body>
	
</t:secured-master>