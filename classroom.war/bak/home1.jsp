<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="common" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<c:if test="${empty param['classid'] and !empty SESSIONID}">
	<s:invoke service="ClassService" method="getDefaultClassId" var="CLASS_ID"/>
	<c:if test="${!empty CLASS_ID}">
		<c:set var="REDIRECT" value="home.jsp?classid=${CLASS_ID}#bulletin:bulletin" scope="request"/>
	</c:if>
	<c:if test="${empty CLASS_ID}">
		<c:set var="REDIRECT" value="home.jsp?classid=none#bulletin:bulletin"  scope="request"/>
	</c:if>
	<%response.sendRedirect( (String)request.getAttribute("REDIRECT") );%>
</c:if>

<t:secured>

	<jsp:attribute name="before_rendering">
		<c:if test="${param['classid']!='none'}">
			<s:invoke service="ClassService" method="getOpenClasses" params="${SESSION_INFO.userid}" var="OPEN_CLASSES"/>
			<c:if test="${! empty param['classid']}">
				<s:invoke service="ClassService" method="getClassInfo" params="${param['classid']}" var="CLASS_INFO"/>
			</c:if>
		</c:if>
	</jsp:attribute>
	
	<jsp:attribute name="head">
		<link rel="stylesheet" href="css/home.css" type="text/css" />
		<common:loadinvokers/>	
		<script>
			alert('load session ');
			alert($.cookie('sessionid'));
			var Session = new Notifier();
			Session.connect( $.cookie('session') );
			
			$put("classroom",
				new function() {
					var classSvc = ProxyService.lookup("ClassService");
					var self = this;
					this._controller;
					
					this.createClass = function() {
						var saveHandler = function(id) {
							WindowUtil.reload( {classid:id}, "bulletin:bulletin" );
						}
						return new PopupOpener("class:class_new", {handler: saveHandler} );
					}
					<c:if test="${!empty CLASS_INFO}">	
						this.onload = function() {
							Session.handlers.classroom = function(o) {
								if( o.msgtype == "online" || o.msgtype == "offline" ) {
									if(o.usertype=="student") {
										var student = self.studentList.find( function(x) { return x.objid == o.userid } );
										if(student) {
											student.status = o.msgtype;
										}
									}
									else if( o.usertype == "teacher" ) {
										self.teacher.status = o.msgtype;
									}
									self._controller.refresh();
								}	
								else if(o.msgtype == "addStudent") {
									self.studentList = classSvc.getStudents("${param['classid']}");
									self._controller.refresh();
								}
							}
							this.teacher = {
								objid: "${CLASS_INFO.teacher.objid}",
								firstname: "${CLASS_INFO.teacher.firstname}",
								lastname: "${CLASS_INFO.teacher.lastname}",
								status: "${CLASS_INFO.teacher.status}"
							}
							this.studentList = classSvc.getStudents("${param['classid']}");
						}
					</c:if>	
				}
			);	
		</script>
	</jsp:attribute>
	
	<jsp:attribute name="header_middle">
		<div style="color:white;font-weight:bolder;">
			<c:if test="${! empty CLASS_INFO}">
				<div>${CLASS_INFO.name}</div>
				<div style="font-size:10px;">${CLASS_INFO.classurl}</div>
			</c:if>
			<c:if test="${empty CLASS_INFO}">
				No active class
			</c:if>
		</div>
	</jsp:attribute>
	
	<jsp:attribute name="profile">
		<table cellspacing="0" cellspacing="0">
			<tr>
				<td rowspan="2" valign="top"><img src="img/profilephoto.png"/></td>
				<td style="padding-left:2px;font-size:11px;">
					${SESSION_INFO.lastname}, ${SESSION_INFO.firstname}
				</td>
			</tr>	
			<tr>
				<td>
					<a href="profile.jsp" style="font-size:10px;text-decoration:none;">Edit Profile</a>
				</td>
			</tr>
		</table>
	</jsp:attribute>
	
	<jsp:attribute name="taskmenu">
		<br>
		<table width="100%" cellpadding="0" cellspacing="0" class="menu">
			<tr>
				<td class="menutitle">Tasks</td>
			</tr>
			<c:forEach items="${TASKLIST}" var="item">
				<c:if test="${item.type=='home:menu'}">
					<tr>
						<td class="menuitem">
							<a class="task" href="#${item.id}">${item.caption}</a>
						</td>
					</tr>
				</c:if>
			</c:forEach>
			<tr>
				<td class="menudivider">&nbsp;</td>
			</tr>
		
			<tr>
				<td	class="menutitle">Classes</td>
			</tr>
			<c:forEach items="${OPEN_CLASSES}" var="item">
				<tr>
					<td class="menuitem" id="${item.objid == param['classid'] ? 'selected' : 'unselected'}">
						<a href="?classid=${item.objid}#bulletin:bulletin">
							${item.name} ${item.objid == param['classid'] ? ' *' : ''}
						</a>
					</td>	
				</tr>
			</c:forEach>

			<c:if test="${SESSION_INFO.usertype=='teacher'}">
				<tr>
					<td>
						<a context="classroom" name="createClass" class="addclass" style="font-size:11px;">Add New Class</a>
					</td>
				</tr>
			</c:if>
			
			<tr>
				<td class="menudivider">&nbsp;</td>
			</tr>
			<c:if test="${SESSION_INFO.usertype=='student'}">	
				<tr>
					<td class="menutitle">Teacher</td>
				</tr>
				<tr>
					<td valign=center">
						<label context="classroom">
							<img src="img/#{teacher.status}.png"/>
							<a class="people">#{teacher.lastname},#{teacher.firstname}</a>
						</label>
					</td>
				</tr>
				<tr>
					<td class="menudivider">&nbsp;</td>
				</tr>
			</c:if>
			
			<c:if test="${(! empty CLASS_INFO) and (SESSION_INFO.usertype=='student' or SESSION_INFO.usertype=='teacher')}">	
				<tr>
					<td class="menutitle">${SESSION_INFO.usertype=='teacher' ? 'Students' : 'Classmates'}</td>
				</tr>
				<tr>
					<td valign="top" style="padding-top:5px;">
						<table context="classroom" items="studentList" width="100%" cellpadding="0" cellspacing="0" varName="item">
							<tbody>
								<tr>
									<td valign="top">
										<img src="img/#{item.status}.png"/>
										<a class="people" href="#student:student_info?objid=#{item.objid}" class="menuitem">
											#{item.lastname}, #{item.firstname}
										</a>
									</td>
								</tr>
							</tbody>
						</table>	
					</td>
				</tr>
			</c:if>
		</table>
		
	</jsp:attribute>
</t:secured>
