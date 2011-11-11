<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="common" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<t:secured-master>
	<jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/css/home.css" type="text/css" rel="stylesheet" />

		<script>
			$register({id: "main", page:"home/main.jsp", context:"main"});
			$register({id: "news", page:"home/news.jsp", context:"news"});
			$register({id: "inquiries", page:"home/inquiries.jsp", context:"news"});
			$register({id: "private_messages", page:"home/private_messages.jsp", context:"news"});
			$register({id:'student_search', page:'student_search.jsp', context: 'student_search', title:'Search Student'});
			$register({id: "usermessage", page:"home/usermessage.jsp", context:"usermessage"});
			$register({id: "classroom_info", page:"home/classroom_info.jsp", context:"classroom_info"});
			
			$put("home", 
				new function() {
					this.onload = function() {
						if(! window.location.hash ) {
							window.location.hash = "main";
						}							
					}
				}
			);
			$put("classes",
				new function() {
					var svc = ProxyService.lookup( "ClassService" );
					this.classes = [];
					this.classid = "${param['classid']}";
					this.selection;
					this.onload = function() {
						this.classes = svc.getOpenClasses({});
						if(this.classid) {
							var classid = this.classid;
							this.selection = this.classes.find(  function(x) { return x.id == classid  }  ); 
						}
					}	
				}
			);	
			<c:if test="${! empty param['classid']}">
				<common:loadmodules name="apps"/>
				$put("apps", 
					new function() {
						this.items = new Array();
						this.onload = function() {
							this.items = Registry.lookup( "home:menu" );
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
			</c:if>
		</script>
	</jsp:attribute>
	
	<jsp:attribute name="before_rendering">
		<c:if test="${not empty param['classid']}">
			<s:invoke service="ClassroomService" method="getClassInfo" params="${param['classid']}" var="CLASS_INFO"/>
		</c:if>
	</jsp:attribute>
	
	<jsp:attribute name="header_middle">
		<a href="#" onclick="return false">${CLASS_INFO.name}</a>
	</jsp:attribute>
	
	<jsp:body>
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<c:if test="${empty SESSION_INFO.photoversion}">
						<img src="${pageContext.servletContext.contextPath}/img/profilephoto.png"/>
					</c:if>
					<c:if test="${!empty SESSION_INFO.photoversion}">
						<img src="${pageContext.servletContext.contextPath}/${SESSION_INFO.profile}/thumbnail.jpg?v=${SESSION_INFO.photoversion}"/>
					</c:if>
				</td>
				<td style="font-size:11px;padding-left:5px;">
					${SESSION_INFO.lastname}, ${SESSION_INFO.firstname}<br>
					<b>${SESSION_INFO.usertype}</b>
				</td>
			</tr>
		</table>
		
		<br><br>
		<table id="classesmenu" class="menuitem" r:context="classes" r:items="classes" r:varName="item" r:name="selection" width="95%" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<td>
						<a href="home.jsp">Home</a>
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td valign="top" style="padding-left:4px;">
						<a href="?classid=#{item.objid}#news" title="#{item.classurl}">
							#{item.name}
						</a>
					</td>
				</tr>
			</tbody>
		</table>
		
		<c:if test="${! empty param['classid']}">
			<div class="menutitle" r:context="classroom">
				Apps
			</div>
			<table class="menuitem" r:context="apps" r:items="items" r:varName="item" width="100%" cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top">
							<a href="##{item.id}" class="menuitem">
								#{item.caption}
							</a>
						</td>
					</tr>
			</table>
			<table class="menuitem" r:context="classroom" r:items="classInfo.members" r:varStatus="stat" r:varName="item" width="95%" cellpadding="0" cellspacing="0">
				<tbody>
					<tr r:visibleWhen="#{item.membertype == 'teacher' && stat.prevItem.membertype!='teacher'}" >
						<td class="menutitle" style="padding-top:10px;">Teacher</td>
					</tr>
					<tr r:visibleWhen="#{item.membertype == 'student'  && stat.prevItem.membertype!='student'}" >
						<td class="menutitle" style="padding-top:10px;">${SESSION_INFO.usertype=='teacher' ? 'Students' : 'Classmates'}</td>
					</tr>
					<tr>
						<td valign="top">
							<img src="img/#{item.status}.png"/>
							<a href="#usermessage?objid=#{item.objid}" class="menuitem">
								#{item.lastname}, #{item.firstname}
							</a>
						</td>
						
					</tr>
				</tbody>
			</table>
		</c:if>
	</jsp:body>
</t:secured-master>