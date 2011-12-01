<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="cui" %>
<%@ page import="java.util.*" %>

<%
	Map m = new HashMap();
	m.put("objid", request.getParameter("objid") );
	request.setAttribute( "params", m );
%>

<s:invoke service="ClassroomService" method="getCurrentUserInfo" params="${param['classid']}" var="CLASS_USER_INFO"/>
<s:invoke service="DiscussionService" method="openTopic" params="${params}" var="TOPIC"/>

<t:content rightpanelwidth="40%" title="${TOPIC.subject}">

	<jsp:attribute name="contenthead">
		<a href="#discussion:thread?objid=${TOPIC.parentid}" style="font-size:9px;color:blue;"><< Back</a><br>
	</jsp:attribute>
	
	<jsp:attribute name="subtitle">
		<a style="font-size:11px;color:black;text-transform:none;">Posted on ${TOPIC.dtposted}</a>
	</jsp:attribute>

	<jsp:attribute name="script">
		$put("topic_info", 	
			new function() {
				var self = this;
				this.objid;
				this.members = [];
				this.classMembers;
				this.users = {};
				
				this.onload = function() {
					this.users = $ctx('classroom').usersIndex;
				}
			}
		);	
 	</jsp:attribute>
	
	<jsp:attribute name="style">
		.section-label {
			font-weight:bold;
			font-size:12px;
			padding : 4px;
			background-color: lightgrey;
		}
		#leftpanel1 {
			display:none;
		}
 	</jsp:attribute>


	<jsp:body>
		<table width="100%" cellpadding="2" cellspacing="1">
			<tr>
				<td valign="top" align="left" style="padding-right:10px;">
				
					<div  class="section-label">Description</div>
					<div>${TOPIC.description}</div> 	
					<br>
					<c:if test="${! empty TOPIC.members}">
					<div class="section-label">Members</div>
						<table r:context="topic_info" r:items="members" r:varName="item">
							<tr>
								<td><img src="${pageContext.servletContext.contextPath}/profile/photo.jsp?id=#{item.objid}&t=thumbnail&v=#{users[item.objid].info.photoversion}" width="30px"/></td>
								<td>#{users[item.objid].lastname}, #{users[item.objid].firstname}</td>
							</tr>
						</table>
					</c:if>
					
					<div class="section-label">References</div>
					<div>
						<table>
							<c:forEach items="${TOPIC.resources}" var="item" varStatus="status">
								<tr>
									<td style="padding-left:10px;">
										<c:if test="${item.type == 'video'}">
											<embed src="${item.link}" height="260" width="350"></embed> 
											<br>
											${status.index+1}. ${item.title}
										</c:if>
										<c:if test="${item.type == 'link'}">
											${status.index+1}. <a href="javascript:window.open('${item.link}');">${item.title}</a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					
				</td>
				<td colspan="2" valign="top" width="50%" style="border-left:1px solid gray;padding-left:10px;">
					<cui:messagelist proxyService="DiscussionService" context="topic" parentid="${param['objid']}" 
					picSize="30px" usersIndex="$ctx('classroom').usersIndex"/>	
				</td>
			</tr>
		</table>
	</jsp:body>
	
</t:content>


	