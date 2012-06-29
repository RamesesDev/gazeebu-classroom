<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<t:secured-master>
	<jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/css/home.css?v=${APP_VERSION}" type="text/css" rel="stylesheet" />
		<link href="${pageContext.servletContext.contextPath}/js/ext/richtext/richtext.css?v=${APP_VERSION}" rel="stylesheet" />
		<script src="${pageContext.servletContext.contextPath}/js/ext/richtext/richtext.js?v=${APP_VERSION}"></script>
	
		<script type="text/javascript">
			$register({id: "main", page:"home/main.jsp", context:"main"});
			$register({id: "classroom_info", page:"home/classroom_info.jsp", context:"classroom_info"});
			$register({id: "new_class", page:"new_class/new_class.jsp", context:"new_class", title:"New Classroom", options: {width:520,height:430}});
			$register({id: "join_class", page:"join_class.jsp", context:"join_class", title:"Join a class", options: {width:500,height:400}});
			$register({id: "getting_started", page:"home/getting_started.jsp", context:"getting_started", title:"Getting Started with Gazeebu",options:{width:650,height:450}});
			$register({id: "changepass", page:"home/changepass.jsp", context:"changepass", title:"Change Password",options:{width:500,height:250}});
			$register({id: "connections", page:"home/connections.jsp", context:"connections", title:"My Connections"});

			$put("home", 
				new function()
				{
					var svc = ProxyService.lookup("ClassService");
					var self = this;
					
					this.onload = function() {
						if(! window.location.hash ) {
							window.location.hash = "main";
						}

						var userid = '${SESSION_INFO.userid}';
						var hasSet = '${SESSION_INFO.has_set_security}';
						if( hasSet != '1' ) {				
							this._controller.navigate( new PopupOpener('getting_started',{userid: userid}) );
						}
						
						var resetPass = '${SESSION_INFO.info.reset_password}';
						if( resetPass ) {
							this._controller.navigate( new PopupOpener('changepass',{entity: {userid: userid}}) );
						}
					}
					
					this.addClass = function() {
						var saveHandler = function() {
							self.classListModel.refresh(true);
						}
						return new PopupOpener( "new_class", {saveHandler: saveHandler } );
					}	
					
					this.joinClass = function() {
						return new PopupOpener( "join_class" );
					}
					
					this.classListModel = {
						fetchList : function(o) {
							return svc.getOpenClasses({})
						}
					}
				}
			);
		</script>
	</jsp:attribute>
	
	<jsp:attribute name="style">
		.button {
			border:1px solid lightgrey;
			width:80%;
		}
		.button div {
			padding:5px;
		}
		.button a {
			text-decoration:none;
			font-size:14px;
			font-weight:bolder;
		}
	</jsp:attribute>
	
	<jsp:attribute name="sidebar">
		<div class="top-content">
			<table width="100%">
				<tr>
					<td><span class="section-title">CLASSESS</span></td>
					<td align="right">
						<c:if test="${fn:contains(SESSION_INFO.roles,'teacher')}">
							<button r:context="home" r:name="addClass">
								Add Class
							</button>
						</c:if>
						<c:if test="${fn:contains(SESSION_INFO.roles,'student')}">
							<button r:context="home" r:name="joinClass">
								Join Class
							</button>
						</c:if>
					</td>
				</tr>
			</table>
			<div class="hr"></div>
			<div class="class-list scrollpane">
				<table r:context="home" r:model="classListModel" r:varName="item"  r:name="selectedClass" style="padding-top:10px;" cellpadding="0" cellspacing="0"> 
					<tbody>	
						<tr>
							<td rowspan="2" valign="top" style="padding-right:2px;"><img src="img/star.png"/></td>
							<td>
								<a href="classroom.jsp?classid=#{item.objid}"><b>#{item.name}</b></a>
								<b>(#{item.usertype})</b>						
							</td>
							<td rowspan="3" valign="top">
								<!--
								<a r:context="home" r:name="showClassMenu" style="text-decoration:none;border:1px solid lightgrey">&#9660;</a>
								-->
							</td>
						</tr>	
						<tr>	
							<td style="font-size:10px;padding-bottom:10px;">#{item.schedules}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="connections">
			<jsp:include page="home/online-connections.jsp"/>
		</div>
		
	</jsp:attribute>
	
	<jsp:body>
		<div r:context="home" r:visibleWhen="true" style="display:none" class="user-info">

			<img src="profile/photo.jsp?id=${SESSION_INFO.userid}&t=medium&v=${SESSION_INFO.info.photoversion}"
				 width="160px"/>
			<div class="capitalized user-name">
				${SESSION_INFO.lastname}, ${SESSION_INFO.firstname}
			</div>
			<div>${SESSION_INFO.email}</div>
			<div>${SESSION_INFO.username}</div>
			<div>${SESSION_INFO.roles}</div>

		</div>
	</jsp:body>
</t:secured-master>