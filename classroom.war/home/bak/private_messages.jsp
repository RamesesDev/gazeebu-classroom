<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<t:content title="Incoming Messages">
	<jsp:attribute name="style">
		.bulletin td{
			font-size:12px;font-family:arial;padding:6px;
		}
		.announcement {
			background-color:green;color:white;padding:4px;text-align:center;font-size:10px;;
		}
		.removeButton {
			font-size: 12px;
			font-weight:bold;
			color:lightgrey;
			text-decoration: none;
			padding-right:4px;
			padding-left:4px;
		}
		.removeButton:hover {
			color:white;
			background-color: red;
		}
		.news_action {
			font-size:11px;
		}
	</jsp:attribute>

	<jsp:attribute name="script">
		$put( "news" ,
			new function() {
				var svc = ProxyService.lookup("MessageService");
				var self = this;
				this._controller;
				this.classid = "${param['classid']}";
				this.sending = "false";
				this.message;
				this.sendMode = 0;
				this.eof = "false";
				
				this.listModel = {
					fetchList: function( p, last ){
						var m = {channelid: self.classid};
						if(last) m.lastmsgid = last.objid; 
						var list =  svc.getIncomingPrivateMessages( m );
						if(list.length==0) self.eof = "true";
						return list;
					}
				};
				
				this.onload = function() {
					if(!this.classid) this.classid = null;
					Session.handler = function( o ) {
						if(o.scope=='private' && o.channelid == self.classid && o.senderid != "${SESSION_INFO.userid}" ) {
							self.listModel.prependItem( o );
						}
					}
				}
				
				this.sendModes = [{id:0, title:"This class only"}, {id:1,title:"To All"} ];
				
				this.postMessage = function() {
					if(this.sending == "true" && this.message.message) {
						var f = confirm( "Your message will be discarded. Continue?");
						if(!f) return;
					}
					this.sending = (this.sending=="true") ? "false" : "true";
					this.message = {}
				}
				
				this.send = function() {
					if(!this.message.message) {
						alert( "Please write a message");
						return;
					}
					if(this.sendMode == 0) this.message.channelid = this.classid;
					this.message.msgtype = "announcement";
					svc.send( this.message );
					this.message = {}
					this.sendMode = 0;
				}
				
				this.hideMessage = function(msgid) {
					alert( "hide message " + msgid );
				}
				
				this.reply = function(p) {
					var o = prompt("Reply");
					if( o ) {
						var m = {};
						m.parentid = p[0];
						m.message = o;
						m.recipients = [{userid: p[1]}];
						m.channelid = this.classid;
						svc.send( m );
					}

				}
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="rightpanel">
		<table style="font-size:11px;">
			<tr>
				<td style="font-size:12px;">
					Go Mobile!<br>
					<a r:context="news" r:name="subscribe">Subscribe to SMS</a> 
					to receive messages on your cellphone. 	
				</td>
			</tr>
		</table>
	</jsp:attribute>
	
	<jsp:body>
		<div class="content-menu">
			<table style="font-size:14px;">
				<tr>
					<td style="padding:5px;">
						<img src="${pageContext.servletContext.contextPath}/img/post-icons/announcement_color.png" />
						<a href="#news">Announcements</a>
					</td>
					<td>
						<span class="vr"></span>
					</td>
					<td style="padding:5px;">
						<img src="${pageContext.servletContext.contextPath}/img/post-icons/private_color.png" />
						<a href="#private_messages">Messages</a>
					</td>
				</tr>
			</table>
		</div>
	
		<div style="width:80%;text-align:right;" r:context="news" r:visibleWhen="#{sending == 'true'}">	
			<a class="news_action" r:context="news" r:name="postMessage">Cancel</a>
		</div>
		<div r:context="news" r:visibleWhen="#{sending == 'true'}">
			<table width="80%" cellpadding="0" cellspacing="0">
				<tr>
					<td><textarea style="width:100%;height:50" r:context="news" r:name="message.message" /></td>
				</tr>
				<tr>
					<td>
						<select r:context="news" r:items="sendModes" r:name="sendMode" r:itemLabel="title" r:itemKey="id" ></select>
						<input type="button" r:context="news" r:name="send" value="Send"/>
					</td>
				</tr>
			</table>
		</div>
		<br>

		<table width="550" r:context="news" r:model="listModel" r:varName="item" cellpadding="0" cellspacing="0" class="bulletin">
			<tbody>
				<tr>
					<td valign="top" align="left" width="50" style="padding-top:10px;border-bottom:1px solid lightgrey" rowspan="2">
						<img src="${pageContext.servletContext.contextPath}/#{item.senderprofile ?  item.senderprofile + '/thumbnail.jpg' : 'blank.jpg'}"></img>
					</td>
					<td valign="top">
						#{item.message}	
					</td>
					<td valign="top" align="right">
						<a class="removeButton" href="javascript:$get('news').invoke(this, 'hideMessage', '#{item.objid}')">x</a> 
					</td>
				</tr>
				<tr>
					<td style="border-bottom:1px solid lightgrey" colspan="2">
						<a href="javascript:$get('news').invoke(this, 'reply', ['#{item.parentid}','#{item.senderid}'] );">Reply</a>
						&nbsp;&nbsp;&nbsp;
						<span style="font-size:11px;color:gray;">posted on #{item.dtfiled}</span> 
					</td>
				</tr>
			</tbody>
		</table>
		<br/>
		<a r:context="news" r:name="listModel.fetchNext" r:visibleWhen="#{eof=='false'}">View More</a>

	</jsp:body>
	
</t:content>

