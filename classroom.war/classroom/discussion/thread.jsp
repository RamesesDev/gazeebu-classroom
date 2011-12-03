<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/message" prefix="msg" %>
<%@ page import="java.util.*" %>

<%
	Map m = new HashMap();
	m.put("objid", request.getParameter("objid") );
	request.setAttribute( "params", m );
%>

<s:invoke service="DiscussionService" method="openThread" params="${params}" var="THREAD"/>

<t:content rightpanelwidth="40%" title="${THREAD.subject}">
	
	<jsp:attribute name="head">
		<link href="${pageContext.request.contextPath}/js/ext/lightbox/jquery.lightbox.css" rel="stylesheet"/>
		<script src="${pageContext.request.contextPath}/js/ext/MessageServiceClient.js"></script>
		<script src="${pageContext.request.contextPath}/js/ext/lightbox/jquery.lightbox.js"></script>
	</jsp:attribute>

	<jsp:attribute name="contenthead">
		<a href="#discussion:discussion" style="font-size:9px;color:blue;"><< Back</a><br>
	</jsp:attribute>
	
	<jsp:attribute name="subtitle">
		<a style="font-size:11px;color:black;text-transform:none;">Posted on ${THREAD.dtposted}</a>
	</jsp:attribute>

	<jsp:attribute name="script">
		$register({id:"view_embed", context:"view_embed", page: "library/view_embed.jsp", title:"Embeded Attachment", options:{width:600,height:500}});
		
		$put("thread", 	
			new function() 
			{
				var self = this;
				this.objid;
				var svc = ProxyService.lookup("DiscussionService");
				this.classid = "${param['classid']}";
				
				var client;
				this.listModel;
				this.selectedTopic;
				this.users;

				this.onload = function() {
					client = new MessageServiceClient("topic", this.classid, this.objid);
					client.init();
					this.listModel = client.messageList;
					this.users = $ctx('classroom').usersIndex;
					
					setTimeout( function(){ $('.photo a').lightBox({fixedNavigation:true}); }, 100 );
				}
				
				this.addTopic = function() {
					var f = function(o) {
						client.post( o );
					}
					var o = new PopupOpener( "common:message_form", {saveHandler: f});
					o.title = "New Topic";
					return o;
				}
				
				this.removeTopic = function() {
					client.removeMessage(this.selectedTopic.objid);
				}
				
				this.editThread = function() {
					alert('editing ' + this.selectedTopic.objid);
				}
				
				this.addAttachment = function() {
					var h = function() {
						self.resourceList.refresh(true);
					};
					var p = {parentid: this.objid, handler: h};
					if( '${THREAD.userid}' != '${SESSION_INFO.userid}' )
						p.senderid = '${THREAD.userid}';
					
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
 	</jsp:attribute>


	<jsp:body>
		<table width="100%" cellpadding="2" cellspacing="1">
			<tr>
				<td valign="top" align="left" style="padding-right:10px;">
				
					<div  class="section-label">Description</div>
					<div>${THREAD.description}</div> 	
					<br>
					<div class="section-label">
						<table width="100%">
							<tr>
								<td >Attachments</td>
								<td align="right" style="padding-right:4px;">
									<a r:context="thread" r:name="addAttachment" r:visibleWhen="#{users['${SESSION_INFO.userid}'].usertype == 'teacher'}">
										Add
									</a>
								</td>
							</tr>
						</table>
					</div>
					
					<div>
						<table class="message" width="100%" r:context="thread" r:model="resourceList" r:varName="item" r:varStatus="stat" r:name="selectedResource">
							<tr>
								<td rowspan="2" valign="top" width="1px" style="padding-right: 10px;">
									<img src="profile/photo.jsp?id=#{item.userid}&t=thumbnail&v=#{users[item.userid].info.photoversion}}" width="${!empty picSize ? picSize : '40px'}"/>
								</td>
								<td style="font-weight:bold;color:darkslateblue;">
									#{item.subject}
								</td>
								<td align="right">
									<a class="remove" r:context="thread" r:name="resourceList.removeItem" r:visibleWhen="#{item.userid == '${SESSION_INFO.userid}'}">
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
									<div>
										<span r:context="thread" r:visibleWhen="#{item.reftype == 'link'}">
											<a href="#{item.linkref}" target="_blank">View</a>
										</span>
										<span r:context="thread" r:visibleWhen="#{item.reftype == 'embed'}">
											<a r:context="thread" r:name="viewEmbed">View</a>
										</span>
										<span r:context="thread" r:visibleWhen="#{item.reftype == 'library'}">
											<span r:context="thread" r:visibleWhen="#{item.libtype == 'doc'}">
												<a href="library/viewres.jsp?id=#{item.linkref}&ct=#{item.content_type}" target="_blank">
													View
												</a>
											</span>
											&nbsp;
											<span r:context="thread" r:visibleWhen="#{item.libtype == 'doc'}">
												<a href="library/downloadres.jsp?id=#{item.linkref}&ct=#{item.content_type}" target="_blank">
													Download
												</a>
											</span>
											<span class="photo" r:context="thread" r:visibleWhen="#{item.libtype == 'picture'}">
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
					</div>
					
				</td>
				
				<td colspan="2" valign="top" width="50%" style="border-left:1px solid gray;padding-left:10px;">
					<div class="section-label">
						Topics 
						&nbsp;&nbsp;
						<a r:context="thread" r:name="addTopic"  r:visibleWhen="#{users['${SESSION_INFO.userid}'].usertype == 'teacher'}">
							New Topic
						</a>
					</div>
					<br>

					<table width="98%" r:context="thread" r:model="listModel" r:varName="item" r:varStatus="stat"
						   r:emptyText="No topic posted yet" cellspacing="0" r:name="selectedTopic"
						   class="message" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td valign="top" align="center" rowspan="2">
									<img src="profile/photo.jsp?id=#{item.userid}&t=thumbnail&v=#{users[item.userid].info.photoversion}}" width="${!empty picSize ? picSize : '40px'}"/>
								</td>
								<td valign="top" class="subject message-head" style="padding-left:4px;">
									<a href="#discussion:topic?objid=#{item.objid}">#{item.subject}</a>
								</td>
								<td align="right" valign="top" class="message-head" style="padding-right:2px;">
									<a r:context="thread" r:name="removeTopic" r:visibleWhen="#{'${SESSION_INFO.userid}' == item.userid }"
									   title="remove message"  class="remove">
										x
									</a>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div style="font-size:11px;color:gray;font-weight:normal;">
										#{users[item.userid].lastname}, #{users[item.userid].firstname}
										<br/>
										Posted #{item.dtposted}
									</div>
								</td>
							</t>
							<tr>
								<td colspan="3">
									<div class="message-hr"></div>
									<br/>
								</td>
							</tr>
						</tbody>
					</table>
					<a r:context="thread" r:name="listModel.fetchNext" r:visibleWhen="#{listModel.isEOF()=='false'}">View More</a>
					
				</td>
			</tr>
		</table>
	</jsp:body>
	
</t:content>


	