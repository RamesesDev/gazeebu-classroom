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
		$register( {id:"invite_student", page:"classroom/invite_student.jsp", context:"invite_student", title:"Invite Students", options: {width:500,height:400} } )
		$register({id: "comment", page:"classroom/comment.jsp", context:"comment", title:"Post a comment", options: {width:400, height:200}});
		$register({id: "subscribe_sms", page:"classroom/subscribe_sms.jsp", context:"subscribe_sms", title:"Subscribe SMS", options: {width:400, height:300}});
		$register({id: "add_award", page:"classroom/add_award.jsp", context:"add_award", title:"Add an Award", options: {width:400, height:300}});
		$register({id: "class_welcome", page:"classroom/class_welcome.jsp", context:"class_welcome", title:"Welcome", options: {width:650, height:500}});
		
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
					
					//get yourself and remove from the list
					var me;
					self.classInfo.members.removeAll(
						function(o) { 
							if( o.objid == "${SESSION_INFO.userid}" ) {
								me = o;
								return true;
							}
							return false;
						}
					);
					
					//if first time to open the class
					if( me.state != 'ACTIVE' && me.usertype != 'teacher' ) {
						var cinfo = ProxyService.lookup('ClassService').read({objid: classid});
						
						//show welcome message or syllabus if specified
						var info = cinfo && cinfo.info;
						if( info && (info.syllabus || info.welcome_message) ) {
							var op = new PopupOpener('class_welcome',{
								classid: "${param['classid']}",
								classinfo: cinfo,
								userid: me.objid
							})
							self._controller.navigate(op);
						}
						else {
							svc.activateMembership( classid, me.objid );
						}
					}
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
				
				this.inviteStudents = function() {
					return new PopupOpener("invite_student");
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="style">
		.menuitem td {
			padding-left:5px;
		}
		.menuitem {
			font-color: 
		}
	</jsp:attribute>
	
	<jsp:attribute name="header_middle">
		<table>
			<tr>
				<td>
					<a style="font-size:14px;" href="#classinfo:classinfo">${CLASS_INFO.name}</a>
				</td>
			</tr>
			<tr>
				<td style="font-size:10px;font-weight:bold;">${CLASS_INFO.schedules}</td>	
			</tr>	
		</table>	
	</jsp:attribute>
	
	<jsp:body>
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<img src="profile/photo.jsp?id=${SESSION_INFO.userid}&t=thumbnail&v=${SESSION_INFO.info.photoversion}"/>
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
				<td><a href="#bulletin">Bulletin</a></td>
			</tr>
			<tr>
				<td><a href="#discussion">Discussion</a></td>
			</tr>
			<tr>	
				<td><a href="#private_messages">Messages</a></td>
			</tr>
		</table>
		
		<div class="menutitle">
			CLASS
		</div>
		<table class="menuitem" r:context="apps" r:items="items" r:varName="item" width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td valign="top">
					<a href="##{item.id}">
						#{item.caption}
					</a>
				</td>
			</tr>
		</table>
		
		<c:if test="${CLASS_INFO.usertype == 'teacher'}">
			<br>
			<input class="button" type="button" r:context="classroom" r:name="inviteStudents" value="Invite Students" />
		</c:if>
		
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