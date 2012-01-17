<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="ui" %>
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
		<link href="${pageContext.request.contextPath}/js/ext/lightbox/jquery.lightbox.css?v=${APP_VERSION}" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/thread.css?v=${APP_VERSION}" rel="stylesheet"/>
		
		<script src="${pageContext.request.contextPath}/js/ext/MessageServiceClient.js?v=${APP_VERSION}"></script>
		<script src="${pageContext.request.contextPath}/js/ext/lightbox/jquery.lightbox.js?v=${APP_VERSION}"></script>

		<script type="text/javascript">			
			$register({id:"view_embed", context:"view_embed", page: "library/view_embed.jsp", title:"Embeded Attachment", options:{width:600,height:500}});
			$register( {id:"new_thread", context:"new_thread", page:"classroom/discussion/new_thread.jsp", title:"New Discussion Thread", options: {width:500,height:420}} );

			$put(
				"thread", 	
				new function() 
				{
					var self = this;
					var svc = ProxyService.lookup("DiscussionService");
					this.classid = "${param['classid']}";
					
					var client;
					this.selectedTopic=null;
					this.users;

					var onMessageArrived = function(topic) {
						if(topic.msgtype == 'topic' && topic.objid == self.selectedTopic.objid) {
							self.selectedTopic = topic;
							self.viewTopic();
						}
						else if(self.selectedTopic && topic.msgid == self.selectedTopic.objid) {
							refreshMembers();
						}
					}
					
					this.onload = function() {
						client = new MessageServiceClient("topic", this.classid, this.objid, onMessageArrived);
						client.init();
						this.listModel = client.messageList;
						this.commentList = client.createCommentList('comment', 'desc');
						this.questionList = client.createCommentList('question', 'desc');
						this.users = $ctx('classroom').usersIndex;
						
						setTimeout( function(){ $('.photo a').lightBox({fixedNavigation:true}); }, 100 );
					}
					
					//==== thread
					this.editThread = function() {
						var h = function(o) {
							svc.updateThread(o);
							window.location.reload();
						};
						var o = new PopupOpener("new_thread", {saveHandler:h, entry: <ui:tojson value="${THREAD}"/> });
						o.title = "Edit Discussion Thread";
						return o;
					}
					
					this.detailsBtnCaption = 'Show Details';
					this.toggleDetails = function() {
						$('#thread-details').toggle('slide', {direction:'up'});
						this.detailsBtnCaption = (this.detailsBtnCaption=='Show Details'? 'Hide Details' : 'Show Details');
					}
					
					//==== topic
					this.addTopic = function() {
						var f = function(o) {
							client.post( o );
						}
						var o = new PopupOpener( "common:message_form", {saveHandler: f});
						o.title = "New Topic";
						return o;
					}
					
					this.editTopic = function() {
						var f = function(o) {
							client.editPost( o );
						}
						var o = new PopupOpener( "common:message_form", {saveHandler: f,entry:this.selectedTopic});
						o.title = "Edit Topic";
						return o;
					}
					
					this.removeTopic = function() {
						client.removeMessage(this.selectedTopic.objid);
					}
					
					this.viewTopic = function() {
						client.parentid = this.selectedTopic.objid;
						initTabs();
						//this.commentList.load();
						//this.questionList.load();
						_topicAttachmentList = null;
						refreshMembers();
						$('#topic').animate({height: $('#topic')[0].scrollHeight},function(){ $(this).css('height',''); });
						$('#topic-list').animate({height: 0});
					}
					
					var _tabsInit;
					function initTabs() {
						$('#topic-tabs').data('loaded',{});
						if(_tabsInit) return;

						_tabsInit = true;
						$('#topic-tabs').tabs({
							show: function(e,ui) {
								var loaded = $('#topic-tabs').data('loaded');
								if(!loaded[ui.tab]) {
									BindingUtils.bind(null,ui.panel,true);
									loaded[ui.tab] = true;
								}
							}
						});
					}
					
					this.hideTopic = function() {
						client.parentid = null;
						$('#topic-list').animate({height: $('#topic-list')[0].scrollHeight},function(){ $(this).css('height',''); });
						$('#topic').animate({height: 0});
					}
					
					var refreshMembers = function() {
						self.memberList = client.subscriberList.fetchList();
						self._controller.refresh();
					}
					
					//==== attachment
					var attachSvc = ProxyService.lookup("AttachmentService");
					this.selectedAttachment;
					this.attachmentOwner; // thread or topic
					this.attachmentType;  // resource,assignment,etc.
					
					var _attachmentList;
					this.getAttachmentList = function() {
						if( !_attachmentList ) 
							_attachmentList = attachSvc.getAttachments({refid: this.objid});
						
						return _attachmentList;
					}
					
					var _topicAttachmentList;
					this.getTopicAttachmentList = function(type) {
						if( !_topicAttachmentList )
							_topicAttachmentList = attachSvc.getAttachments({refid: this.selectedTopic.objid});
							
						return _topicAttachmentList.findAll(function(o){ return o.type == type });
					}
					
					this.addAttachment = function() {
						var h = function() {
							if(self.attachmentOwner == 'topic')
								_topicAttachmentList = null;
							else
								_attachmentList = null;

							self._controller.refresh('selectedAttachment');
						};
						
						var p = {parentid: this.objid, type: this.attachmentType, handler: h};
						if(this.attachmentOwner == 'topic')
							p.parentid = this.selectedTopic.objid;
						if( '${THREAD.userid}' != '${SESSION_INFO.userid}' )
							p.senderid = '${THREAD.userid}';
						
						return new PopupOpener("common:add_attachment", p);
					}
					
					this.editAttachment = function() {
						var h = function() {
							if(self.attachmentOwner == 'topic')
								_topicAttachmentList = null;
							else
								_attachmentList = null;
							
							self._controller.refresh('selectedAttachment');
						};
						var p = {resource:this.selectedAttachment, handler:h, mode: 'edit'};
						return new PopupOpener("common:add_attachment", p);
					}
					
					this.removeAttachment = function() {
						if( !this.selectedAttachment ) return;
						if( !confirm('Are you sure you want to remove this item?') ) return;
						attachSvc.removeAttachment({objid: this.selectedAttachment.objid});
						
						if(this.attachmentOwner == 'topic')
							_topicAttachmentList = null;
						else
							_attachmentList = null;
						
						this._controller.refresh('selectedAttachment');
					}
					
					var attachmentInfo = new InfoBox('#attachment_info', '', {x: 35});
					this.showAttachmentInfo = function(elem, objid, owner) {
						this.attachmentOwner = owner;
						if(this.attachmentOwner == 'topic')
							this.selectedAttachment = _topicAttachmentList ? _topicAttachmentList.find(function(o){ return o.objid == objid}) : null;
						else
							this.selectedAttachment = _attachmentList ? _attachmentList.find(function(o){ return o.objid == objid}) : null;

						attachmentInfo.show(elem);
					}
					
					this.viewEmbed = function() {
						var h = function() {
							return self.selectedAttachment.embedcode;
						};
						
						return new PopupOpener("view_embed", {handler:h});
					}
					
					this.message;
					this.postComment = function() {
						client.respond(this.selectedTopic.objid, {message: this.message});
						this.message = '';
					}
					
					this.postQuestion = function() {
						client.respond(this.selectedTopic.objid, {message: this.message}, 'question');
						this.message = '';
					}
				}
			);
		</script>
 	</jsp:attribute>
	
	<jsp:attribute name="contenthead">
		<a href="#discussion:discussion" style="font-size:9px;color:blue;"><< Back</a><br>
	</jsp:attribute>
	
	<jsp:attribute name="subtitle">
		<!--
		<a style="font-size:11px;color:black;text-transform:none;">Posted on ${THREAD.dtposted}</a>
		-->
	</jsp:attribute>
	
	<jsp:attribute name="actions">
		<c:if test="${fn:contains(SESSION_INFO.roles,'teacher')}">
			<button r:context="" r:name="" title="Publish to bulletin" 
			        onclick="alert('This feature is not yet implemented.');">
				Publish
			</button>
			<button r:context="thread" r:name="editThread" title="Edit discussion thread">
				Edit
			</button>
		</c:if>
		<span r:context="thread" r:type="label">
			<button r:context="thread" r:name="toggleDetails" title="Show discussion thread details">
				#{detailsBtnCaption}
			</button>
		</span>
	</jsp:attribute>

	<jsp:body>
		<div id="thread-details" class="clearfix" style="display:none">
			<div class="left" style="width:65%">
				${THREAD.description}
			</div>
			<div class="right"  style="width:30%">
				<div style="color:#666">
					Attachments:
					<a r:context="thread" r:name="addAttachment" r:visibleWhen="#{users['${SESSION_INFO.userid}'].usertype == 'teacher'}"
					   r:params="{attachmentOwner:'thread', attachmentType:'resource'}">
						Add
					</a>
				</div>
				<ul r:context="thread" r:items="getAttachmentList()" r:varName="item" r:varStatus="stat" r:name="selectedAttachment"
					   class="message attachments" width="100%">
					<li>
						<span class="subject"
							  onmouseover="$ctx('thread').showAttachmentInfo(this,'#{item.objid}')">
							#{item.subject}
						</span>
					</li>
				</ul>
			</div>
			<div class="clear"></div>
			<br/>
		</div>
		<div id="topic-box">
			<div id="topic-list" class="slide">
				<div class="section-label clearfix">
					<span class="left">
						Topics 
					</span>
					<span class="right">
						<a r:context="thread" r:name="addTopic"  r:visibleWhen="#{users['${SESSION_INFO.userid}'].usertype == 'teacher'}">
							New Topic
						</a>
					</span>
				</div>
				<br/>
				<table width="100%" r:context="thread" r:model="listModel" r:varName="item" r:varStatus="stat"
					   r:emptyText="No topic posted yet" cellspacing="0" r:name="selectedTopic"
					   class="message thread" cellpadding="0" border="0">
					<tr>
						<td>
							<div class="item clearfix #{item.objid == selectedTopic.objid? 'active' : ''}">
								<div class="left thumb"
								     onmouseover="$ctx('classroom').showMemberInfo(this,'#{item.userid}',{showControls:false})">
									<img src="profile/photo.jsp?id=#{item.userid}&t=thumbnail&v=#{users[item.userid].info.photoversion}}" width="40px"/>
								</div>
								<div>
									<div class="clearfix message-head">
										<a r:context="thread" r:name="viewTopic" class="left subject">#{item.subject}</a>
										<span class="right">
											<a r:context="thread" r:name="editTopic" r:visibleWhen="#{'${SESSION_INFO.userid}' == item.userid }"
											   title="remove message"  class="link">
												edit
											</a>
											<a r:context="thread" r:name="removeTopic" r:visibleWhen="#{'${SESSION_INFO.userid}' == item.userid }"
											   title="remove message"  class="remove">
												x
											</a>
										</span>
									</div>
									<div style="font-size:11px;color:gray;font-weight:normal;">
										#{users[item.userid].lastname}, #{users[item.userid].firstname}
										<br/>
										Posted #{item.dtposted}
									</div>
								</div>
							</div>
							<div class="message-hr"></div>
						</td>
					</tr>
				</table>
				<a r:context="thread" r:name="listModel.fetchNext" r:visibleWhen="#{listModel.isEOF()=='false'}">
					View More
				</a>
			</div>
			
			<!-- TOPIC INFO AREA -->
			<div id="topic" class="slide message" style="height:0;">
				<div class="section-label clearfix">
					<span class="left" r:context="thread" r:type="label">
						Topic: 
						&nbsp;&nbsp;
						#{selectedTopic.subject}
					</span>
					<span class="right">
						<a r:context="thread" r:name="hideTopic" title="back to topic list">
							<< back
						</a>
						<span r:context="thread" r:visibleWhen="#{'${SESSION_INFO.userid}' == selectedTopic.userid }">
							<span class="vr"></span>
							<a r:context="thread" r:name="editTopic" title="remove topic">
								edit
							</a>
						</span>
					</span>
				</div>
				
				<p>
					<div class="clearfix">
						<div r:type="label" r:context="thread"
							 class="left" style="width:65%">
							#{selectedTopic.message}
						</div>
						<div class="right"  style="width:30%">
							<div style="color:#666">
								Attachments:
								<a r:context="thread" r:name="addAttachment" r:visibleWhen="#{users['${SESSION_INFO.userid}'].usertype == 'teacher'}"
								   r:params="{attachmentOwner:'topic', attachmentType:'resource'}">
									Add
								</a>
							</div>
							<ul r:context="thread" r:items="getTopicAttachmentList('resource')" r:varName="item" r:varStatus="stat" r:name="selectedAttachment"
								   class="message attachments" width="100%">
								<li>
									<span class="subject"
										  onmouseover="$ctx('thread').showAttachmentInfo(this,'#{item.objid}', 'topic')">
										#{item.subject}
									</span>
								</li>
							</ul>
						</div>
					</div>
				</p>
				<br/>
				<div style="width:90%">
					<div class="hr"></div>
					<div r:context="thread" r:visibleWhen="#{memberList}">
						participants: 
						<ul r:context="thread" r:items="memberList" r:varName="item" class="participants clearfix">
							<li class="left" 
							    onmouseover="$ctx('classroom').showMemberInfo(this,'#{item.userid}',{offset:{x:0,y:0},showControls:false})">
								<img src="${pageContext.servletContext.contextPath}/profile/photo.jsp?id=#{item.userid}&t=thumbnail&v=#{users[item.userid].info.photoversion}"
									 width="20px"/>
							</li>
						</ul>
					</div>
					<div id="topic-tabs" class="tab-box">
						<div>
							<ul class="nav">
								<li><a href="#comments">Comments</a></li>
								<li><a href="#questions">Questions</a></li>
								<li><a href="#assignments">Assignments</a></li>
								<li><a href="#reports">Reports</a></li>
								<li><a href="#projects">Group Projects</a></li>
							</ul>
							<div class="footer"></div>
						</div>
						<div id="comments">
							<msg:post context="thread" name="message" action="postComment"/>
							<br/>							
							<msg:comments context="thread" commentList="commentList" usersMap="users"/>
						</div>
						<div id="questions">
							<msg:post context="thread" name="message" action="postQuestion"/>
							<br/>							
							<msg:comments context="thread" commentList="questionList" usersMap="users" emptyText="No questions posted yet."/>
						</div>
						<div id="assignments">
							<button r:context="thread" r:name="addAttachment" r:params="{attachmentOwner:'topic', attachmentType:'assignment'}">
								Add Assignment
							</button>
							<br/>
							<br/>
							<ul r:context="thread" r:items="getTopicAttachmentList('assignment')" r:varName="item" r:varStatus="stat" r:name="selectedAttachment"
								   class="message attachments" width="100%">
								<li>
									<div class="clear clearfix">
										<div onmouseover="$ctx('classroom').showMemberInfo(this,'#{item.userid}',{offset:{x:15,y:-5},showControls:false})"
											 style="width:20px;height:20px;overflow:hidden;"
											 class="left">
											<img src="${pageContext.servletContext.contextPath}/profile/photo.jsp?id=#{item.userid}&t=thumbnail&v=#{users[item.userid].info.photoversion}"
												 width="20px"/>
										</div>
										<div class="subject left"
											  onmouseover="$ctx('thread').showAttachmentInfo(this,'#{item.objid}', 'topic')">
											#{item.subject}
										</div>
									</div>
									<div class="hr"></div>
								</li>
							</ul>
						</div>
						<div id="reports">
							<button r:context="thread" r:name="addAttachment" r:params="{attachmentOwner:'topic', attachmentType:'report'}">
								Add Report
							</button>
							<br/>
							<br/>
							<ul r:context="thread" r:items="getTopicAttachmentList('report')" r:varName="item" r:varStatus="stat" r:name="selectedAttachment"
								   class="message attachments" width="100%">
								<li>
									<div class="clear clearfix">
										<div onmouseover="$ctx('classroom').showMemberInfo(this,'#{item.userid}',{offset:{x:15,y:-5},showControls:false})"
											 style="width:20px;height:20px;overflow:hidden;"
											 class="left">
											<img src="${pageContext.servletContext.contextPath}/profile/photo.jsp?id=#{item.userid}&t=thumbnail&v=#{users[item.userid].info.photoversion}"
												 width="20px"/>
										</div>
										<div class="subject left"
											  onmouseover="$ctx('thread').showAttachmentInfo(this,'#{item.objid}', 'topic')">
											#{item.subject}
										</div>
									</div>
									<div class="hr"></div>
								</li>
							</ul>
						</div>
						<div id="projects">
							<button r:context="thread" r:name="addAttachment" r:params="{attachmentOwner:'topic', attachmentType:'project'}">
								Add Project
							</button>
							<br/>
							<br/>
							<ul r:context="thread" r:items="getTopicAttachmentList('project')" r:varName="item" r:varStatus="stat" r:name="selectedAttachment"
								   class="message attachments" width="100%">
								<li>
									<div class="clear clearfix">
										<div onmouseover="$ctx('classroom').showMemberInfo(this,'#{item.userid}',{offset:{x:15,y:-5},showControls:false})"
											 style="width:20px;height:20px;overflow:hidden;"
											 class="left">
											<img src="${pageContext.servletContext.contextPath}/profile/photo.jsp?id=#{item.userid}&t=thumbnail&v=#{users[item.userid].info.photoversion}"
												 width="20px"/>
										</div>
										<div class="subject left"
											  onmouseover="$ctx('thread').showAttachmentInfo(this,'#{item.objid}', 'topic')">
											#{item.subject}
										</div>
									</div>
									<div class="hr"></div>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- attachment info -->
		<div id="attachment_info" style="display:none;width:250px;">
			<label r:context="thread" style="display:block;">
				<div style="font-size:11px;color:#444;font-weight:normal;">
					<b>Description: </b><i>#{selectedAttachment.message? selectedAttachment.message : 'No description.'}</i>						
					<br/>
					<span style="color:gray">
						#{users[selectedAttachment.userid].lastname}, #{users[selectedAttachment.userid].firstname}
						<br/>
						Posted #{selectedAttachment.dtposted}
					</span>
				</div>
				<div class="hr"></div>
				<div class="align-r">
					<span r:context="thread" r:visibleWhen="#{selectedAttachment.reftype == 'link'}">
						<a href="#{selectedAttachment.linkref}" target="_blank">View</a>
					</span>
					<span r:context="thread" r:visibleWhen="#{selectedAttachment.reftype == 'embed'}">
						<a r:context="thread" r:name="viewEmbed">View</a>
					</span>
					<span r:context="thread" r:visibleWhen="#{selectedAttachment.reftype == 'library'}">
						<span r:context="thread" r:visibleWhen="#{selectedAttachment.libtype == 'doc'}">
							<a href="library/viewres.jsp?id=#{selectedAttachment.linkref}&ct=#{selectedAttachment.content_type}" target="_blank">
								View
							</a>
						</span>
						&nbsp;
						<span r:context="thread" r:visibleWhen="#{selectedAttachment.libtype == 'doc'}">
							<a href="library/downloadres.jsp?id=#{selectedAttachment.linkref}&ct=#{selectedAttachment.content_type}" target="_blank">
								Download
							</a>
						</span>
						<span class="photo" r:context="thread" r:visibleWhen="#{selectedAttachment.libtype == 'picture'}">
							<a href="library/viewres.jsp?id=#{selectedAttachment.linkref}&ct=#{selectedAttachment.content_type}" target="_blank">
								<img src="library/viewres.jsp?id=#{selectedAttachment.linkref}&ct=#{selectedAttachment.content_type}" height="20px" />
							</a>
						</span>
					</span>
					&nbsp;
					<a r:context="thread" r:name="editAttachment" r:visibleWhen="#{selectedAttachment.userid == '${SESSION_INFO.userid}'}"
					   title="edit attachment">
						edit
					</a>
					&nbsp;
					<a r:context="thread" r:name="removeAttachment" r:visibleWhen="#{selectedAttachment.userid == '${SESSION_INFO.userid}'}"
					   title="remove attachment">
						remove
					</a>
				</div>
			</label>
		</div>
	</jsp:body>
	
</t:content>


	