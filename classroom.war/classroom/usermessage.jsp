<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<s:invoke service="ClassroomService" method="getCurrentUserInfo" params="${param['classid']}" var="USER_INFO"/>

<t:content>
	<jsp:attribute name="head">
		<script src="${pageContext.servletContext.contextPath}/js/ext/textarea.js"></script>
	</jsp:attribute>
	
    <jsp:attribute name="style">
        .message {
            font-size:11px;font-family:arial;padding:6px;
        }
        .news_action {
            font-size:11px;
        }
		#sendername {
			color: darkslateblue;
			font-size:12px;
			font-weight:bold;
		}
		.msg-divider {
			padding-top:2px;
			border-top:1px solid lightgrey;
		}
    </jsp:attribute>

	<jsp:attribute name="script">
		$put(
			"usermessage",
			new function() 
			{
				var self = this;
				var classSvc = ProxyService.lookup("ClassroomService");
				var svc = ProxyService.lookup("MessageService");

				this.objid;
				this.user;
				this.photo;
				this.text = "";
				this._controller;
				this.mobile = '-';

				this.classid = "${param['classid']}";
				this.sending = "false";
				this.message = {recipients: [] };
				this.eof = "false";

				this.listModel = {
					fetchList : function(o, last) {
						var m = {userid:self.objid, channelid: self.classid};
						if(last) m.lastmsgid = last.objid;
						var list = svc.getConversation( m );	
						if(list.length==0) self.eof = "true";
						return list;
					}
				}

				this.onload = function() {
					this.user = classSvc.getMemberInfo({ userid: this.objid, classid: this.classid });
					if( this.user && this.user.contacts ) {
						var mb = this.user.contacts.find(function(it){ return it.type.toLowerCase() == 'mobile' });
						if( mb ) {
							this.mobile = mb.value;
						}
					}
					Session.handler = function( o ) {
						if(o.msgtype && o.channelid == self.classid ) {
							self.listModel.prependItem( o );
						}
					}
				}

				this.send = function() {
					this.message = {
						channelid:this.classid,
						recipients:[{userid: this.objid }],
						scope: 'private',
						msgtype: 'private',
						message: this.text
					};
					svc.send( this.message );
					this.text = '';
				}

				this.addPerson = function() {
					alert("Add a Person");
				}

				this.atestfunction = function() {
					alert("this is a test function");
				}

			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="rightpanel">
		<c:if test="${USER_INFO.usertype == 'teacher'}">
			<span r:context="usermessage" r:visibleWhen="#{user.usertype == 'student'}">
				<a href="#classrecord:student_record?studentid=${param['objid']}">View Class Record</a>
			</span>
		</c:if>
	</jsp:attribute>
	
	<jsp:attribute name="title">
		<table class="page-form-table" width="80%" cellpadding="0" cellspacing="0">
            <tr>
                <td rowspan="4" width="60" style="padding-right:10px;">
                    <label r:context="usermessage">
						<img src="profile/photo.jsp?id=#{objid}&t=thumbnail"/>
                    </label>
                </td>
            </tr>
            <tr>
                <td class="caption" style="font-size:14px;">
                    <label r:context="usermessage">#{user.firstname} #{user.lastname}</label>
                </td>
                <td>
                    <img src="img/phone.png" style="padding-right:5px;"/>
                    <label r:context="usermessage">#{mobile}</label>
                </td>
            </tr>
            <tr>
                <td>
                    <label r:context="usermessage">#{user.usertype}  #{user.objid=='${USER_INFO.objid}' ? '(me)' : ''}</label>
                </td>
                <td>
                    <img src="img/email.png" style="padding-right:5px;"/>
                    <label r:context="usermessage">#{user.email}</label>
                </td>
            </tr>
        </table>
	</jsp:attribute>
	
    <jsp:body>
        <!-- POSTING A COMMENT HERE -->
        <div style="width:500px;">
			<div class="post-message">
				<div r:context="usermessage" r:type="textarea" r:name="text" r:hint="Write a message" class="inner">
					<div class="controls-wrapper">
						<div class="controls">
							<div class="left">
								<a href="#" title="Attach a link"><img src="img/post-icons/doc-attach.png"/></a>
								<a href="#" title="Add another recipient"><img src="img/post-icons/doc-add.png"/></a>
							</div>
							<div class="right">
								<button r:context="usermessage" r:name="send">Send</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<br/>

            <!-- POSTED MESSAGES ARE SHOW HERE -->
            <table width="100%" r:context="usermessage" r:model="listModel" r:varName="item" cellpadding="0" cellspacing="0">
                <tbody>
					<tr>
						<td valign="top" align="center" width="70" style="padding-bottom:10px;"  class="msg-divider" rowspan="2">
							<img src="profile/photo.jsp?id=#{item.senderid}&t=thumbnail"/>
						</td>
						<td valign="top" id="sendername" class="msg-divider">
							#{item.lastname}, #{item.firstname}	
						</td>
						<td valign="top" align="right" class="msg-divider">
							<span style="font-size:11px;color:gray;">posted on #{item.dtfiled}</span>
						</td>
					</tr>
					<tr>
						<td valign="top" colspan="2">
							#{item.message}	
						</td>
					</tr>
                </tbody>
            </table>
        </div>

       
    </jsp:body>
</t:content>
