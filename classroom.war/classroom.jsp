<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="common" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="u"%>
<%@ page import="java.util.*" %>



<s:invoke service="ClassroomService" method="getClassInfo" params="${param['classid']}" var="CLASS_INFO"/>
<s:invoke service="ClassroomService" method="getCurrentUserInfo" params="${param['classid']}" var="CLASS_USER_INFO"/>


<t:secured-master>
	<jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/css/classroom.css" type="text/css" rel="stylesheet" />
	</jsp:attribute>
	
	<jsp:attribute name="head">
		<script type="text/javascript">
		
		$register({id: "bulletin", page:"classroom/bulletin.jsp", context:"bulletin"});
		$register({id: "private_messages", page:"classroom/private_messages.jsp", context:"news"});
		$register({id: "usermessage", page:"classroom/usermessage.jsp", context:"usermessage"});
		$register( {id:"invite_student", page:"classroom/invite_student.jsp", context:"invite_student", title:"Invite Students", options: {width:500,height:400} } )
		$register({id: "comment", page:"classroom/comment.jsp", context:"comment", title:"Post a comment", options: {width:400, height:200}});
		$register({id: "subscribe_sms", page:"classroom/subscribe_sms.jsp", context:"subscribe_sms", title:"Subscribe SMS", options: {width:400, height:300}});
		$register({id: "class_welcome", page:"classroom/class_welcome.jsp", context:"class_welcome", title:"Welcome", options: {width:650, height:500}});
		
		$register({id: "classroom:lookup_member", page:"classroom/lookup_member.jsp", 
			context:"lookup_member", title:"Select Class Members", options: {height:500}});
		
		$register({id: "#membermenu", context:"classroom"});
		
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
				this.usersIndex;
				
				this.memberList = {
					fetchList: function(o) {
						self.classInfo = svc.getClassInfo( classid );
						var mbrs = self.classInfo.members;
						self.usersIndex = {}
						for( var i=0;i < mbrs.length;i++) {
							var x = mbrs[i];
							if( x.objid == "${SESSION_INFO.userid}") {
								x.me = true;
							}
							self.usersIndex[x.objid] = x;
						}	
						return self.classInfo.members;
					}
				}
				
				this.onload = function() {
					//redirecto home home.jsp if you do not belong to this class
					if( !'${CLASS_USER_INFO}' ) {
						window.location.href = './home.jsp';
						return;
					}
					
					if(! window.location.hash ) {
						window.location.hash = "bulletin:bulletin";
					}
				
					//if first time to open the class
					<c:if test="${CLASS_USER_INFO.usertype != 'teacher' and (! empty CLASS_INFO.info) and 
						( (! empty CLASS_INFO.info.syllabus) || (! empty CLASS_INFO.info.welcome_message)  ) }">
						<c:if test="${CLASS_USER_INFO.state != 'ACTIVE'}">;	
							var op = new PopupOpener('class_welcome',{
								classid: "${param['classid']}",
								classinfo: <u:tojson value="${CLASS_INFO.info}"/>,
								userid: "${SESSION_INFO.userid}"
							})
							self._controller.navigate(op);
						</c:if>
					</c:if>
					
					Session.handlers.classroom = function(o) {
						if(o.classroom && o.classroom == classid ) {
							self.memberList.refresh(true);
						}
					}
				}
				
				this.inviteStudents = function() {
					return new PopupOpener("invite_student");
				}

				this.showMemberMenu = function() {
					return new DropdownOpener("#membermenu", null, {position: 'bottom-right'});
				}
				
				//called by dropdown opener
				this.selectedMember;
				this.removeMember = function() {
					if(this.selectedMember) {
						if(confirm("You are about to remove " + this.selectedMember.lastname + "," + this.selectedMember.firstname + " from this class. Continue?") ) {
							svc.removeMember( {userid: this.selectedMember.objid, classid: classid} ); 
						}
					}
					return "_close";
				}
				
				this.findMember = function(id) {
					return this.classInfo.members.find(
						function(t) {
							return (t.objid == id);
						}
					)
				}
				
				this.getName = function( item ) {
					var max = 22;
					var n = item.lastname +', '+ item.firstname;					
					if( n.length > max - 3 ) n = n.substr(0,max-3) + '...';
					return n;
				}
			}
		);
		
		</script>
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
		<div class="left-content">
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

			<table class="menu" r:context="apps" r:items="items" r:varName="item" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td class="icon">
						#{item.icon? '<img src="' + item.icon + '" width="16px"/>' : ''}
					</td>
					<td class="caption">
						<a href="##{item.id}">
							#{item.caption}
						</a>
					</td>
				</tr>
			</table>
			
			<br>
			<div class="hr"></div>
			<h3>Classroom</h3>
			<c:if test="${CLASS_INFO.usertype == 'teacher'}">
				<input class="button" type="button" r:context="classroom" r:name="inviteStudents" value="Invite Students" />
				<br>
			</c:if>
			<table r:context="classroom" r:model="memberList" r:name="selectedMember"
				r:varStatus="stat" r:varName="item" width="95%" cellpadding="0" cellspacing="0">
				<tbody>
					<tr class="menu">
						<td valign="top" width="16px;">
							<img src="img/#{item.status}.png"/>
						</td>
						<td valign="top">
							<a href="#usermessage?objid=#{item.objid}" class="menuitem" title="#{item.lastname}, #{item.firstname}">
								<span class="capitalize">#{getName(item)}</span>
							</a>
							<br/>
							<span class="caption">#{item.usertype} #{item.me? '<b>(me)</b>' : ''}</span>
						</td>
						<td valign="top" width="3px">
							<c:if test="${CLASS_INFO.usertype == 'teacher'}">
								<a r:context="classroom" r:visibleWhen="#{item.usertype == 'student'}" r:name="showMemberMenu">&#9660;</a>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div id="membermenu" style="display:none;">
				<a r:context="classroom" r:name="removeMember">Remove</a>
			</div>
		</div>
	</jsp:body>
	
</t:secured-master>