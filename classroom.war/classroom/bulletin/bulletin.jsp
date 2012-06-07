<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags/message" prefix="msg" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="ui" %>


<s:invoke service="ClassroomService" method="getClassInfo" params="${param['classid']}" var="CLASS_INFO"/>

<t:content title="Bulletin Board" subtitle="Post announcements and important news">
	
	<jsp:attribute name="head">
		<script src="${pageContext.request.contextPath}/js/ext/MessageServiceClient.js?v=${APP_VERSION}"></script>
	</jsp:attribute>

	<jsp:attribute name="script">
		$put(
			'bulletin',
			new function() 
			{
				var client;
				
				this.classid = "${param['classid']}";
				this.listModel;
				this.selectedMessage;
				this.message;
				
				this.onload = function() {
					client = new MessageServiceClient('bulletin', this.classid);
					client.init();
					this.listModel = client.messageList;
				};
				
				this.post = function() {
					client.post( {message: this.message} );
					this.message = '';
				}

				this.comment;
				this.postComment = function() {
					if( !this.comment ) return;
					if( !this.comment.trim() ) return;
					
					client.respond( this.selectedMessage.objid, {message: this.comment});
					this.comment = '';
				}
				
				this.editClass = function() {
					location.hash = 'classinfo:classinfo';
				}
			}
		);
	</jsp:attribute>

	
	<jsp:attribute name="actions">
		<button r:context="classroom" r:name="subscribeSMS">
			Subscribe SMS
		</button>
		<c:if test="${CLASS_INFO.status == 1}">
			<button r:context="classroom" r:name="deactivateClass">
				Deactivate Class
			</button>
		</c:if>
	</jsp:attribute>
	
	<jsp:attribute name="rightpanel">
		<div>
			<div class="clearfix">
				<span class="sec-title">Class Profile</span>
				<c:if test="${CLASS_INFO.usertype == 'teacher'}">
					<span class="right">
						<a r:context="bulletin" r:name="editClass">Edit</a>
					</span>
				</c:if>
			</div>
			<div class="hr"></div>
			<div style="padding-left: 5px;">
				<h4>Class Name:</h4>
				${CLASS_INFO.name}
				<h4>Description:</h4>
				${CLASS_INFO.description}
				<h4>Schedule:</h4>
				${CLASS_INFO.schedules}
				<h4>School:</h4>
				${CLASS_INFO.school}
			</div>
		</div>
		<br/>
		<div>
			<div class="sec-title">Class Members</div>
			<div class="hr"></div>
			<ui:userimagepanel 
				context="classroom" items="classInfo.members" 
				varname="item" usersmap="usersIndex" 
				onmouseover="$ctx('classroom').showMemberInfo(this,'#{item.objid}',{offset:{x:0,y:0}, location:'bottom right'})"
				imagewidth="20px"
				/>
		</div>
		<c:if test="${CLASS_INFO.usertype == 'teacher' and CLASS_INFO.status == 1}">
			<div class="hr"></div>	
			<div class="align-r">
				<button r:context="classroom" r:name="inviteStudents">
					Invite Students
				</button>
			</div>
		</c:if>
	</jsp:attribute>
	
	<jsp:body>
		<div style="width:90%">
			<msg:post context="bulletin" name="message" action="post"/>
			<br/>
			<msg:list context="bulletin" name="selectedMessage"
					  postCommentAction="postComment" commentName="comment"
					  model="listModel" usersMap="$ctx('classroom').usersIndex"/>
		</div>
	</jsp:body>
	
</t:content>

