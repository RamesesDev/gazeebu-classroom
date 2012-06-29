<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/message" prefix="msg" %>


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
				<ui:userimagepanel 
					context="thread" items="memberList" 
					varname="item" usersmap="users" 
					onmouseover="$ctx('classroom').showMemberInfo(this,'#{item.userid}',{offset:{x:0,y:0},showControls:false})"
					imagewidth="20px"
					itemid="userid"
					/>
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
					<msg:post context="thread" caption="Post a comment" action="postComment"/>
					<br/>							
					<msg:comments context="thread" commentList="commentList" usersMap="users"/>
				</div>
				<div id="questions">
					<msg:post context="thread" caption="Post a question" action="postQuestion"/>
					<br/>							
					<msg:comments context="thread" commentList="questionList" usersMap="users" emptyText="No questions posted yet."/>
				</div>
				<div id="assignments">
					<msg:post context="thread" caption="Add an assignment" action="addAttachment" 
					          params="{attachmentOwner:'topic', attachmentType:'assignment'}"/>
					
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
					<msg:post context="thread" caption="Add a report" action="addAttachment" 
					          params="{attachmentOwner:'topic', attachmentType:'report'}"/>
					
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
					<msg:post context="thread" caption="Add a project" action="addAttachment" 
					          params="{attachmentOwner:'topic', attachmentType:'project'}"/>
					
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