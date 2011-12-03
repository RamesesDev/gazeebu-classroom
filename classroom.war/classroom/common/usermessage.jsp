<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/message" prefix="msg" %>

<t:content>
	<jsp:attribute name="head">
		<script src="${pageContext.request.contextPath}/js/ext/textarea.js"></script>
		<script src="${pageContext.request.contextPath}/js/ext/MessageServiceClient.js"></script>
	</jsp:attribute>

	<jsp:attribute name="script">
		$put(
			"usermessage",
			new function() 
			{
				var self = this;				
				var client;

				this.objid;
				this.me;
				this.user;
				this._controller;
				this.mobile = '-';

				this.classid = "${param['classid']}";
				this.message;

				this.listModel;
				this.selectedMessage;
				
				this.onload = function() {
					client = new MessageServiceClient("private", this.classid);
					client.init();
					this.listModel = client.messageList;
					
					this.user = $ctx('classroom').usersIndex[this.objid];
					this.me = $ctx('classroom').usersIndex["${SESSION_INFO.userid}"];
					
					if( this.user && this.user.contacts ) {
						var mb = this.user.contacts.find(function(it){ return it.type.toLowerCase() == 'mobile' });
						if( mb ) {
							this.mobile = mb.value;
						}
					}
				}

				this.send = function() {
					var msg = {message: this.message};
					if( this.me.objid != this.objid ) {
						msg.subscribers = [{userid: this.objid}];
						msg.privacy = 2;
					}
					client.post(msg);
					this.message = '';
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="rightpanel">
		<span r:context="usermessage" r:visibleWhen="#{(user.usertype == 'student' && me.usertype == 'teacher') || (user.objid == me.objid && user.usertype != 'teacher')}">
			<a href="#classrecord:student_record?studentid=${param['objid']}">View Class Record</a>
		</span>
	</jsp:attribute>
	
	<jsp:attribute name="title">
		<table class="page-form-table" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" width="60px" style="padding-right:10px;">
                    <label r:context="usermessage">
						<img src="profile/photo.jsp?id=#{objid}&t=thumbnail"/>
                    </label>
                </td>
				<td class="caption" width="400px;" valign="top">
                    <label r:context="usermessage">
						<span class="capitalized" style="font-size:14px;">
							#{user.firstname} #{user.lastname}
						</span>
						<br/>
						<i>#{user.username}</i>
						<br/>
						#{user.usertype}  #{user.objid==me.objid ? '(me)' : ''}
					</label>
                </td>
				<td valign="top">
                    <img src="img/phone.png" style="padding-right:5px;"/>
                    <label r:context="usermessage">#{mobile}</label>
					<br/>
					<img src="img/email.png" style="padding-right:5px;"/>
                    <label r:context="usermessage">#{user.email}</label>
                </td>
            </tr>
        </table>
	</jsp:attribute>
	
    <jsp:body>
		<div style="width:90%">
			<!--
			<msg:post context="usermessage" name="message" action="send"/>
			<br/>
			<msg:list context="usermessage" name="selectedMessage"
					  showComments="false"
					  model="listModel" usersMap="$ctx('classroom').usersIndex"/>
			-->
		</div>
    </jsp:body>
</t:content>
