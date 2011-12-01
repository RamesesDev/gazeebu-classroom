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
<s:invoke service="DiscussionService" method="openThread" params="${params}" var="DISCUSSION"/>

<t:content rightpanelwidth="40%" title="${DISCUSSION.subject}">

	<jsp:attribute name="contenthead">
		<a href="#discussion:discussion" style="font-size:9px;color:blue;"><< Back</a><br>
	</jsp:attribute>
	
	<jsp:attribute name="subtitle">
		<a style="font-size:11px;color:black;text-transform:none;">Posted on ${DISCUSSION.dtposted}</a>
	</jsp:attribute>

	<jsp:attribute name="script">
		$register( {id:"new_topic", context:"new_topic", page:"apps/discussion/new_topic.jsp", title:"New Topic", options: {width:500,height:500}} );
		$put("thread", 	
			new function() {
				var self = this;
				this.objid;
				var svc = ProxyService.lookup("DiscussionService");
				this.users;

				this.onload = function() {
					this.users = $ctx('classroom').usersIndex;
				}				
				this.topicList = {
					fetchList: function(o) {	
						var m = {parentid: self.objid};
						return svc.getTopics( m );
					}
				}
				this.selectedTopic;
				this.addTopic = function() {
					var f = function(o) {
						svc.addTopic( o );
						self.topicList.refresh(true); 
					}
					return new PopupOpener( "new_topic", {saveHandler: f, parentid: this.objid });
				}
				
				this.editThread = function() {
					alert('editing ' + this.selectedTopic.objid);
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
					<div>${DISCUSSION.description}</div> 	
					<br>
					<div class="section-label">
						<table width="100%">
							<tr>
								<td >References</td>
								<td align="right" style="padding-right:4px;">
									<a href="">Add</a>
								</td>
							</tr>
						</table>
					</div>
					<div>
						<table>
							<c:forEach items="${DISCUSSION.resources}" var="item" varStatus="status">
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
					<div class="section-label">
						Topics 
						&nbsp;&nbsp;
						<a r:context="thread" r:name="addTopic" >New Topic</a>
					</div>
					<br>
					
					<table r:context="thread" r:model="topicList" r:varName="item" r:name="selectedTopic" width="100%">
						<tr>
							<td valign="top" style="border-top:1px solid lightgrey;padding-top:4px;" rowspan="2"> 
								<img width="30px" src="profile/photo.jsp?id=#{item.userid}&t=thumbnail&v=#{users[item.userid].info.photoversion}">
							</td>
							<td width="90%" valign="top"  style="border-top:1px solid lightgrey;padding-top:4px;">
								<a href="#discussion:topic?objid=#{item.objid}">
									#{item.subject}
								</a>
							</td>
							<td valign="top" width="20"  style="border-top:1px solid lightgrey;padding-top:4px;">
								<a r:context="thread" r:name="editThread" r:visibleWhen="#{item.userid == '${SESSION_INFO.userid}'}">Edit</a>
							</td>
						</tr>
						<tr>
							<td style="color:gray;font-style:italic;">
								posted by #{users[item.userid].lastname},#{users[item.userid].firstname}
							</td>
						</tr>
					</table>
					
				</td>
			</tr>
		</table>
	</jsp:body>
	
</t:content>


	