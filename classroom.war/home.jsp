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
		$register({id: "new_class", page:"new_class.jsp", context:"new_class", title:"New Classroom", options: {width:500,height:400}});
		$put("home", 
			new function() {
				this.onload = function() {
					if(! window.location.hash ) {
						window.location.hash = "main";
					}							
				}
				this.addClass = function() {
					return new PopupOpener( "new_class" );
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
		<br><br>
		<br/>
		<c:if test="${fn:contains(SESSION_INFO.roles,'student')}">
			
		</c:if>	
		
		<c:if test="${fn:contains(SESSION_INFO.roles,'teacher')}">
			<button class="button">
				<div><a r:context="home" r:name="addClass">Add New Class</a></div>
			</button>
			<br>
			<button class="button">
				<div><a href="">Invite Students</a></div>
			</button>
			<button class="button">
				<div><a href="">Invite Parents</a></div>
			</button>
		</c:if>
		
		<c:if test="${fn:contains(SESSION_INFO.roles,'teacher')}">
			<button class="button">
				<div><a href="">Join Class</a></div>
			</button>
		</c:if>
		
	</jsp:body>
</t:secured-master>