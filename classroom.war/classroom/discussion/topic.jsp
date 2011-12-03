<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/message" prefix="msg" %>
<%@ page import="java.util.*" %>

<s:invoke service="MessageService" method="getMessage" params="${param['objid']}" var="TOPIC"/>

<t:content rightpanelwidth="40%" title="${TOPIC.subject}">
	
	<jsp:attribute name="head">
		<script src="${pageContext.request.contextPath}/js/ext/MessageServiceClient.js"></script>
	</jsp:attribute>

	<jsp:attribute name="contenthead">
		<a href="#discussion:thread?objid=${TOPIC.threadid}" style="font-size:9px;color:blue;"><< Back</a><br>
	</jsp:attribute>
	
	<jsp:attribute name="subtitle">
		<a style="font-size:11px;color:black;text-transform:none;">Posted on ${TOPIC.dtposted}</a>
	</jsp:attribute>

	<jsp:attribute name="script">
		$put("topic_info", 	
			new function() 
			{
				var self = this;
				this.objid = "${param['objid']}";
				this.users;
				
				var client;
				this.memberList;
				this.commentList;
				this.message;

				this.onload = function() {
					client = new MessageServiceClient("topic");
					client.parentid = this.objid;
					client.init();
					this.memberList = client.subscriberList;
					this.commentList = client.commentList;
					this.users = $ctx('classroom').usersIndex;
				}
				
				this.post = function() {
					client.respond(this.objid, {message: this.message});
					this.message = '';
				}
				
				this.addAttachment = function() {
					var h = function() {
						self.resourceList.refresh(true);
					};
					var p = {parentid: this.objid, handler: h};
					if( this.users['${SESSION_INFO.userid}'].usertype != 'teacher' ) {
						p.subscribers = this.memberList.getList();
						p.senderid = '${TOPIC.userid}';
					}
					
					return new PopupOpener("common:add_attachment", p);
				}
				
				this.viewEmbed = function() {
					var h = function() {
						return self.selectedResource.embedcode;
					};
					
					return new PopupOpener("view_embed", {handler:h});
				}
				
				var attachSvc = ProxyService.lookup("AttachmentService");
				this.selectedResource;
				this.resourceList = {
					fetchList: function() {
						return attachSvc.getAttachments({refid: self.objid});
					},
					removeItem: function() {
						if( !this.getSelectedItem() ) return;
						if( !confirm('Are you sure you want to remove this item?') ) return;
						attachSvc.removeAttachment({objid: this.getSelectedItem().objid});
						this.refresh(true);
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
					<div>${TOPIC.message}</div> 	
					<br>
					<div class="section-label">Participants</div>
					<table r:context="topic_info" r:model="memberList" r:varName="item" width="100%">
						<tr>
							<td width="10px">
								<img src="${pageContext.servletContext.contextPath}/profile/photo.jsp?id=#{item.userid}&t=thumbnail&v=#{users[item.userid].info.photoversion}" width="30px"/>
							</td>
							<td style="padding-left:10px" class="capitalized">
								#{users[item.userid].lastname}, #{users[item.userid].firstname}
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="hr"></div>
							</td>
						</tr>
					</table>
					
					<div class="section-label">
						<table width="100%">
							<tr>
								<td >Attachments</td>
								<td align="right" style="padding-right:4px;">
									<a r:context="topic_info" r:name="addAttachment">Add</a>
								</td>
							</tr>
						</table>
					</div>

					<table class="message" width="100%" r:context="topic_info" r:model="resourceList" r:varName="item" r:varStatus="stat" r:name="selectedResource">
						<tr>
							<td rowspan="2" valign="top" width="1px" style="padding-right: 10px;">
								<img src="profile/photo.jsp?id=#{item.userid}&t=thumbnail&v=#{users[item.userid].info.photoversion}}" width="${!empty picSize ? picSize : '40px'}"/>
							</td>
							<td style="font-weight:bold;color:darkslateblue;">
								#{item.subject}
							</td>
							<td align="right">
								<a class="remove" r:context="topic_info" r:name="resourceList.removeItem" r:visibleWhen="#{item.userid == '${SESSION_INFO.userid}'}">
									x
								</a>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div style="font-size:11px;color:gray;font-weight:normal;">
									#{item.message}
									<br/>
									#{users[item.userid].lastname}, #{users[item.userid].firstname} - Posted #{item.dtposted}
								</div>
								<div r:context="topic_info" 
								     r:visibleWhen="#{item.userid == '${SESSION_INFO.userid}' || users[item.userid].usertype == 'teacher' || users['${SESSION_INFO.userid}'].usertype == 'teacher'}">
									<span r:context="topic_info" r:visibleWhen="#{item.reftype == 'link'}">
										<a href="#{item.linkref}" target="_blank">View</a>
									</span>
									<span r:context="topic_info" r:visibleWhen="#{item.reftype == 'embed'}">
										<a r:context="topic_info" r:name="viewEmbed">View</a>
									</span>
									<span r:context="topic_info" r:visibleWhen="#{item.reftype == 'library'}">
										<span r:context="topic_info" r:visibleWhen="#{item.libtype == 'doc'}">
											<a href="library/viewres.jsp?id=#{item.linkref}&ct=#{item.content_type}" target="_blank">
												View
											</a>
										</span>
										&nbsp;
										<span r:context="topic_info" r:visibleWhen="#{item.libtype == 'doc'}">
											<a href="library/downloadres.jsp?id=#{item.linkref}&ct=#{item.content_type}" target="_blank">
												Download
											</a>
										</span>
										<span class="photo" r:context="topic_info" r:visibleWhen="#{item.libtype == 'picture'}">
											<a href="library/viewres.jsp?id=#{item.linkref}&ct=#{item.content_type}" target="_blank">
												<img src="library/viewres.jsp?id=#{item.linkref}&ct=#{item.content_type}" height="20px" />
											</a>
										</span>
									</span>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3"><div class="hr"></div></td>
						</tr>
					</table>
					
				</td>
				<td colspan="2" valign="top" width="50%" style="border-left:1px solid gray;padding-left:10px;">
					<div style="width:95%">
						<msg:post context="topic_info" name="message" action="post"/>
						<br/>
						<msg:comments context="topic_info" commentList="commentList" usersMap="users"/>
					</div>
				</td>
			</tr>
		</table>
	</jsp:body>
	
</t:content>


	