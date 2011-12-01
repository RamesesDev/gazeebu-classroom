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
				var svc = ProxyService.lookup("DiscussionService");
				this.objid = "${param['objid']}";
				this.members = [];
				this.classMembers;
				this.users = {};
				
				this.memberList = {
					fetchList: function(o) {
						var m = {};
						m.parentid = self.objid;
						return svc.getTopicMembers(m);
					}
				};
				
				this.onload = function() {
					this.users = $ctx('classroom').usersIndex;
				}
				
				this.selectedReference;
				
				this.referenceList = {
					fetchList: function(o) {	
						var m = {parentid: self.objid};
						return svc.getResources( m );
					}
				}
				
				this.addReference = function() {
					var h = function(o) {
						svc.addResource(o);
						self.referenceList.refresh(true);
					}
					return new PopupOpener("discussion:add_resource", {parentid: this.objid, saveHandler: h });
				}
				
				this.removeReference = function() {
					if( this.selectedResource && confirm("You are about to remove this resource. Continue?")) {
						svc.removeResource( this.selectedResource );
						self.referenceList.refresh(true);
					}
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
					<div class="section-label">Members</div>
					<table r:context="topic_info" r:model="memberList" r:varName="item">
						<tr>
							<td><img src="${pageContext.servletContext.contextPath}/profile/photo.jsp?id=#{item.userid}&t=thumbnail&v=#{users[item.userid].info.photoversion}" width="30px"/></td>
							<td>#{users[item.userid].lastname}, #{users[item.userid].firstname}</td>
						</tr>
					</table>
					
					<div class="section-label">
						<table width="100%">
							<tr>
								<td >References</td>
								<td align="right" style="padding-right:4px;">
									<a r:context="topic_info" r:name="addReference">Add</a>
								</td>
							</tr>
						</table>
					</div>
					
					<div>
						<table width="100%" r:context="topic_info" r:model="referenceList" r:varName="item" r:varStatus="stat" r:name="selectedReference">
							<tr>
								<td rowspan="3" valign="top">
									<img width="30px" src="profile/photo.jsp?id=#{item.userid}&t=thumbnail&v=#{users[item.userid].info.photoversion}">	
								</td>
								<td style="font-weight:bold;color:darkslateblue;">
									#{item.title}
								</td>
								<td align="right" style="padding-right:4px;">
									<a r:context="topic_info" r:name="removeReference" r:visibleWhen="#{item.userid == '${SESSION_INFO.userid}'}">
										Remove
									</a>
								</td>
							</tr>
							<tr>
								<td>#{item.description}</td>
							</tr>
							<tr>
								<td>posted by #{users[item.userid].lastname}, #{users[item.userid].firstname}</td>
							</tr>
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


	