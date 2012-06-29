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
					
					this.detailsShown = true;
					this.toggleDetails = function() {
						$('#thread-details').toggle('slide', {direction:'up'});
						this.detailsShown = !this.detailsShown;
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
						_topicAttachmentList = null;
						refreshMembers();
						$('#topic').animate({height: $('#topic')[0].scrollHeight},function(){ $(this).css('height',''); });
						$('#topic-list').animate({height: 0});
					}
					
					function initTabs() {
						$('#topic-tabs').data('loaded',{}).tabs('destroy');
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
						
						MsgBox.confirm(
						  'Are you sure you want to remove this item?',
						  function(){
							attachSvc.removeAttachment({objid: self.selectedAttachment.objid});
						
							if(self.attachmentOwner == 'topic')
								_topicAttachmentList = null;
							else
								_attachmentList = null;
							
							self._controller.refresh('selectedAttachment');
						  }
						);
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
						return new PopupOpener('common:post_message', {handler: function( msg ){
							if( !msg ) return;
							if( !msg.trim() ) return;
							client.respond(self.selectedTopic.objid, {message: msg});
						}});
					}
					
					this.postQuestion = function() {
						return new PopupOpener('common:post_message', {handler: function( msg ){
							if( !msg ) return;
							if( !msg.trim() ) return;
							client.respond(self.selectedTopic.objid, {message: msg}, 'question');
						}});
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
			<!--
			<button r:context="" r:name="" title="Publish to bulletin" 
			        onclick="MsgBox.alert('This feature is not yet implemented.');">
				Publish
			</button>
			-->
			<button r:context="thread" r:name="editThread" title="Edit discussion thread">
				Edit
			</button>
		</c:if>
	</jsp:attribute>

	<jsp:body>
		<div id="thread-details" class="clearfix">
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
		<div>
			<span r:context="thread" r:type="label">
				<span class="wingdings" r:context="thread" r:visibleWhen="#{detailsShown}">&#217;</span>
				<span class="wingdings" r:context="thread" r:visibleWhen="#{!detailsShown}">&#218;</span>
				<a r:context="thread" r:name="toggleDetails" title="#{detailsShown? 'Hide' : 'Show'} discussion thread details">
					#{detailsShown? 'Hide' : 'Show'} Details
				</a>
			</span>
		</div>
		
		<div class="hr"></div>
		
		<jsp:include page="thread/topic.jsp"/>
		
		<!-- attachment info -->
		<jsp:include page="thread/attachment-info.jsp"/>
	</jsp:body>
	
</t:content>


	