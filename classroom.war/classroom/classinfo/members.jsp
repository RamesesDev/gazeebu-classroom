<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="common" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<s:invoke service="ClassroomService" method="getClassInfo" params="${param['classid']}" var="CLASS_INFO"/>

<t:content title="Class Members">
	
	<jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/css/connections.css?v=${APP_VERSION}" type="text/css" rel="stylesheet" />
		<link href="${pageContext.servletContext.contextPath}/js/ext/richtext/richtext.css?v=${APP_VERSION}" rel="stylesheet" />
		<script src="${pageContext.servletContext.contextPath}/js/ext/richtext/richtext.js?v=${APP_VERSION}"></script>
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put(
			"members", 
			new function() 
			{
				var svc = ProxyService.lookup("MessageService");
				
				var self = this;
				var classid = '${param.classid}';
				var classInfo;
				
				this.me;
				this.selected;
				
				this.onload = function() {
					classInfo = $ctx('classroom').classInfo;
					this.me = $ctx('classroom').usersIndex["${SESSION_INFO.userid}"];
				}
				
				this.members = {
					fetchList: function(o) {
						return classInfo.members.findAll(function(it){ return it.objid != '${SESSION_INFO.userid}' });
					}
				}
				
				this.remove = function() {
					var classroom = $ctx('classroom');
					classroom.selectedMember = this.selected;
					classroom.removeMember();
				}
				
				this.sendmsg = function() 
				{
					var handler = function(txtmsg)
					{
						if(!txtmsg || !txtmsg.trim()) 
							throw new Error("Please provide a message" );

						var msg = {
							message     : txtmsg,
							subscribers : [{userid: self.selected.objid}],
							privacy     : 2,
							msgtype     : 'private',
							channelid   : '${param.classid}'
						};
						
						svc.send( msg );
					};
					
					return new PopupOpener('common:post_message', {handler: handler}, {title: 'Send Message'});
				}
			}
		);
	</jsp:attribute>
	
	<jsp:body>
		<table r:context="members" r:model="members" r:name="selected" r:varName="item" width="100%" cellspacing="0" class="connections">
			<tr>
				<td width="100" valign="top">
					<div class="thumb">
						<a href="#common:usermessage?objid=#{item.objid}">
							<img src="profile/photo.jsp?id=#{item.objid}&t=medium&v=${item.info.photoversion}" width="80"/>
						</a>
					</div>
				</td>
				<td valign="top" width="200">
					<div class="name capitalized">
						<a href="#common:usermessage?objid=#{item.objid}">
							#{item.lastname}, #{item.firstname}
						</a>
					</div>
					<div class="details">
						#{item.username}
					</div>
					<div class="details">
						#{item.roles}
					</div>
				</td>
				<td valign="top">
					<button r:context="members" r:name="sendmsg">Send Message</button>
					<c:if test="${CLASS_INFO.usertype == 'teacher'}">
						<button r:context="members" r:name="remove" r:visibleWhen="">Remove</button>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<div class="hr"></div>
				</td>
			</tr>
		</table>
	</jsp:body>
</t:content>