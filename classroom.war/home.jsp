<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="common" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<t:secured-master>
	<jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/css/home.css" type="text/css" rel="stylesheet" />
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$register({id: "main", page:"home/main.jsp", context:"main"});
		$register({id: "classroom_info", page:"home/classroom_info.jsp", context:"classroom_info"});
		$register({id: "new_class", page:"new_class/new_class.jsp", context:"new_class", title:"New Classroom", options: {width:500,height:400}});
		$register({id: "join_class", page:"join_class.jsp", context:"join_class", title:"Join a class", options: {width:500,height:400}});
		$register({id: "#classmenu", context:"home", options: {position:{at:"right bottom", my:"right top"}} });
		$register({id: "getting_started", page:"home/getting_started.jsp", context:"getting_started", title:"Getting Started with Gazeebu",options:{width:650,height:450}});
		
		$put("home", 
			new function() {
				var svc = ProxyService.lookup("ClassService");
				var self = this;
				
				this.onload = function() {
					if(! window.location.hash ) {
						window.location.hash = "main";
					}

					var userid = '${SESSION_INFO.userid}';
					var hasSet = '${SESSION_INFO.has_set_security}';
					if( hasSet != '1' && !$.cookie(userid) ) {				
						this._controller.navigate( new PopupOpener('getting_started',{userid: userid}) );
					}
					
					//clean cookie if hasSet value is set
					if( hasSet == '1' && $.cookie(userid) ) {
						$.cookie(userid, '');
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
				
				this.selectedClass;
				this.showClassMenu = function() {
					return new DropdownOpener("#classmenu");
				}
				
				this.activateClass = function() {
					alert('activate ' + this.selectedClass.name );
					return "_close";
				}

				this.editClass = function() {
					alert('edit class ' + this.selectedClass.name );
					return "_close";
				}
				
			}
		);
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
	
	<jsp:body>
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<c:if test="${empty SESSION_INFO.profile}"><img src="blank.jpg"/></c:if>
					<c:if test="${!empty SESSION_INFO.profile}"><img src="${SESSION_INFO.profile}/thumbnail.jpg"/></c:if>
				</td>
				<td style="font-size:11px;padding-left:5px;">
					${SESSION_INFO.lastname}, ${SESSION_INFO.firstname}<br>
				</td>
			</tr>
		</table>
		<br>

		

		<br>
		<span class="menutitle">CLASSES</span>
		<br>
		<table cellpadding="0" cellspacing="0">
			<tr>
				<c:if test="${fn:contains(SESSION_INFO.roles,'teacher')}">
					<td>
						<input type="button" r:context="home" r:name="addClass" 
							style="font-size:11px;font-weight:bolder;border:1px solid lightgrey" 
							value="Add"/>
					</td>
				</c:if>
				<c:if test="${fn:contains(SESSION_INFO.roles,'student')}">
					<td>
						<input type="button" r:context="home" r:name="joinClass" 
							style="font-size:11px;font-weight:bolder;border:1px solid lightgrey" 
							value="Join"/>
					</td>		
				</c:if>
			</tr>
		</table>
		

		<table r:context="home" r:model="classListModel" r:varName="item"  r:name="selectedClass" style="padding-top:10px;" cellpadding="0" cellspacing="0"> 
			<tr>
				<td rowspan="3" valign="top" style="padding-right:2px;"><img src="img/star.png"/></td>
				<td><a href="classroom.jsp?classid=#{item.objid}"><b>#{item.name}</b></a></td>
				<td rowspan="3" valign="top">
					<a r:context="home" r:name="showClassMenu" style="text-decoration:none;border:1px solid lightgrey">&#9660;</a>
				</td>
			</tr>	
			<tr>	
				<td style="font-size:10px;">#{item.schedules}</td>
			</tr>
			<tr>	
				<td style="font-size:11px;padding-bottom:10px;"><b>as #{item.usertype}</b></td>
			</tr>
		</table>
		
		<div id="classmenu" style="display:none;">
			<a r:context="home" r:name="activateClass">Activate</a>
			<br>
			<a r:context="home" r:name="editClass">Edit</a>
		</div>
		
	</jsp:body>
</t:secured-master>