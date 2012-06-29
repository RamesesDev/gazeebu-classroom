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
				var self = this;
				var client;
				
				this.classid = "${param['classid']}";
				this.listModel;
				this.selectedMessage;
				
				this.onload = function() {
					client = new MessageServiceClient('bulletin', this.classid);
					client.init();
					this.listModel = client.messageList;
				};
				
				this.post = function() {
					return new PopupOpener('common:post_message', {handler: function( msg ){
						client.post( {message: msg} );
					}});
				}
				
				this.postComment = function() 
				{
					var handler = function( msg )
					{
						if( !msg ) return;
						if( !msg.trim() ) return;
						
						client.respond( self.selectedMessage.objid, {message: msg});
					}
					
					return new PopupOpener('common:post_message', {hint: 'Post a comment', handler: handler}, {title: 'Post Comment'});
				}
				
				this.editClass = function() {
					location.hash = 'classinfo:classinfo';
				}
				
				this.viewSubscription = function() {
					location.href = 'profile.jsp#mobilesettings';
				}
			}
		);
	</jsp:attribute>

	
	<jsp:attribute name="actions">
		<button r:context="classroom" r:name="subscribeSMS">
			Subscribe SMS
		</button>
		<c:if test="${CLASS_INFO.usertype == 'teacher' and CLASS_INFO.status == 1}">
			<button r:context="classroom" r:name="deactivateClass">
				Deactivate Class
			</button>
		</c:if>
	</jsp:attribute>
	
	<jsp:attribute name="rightpanel">
		
	</jsp:attribute>
	
	<jsp:body>
		<div style="width:90%">
			<msg:post context="bulletin" action="post"/>
			<br/>
			<msg:list context="bulletin" name="selectedMessage"
					  postCommentAction="postComment" commentName="comment"
					  model="listModel" usersMap="$ctx('classroom').usersIndex"/>
		</div>
	</jsp:body>
	
</t:content>

