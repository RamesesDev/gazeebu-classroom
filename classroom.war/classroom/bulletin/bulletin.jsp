<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags/message" prefix="msg" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

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
			}
		);
	</jsp:attribute>

	
	<jsp:attribute name="actions">
		<button r:context="classroom" r:name="subscribeSMS">
			Subscribe SMS
		</button>
	</jsp:attribute>
	
	<jsp:attribute name="rightpanel">
		<c:if test="${CLASS_INFO.usertype == 'teacher'}">
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

