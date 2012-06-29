<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="u"%>
<%@ page import="java.util.*" %>



<s:invoke service="ClassroomService" method="getClassInfo" params="${param['classid']}" var="CLASS_INFO"/>
<s:invoke service="ClassroomService" method="getCurrentUserInfo" params="${param['classid']}" var="CLASS_USER_INFO"/>


<t:secured-master>	
	<jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/css/classroom.css?v=${APP_VERSION}" type="text/css" rel="stylesheet" />
		<script src="${pageContext.servletContext.contextPath}/js/ext/textarea.js?v=${APP_VERSION}"></script>
		
		<script type="text/javascript">
			$register({
				id: "classroom:lookup_member", page:"classroom/lookup_member.jsp", 
				context:"lookup_member", title:"Select Class Members", options: {height:500}
			});
			$register({id: "#membermenu", context:"classroom"});
			
			<ui:loadmodules name="classroom" role="${CLASS_INFO.usertype}"/>
			
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
					var self = this;
					this.usersIndex;

					this.onlineMemberList = {
						fetchList: function(o) {
							return self.classInfo.members.findAll(function(o){
								return o.status == 'online';
							});
						}
					}
					
					function loadMembers() {
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
					}
					
					this.inviteStudents = function() {
						return new PopupOpener("common:invite_student");
					}
					
					var memberInfo = new InfoBox('#member-info', '');
					this.selectedMember;
					this.showMemberControls;
					this.showMemberInfo = function(elem,id,options) {
						this.selectedMember = this.findMember(id);
						options = options || {};
						this.showMemberControls = (options.showControls != false);
						memberInfo.offset = options.offset || {x:5};
						memberInfo.show(elem);
					}
					
					//called by dropdown opener
					this.selectedMember;
					this.removeMember = function() {
						if(this.selectedMember) {
							MsgBox.confirm(
							  "You are about to remove <b class='capitalized'>" + this.selectedMember.lastname + ", " + this.selectedMember.firstname + "</b> from this class. Continue?",
							  function() {
								svc.removeMember( {userid: self.selectedMember.objid, classid: classid} );
								location.reload();
							  }
							);
						}
						return "_close";
					}
					
					this.sendMail = function() {}
					this.chatMember = function() {}
					
					this.findMember = function(id) {
						return this.classInfo.members.find(
							function(t) {
								return (t.objid == id);
							}
						)
					}
					
					this.getName = function( item ) {
						var max = item.usertype=='teacher'? 22 : 27;
						var n = item.lastname +', '+ item.firstname;					
						if( n.length > max - 3 ) n = n.substr(0,max-3) + '...';
						return n;
					}
					
					this.subscribeSMS = function() {
						return new PopupOpener( "common:subscribe_sms", {msgtype: "bulletin"}); 
					}
					
					this.sendMail = function() {
						MsgBox.alert('This feature is not yet implemented.');
					}
					
					this.chatMember = function() {
						MsgBox.alert('This feature is not yet implemented.');
					}
					
					this.deactivateClass = function() {
						MsgBox.confirm(
							'Are you sure you want to deactivate this class?',
							function() {
								ProxyService.lookup("ClassService").deactivate(classid);
								self._controller.reload();
							}
						);
					}
					
					this.editClass = function() {
						location.hash = 'classinfo:classinfo';
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
								var op = new PopupOpener('common:class_welcome',{
									classid: "${param['classid']}",
									classinfo: <u:tojson value="${CLASS_INFO.info}"/>,
									userid: "${SESSION_INFO.userid}"
								})
								self._controller.navigate(op);
							</c:if>
						</c:if>
						
						//load the members
						loadMembers();
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
		
		.member-info {
			width: 250px;
			z-index: 999;
		}
		.member-info img {
			margin-right: 10px;
		}
		.member-info span.caption {
			color: #444;
		}
		.teacher { font-weight: bold; }
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
	
	<jsp:attribute name="sections">
		<!-- Class member information -->
		<div id="member-info" class="member-info" style="display:none;">
			<div r:context="classroom" r:type="label"
				   class="clearfix" style="display:block">
				<div class="left thumb" style="width:50px;height:50px;">
					<a href="#common:usermessage?objid=#{selectedMember.objid}">
						<img src="profile/photo.jsp?id=#{selectedMember.objid}&t=thumbnail&v=#{users[selectedMember.objid].info.photoversion}" width="50px"/>
					</a>
				</div>
				<div class="user-info">
					<a href="#common:usermessage?objid=#{selectedMember.objid}">
						<span class="name capitalized"><b>#{selectedMember.lastname}, #{selectedMember.firstname}</b></span>
					</a>
					<br/>
					<span class="caption">
						<b>#{selectedMember.usertype} #{selectedMember.me? '(me)' : ''}</b>
						<br/>
						#{selectedMember.username}
						#{selectedMember.email? '<br/>' + selectedMember.email : ''}
					</span>
				</div>
			</div>
			<div r:context="classroom" r:visibleWhen="#{showMemberControls == true && selectedMember.objid != '${SESSION_INFO.userid}'}">
				<div class="clear"></div>
				<div class="align-r">
					<div class="hr"></div>
					<button r:context="classroom" r:name="sendMail">Email</button>
					<button r:context="classroom" r:name="chatMember">Chat</button>
					<c:if test="${CLASS_INFO.usertype == 'teacher'}">
						<button r:context="classroom" r:name="removeMember">Remove</button>
					</c:if>
				</div>
			</div>
		</div>
	</jsp:attribute>
	
	<jsp:attribute name="sidebar">
		<div class="top-content scrollpane">
			<div class="clearfix">
				<table width="100%">
					<td valign="middle">
						<span class="section-title">Class Profile</span>
					</td>
					<td>
						<c:if test="${CLASS_INFO.usertype == 'teacher'}">
							<span class="right">
								<button r:context="classroom" r:name="editClass">Edit</button>
							</span>
						</c:if>
						<c:if test="${CLASS_INFO.usertype == 'teacher' and CLASS_INFO.status == 1}">
							<div class="right">
								<button r:context="classroom" r:name="inviteStudents">
									Invite Students
								</button>
							</div>
						</c:if>
					</td>
				</table>
			</div>
			<div class="hr"></div>
			<div style="padding-left: 5px;">
				<table>
					<tr>
						<th align="left">Class Name:</th>
						<td>${CLASS_INFO.name}</td>
					</tr>
					<tr>
						<th align="left">Description:</th>
						<td>${CLASS_INFO.description}</td>
					</tr>
					<tr>
						<th align="left">Schedule:</th>
						<td>${CLASS_INFO.schedules}</td>
					</tr>
					<tr>
						<th align="left">School:</th>
						<td>${CLASS_INFO.school}</td>
					</tr>
				</table>
				
				<br/>
				
				<div>
					<c:if test="${not empty CLASS_INFO.info.syllabus}">
						<c:set var="ctxPath" value="${pageContext.servletContext.contextPath}"/>
						<c:set var="RES_PATH" value="${ctxPath}/classroom/classinfo/syllabus_resource.jsp"/>
						<c:set var="syllabus" value="${CLASS_INFO.info.syllabus}"/>
						<img src="${ctxPath}/img/document.png" height="10px"/>
						<a href="${RES_PATH}?t=vw&id=${syllabus.fileid}&fn=${syllabus.filename}&ct=${syllabus.content_type}" target="_blank">
							View Course Syllabus
						</a>
					</c:if>	
				</div>
			</div>
		</div>
		
		<div class="connections">
			<jsp:include page="home/online-connections.jsp"/>
		</div>
	</jsp:attribute>
	
	<jsp:body>
		<div class="left-content">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<a href="#common:usermessage?objid=${SESSION_INFO.userid}">
							<img src="profile/photo.jsp?id=${SESSION_INFO.userid}&t=thumbnail&v=${SESSION_INFO.info.photoversion}"/>
						</a>
					</td>
					<td class="user-info">
						<a href="#common:usermessage?objid=${SESSION_INFO.userid}">
							<span class="name capitalized">${SESSION_INFO.lastname}, ${SESSION_INFO.firstname}</span>
							<br>
							<b>${CLASS_INFO.usertype}</b>
						</a>
					</td>
				</tr>
			</table>
			
			<div class="hr"></div>
			<br/>

			<div r:context="apps" r:visibleWhen="true" style="display:none">
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
			</div>
		</div>
	</jsp:body>
	
</t:secured-master>