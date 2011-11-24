<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<t:content title="Bulletin Board" subtitle="Post announcements and important news">
	<jsp:attribute name="head">
		<script src="${pageContext.servletContext.contextPath}/js/ext/textarea.js"></script>
	</jsp:attribute>
	<jsp:attribute name="style">
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
		.bulletin_action {
			font-size:11px;
		}
		.inquireAction {
			color: lightgrey;
		}
		.inquireAction:hover {
			color:blue;
			font-weight:bold;
		}
		.actionbutton {
			border:1px solid lightgrey;
			font-family:verdana;
			padding:5px;
			font-weight:bold;
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
		.notifycount {
			background-color: yellow;
			color:red;
			font-size:11px;
			font-weight:bold;
			padding:2px;
			font-family: verdana, arial;
			text-align:center;
			border: 1px solid orange;
		}
	</jsp:attribute>
	<jsp:attribute name="script">
		$put(
			"bulletin",
			new function() {
			
				var svc = ProxyService.lookup("MessageService");
				var self = this;
				this._controller;
				this.classid = "${param['classid']}";
				this.message = {};
				this.eof = "false";
				this.listModel = {
					fetchList: function( p, last ){
						var m = {channelid: self.classid};
						if(last) m.lastmsgid = last.objid; 
						m.msgtype = "bulletin";
						var list =  svc.getPublicMessages( m );
						if(list.length==0) {
							self.eof = "true";
						}	
						return list;
					}
				};
				
				this.onload = function() {
					if(!this.classid) this.classid = null;
					Session.handler = function( o ) {
						if(o.scope == "public" && o.channelid == self.classid && o.msgtype == 'bulletin') {
							if( o.parentid ) {
								var msgid = o.parentid;
								var thread = self.listModel.getList().find(function(x) { return x.objid == msgid } );
								if(thread) {
									self.comments[msgid] = svc.getResponses( {parentid: msgid } );
									thread.replies = self.comments[msgid].length;
									if(thread.expanded != "true" ) {
										self.comments[msgid] = null;
										if(thread.notifycount==null) thread.notifycount = 0;
										thread.notifycount = thread.notifycount+1;
									}
									self.listModel.refresh();
								}	
							}
							else {
								self.listModel.prependItem( o );
							}	
						}
					}
				}
				
				this.send = function() {
					if(!this.message.message) {
						alert( "Please write a message");
						return;
					}
					this.message.scope = "public";
					this.message.msgtype = "bulletin";
					this.message.channelid = this.classid;
					svc.send( this.message );
					this.message = {}
				}
				
				this.comment = function() {
					var saveHandler = function(o) {
						var m = {};
						m.parentid = self.selectedMessage.objid;
						m.message = o;
						m.recipients = [{userid:self.selectedMessage.senderid}];
						m.channelid = self.classid;
						m.scope = "public";
						m.msgtype = "bulletin";
						svc.send( m );
					}
					return new PopupOpener("comment", {saveHandler: saveHandler} );
				}
				
				this.selectedMessage;
				this.comments = {}
				
				this.viewComments = function() {
					var msgid = this.selectedMessage.objid;
					this.selectedMessage.expanded = "true";
					this.selectedMessage.notifycount = null;
					if( !this.comments[msgid] ) {
						this.comments[msgid] = svc.getResponses( {parentid: msgid } );
					}
				}
				this.hideComments = function() {
					this.selectedMessage.expanded = null;
					this.comments[this.selectedMessage.objid] = null;
				}
				
				this.subscribeSMS = function() {
					return new PopupOpener( "subscribe_sms", {msgtype: "bulletin"}); 
				}
			}
		);	
	</jsp:attribute>

	<jsp:attribute name="actions">
		<input type="button" r:context="bulletin" r:name="subscribeSMS" value="Subscribe SMS" class="actionbutton"/>
	</jsp:attribute>
	
	<jsp:attribute name="rightpanel">
		<table>
			<tr>
				<td>
					<div style="font-family:helvetica;font-size:1.3em;color:red;font-weight:bolder;">Deals for the day</div>
					<br>
					<i>No deals today in your area</i>
				</td>
			</tr>
		</table>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="comment_tpl" style="display:none;">
			<br/>
			<table class="comments" r:context="bulletin" r:items="comments[params.objid]" r:varName="comment" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td valign="top" width="50" rowspan="2" class="msg-divider">
						<img src="profile/photo.jsp?id=#{comment.senderid}&t=thumbnail" width="60%"/>
					</td>
					<td valign="top"  id="sendername" class="msg-divider">
						#{comment.lastname}, #{comment.firstname} 
					</td>
					<td valign="top" align="right" class="msg-divider">
						posted #{comment.dtfiled}
					</td>
				</tr>
				</tr>	
					<td valign="top" colspan="2">
						#{comment.message}
					</td>
				</tr>		
			</table>
		</div>
	</jsp:attribute>
	
	<jsp:body>
		<div class="post-message" style="width:550px">
			<div r:context="bulletin" r:type="textarea" r:name="message.message" r:hint="Post message." class="inner">
				<div class="controls-wrapper">
					<div class="controls">
						<div class="left">
							<button r:context="" r:name="">Attach</button>
						</div>
						<div class="right">
							<button r:context="bulletin" r:name="send">Post</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<br/>
		<table width="550" r:context="bulletin" r:model="listModel" r:varName="item" r:varStatus="stat" cellpadding="0" 
			r:emptyText="No messages posted yet" cellspacing="0" class="bulletin" r:name="selectedMessage">
			<tbody>
				<tr>
					<td valign="top" align="center" width="70"  class="msg-divider" rowspan="3">
						<img src="profile/photo.jsp?id=#{item.senderid}&t=thumbnail"/>
					</td>
					<td valign="top" id="sendername"  class="msg-divider">
						#{item.lastname}, #{item.firstname}	
					</td>
					<td valign="top" align="right"  class="msg-divider">
						<span style="font-size:11px;color:gray;">posted on #{item.dtfiled}</span>
					</td>
				</tr>
				<tr>
					<td valign="top" colspan="2">
						#{item.message}	
					</td>
				</tr>
				<tr>
					<td colspan="2" valign="bottom">
						<a r:context="bulletin" r:name="comment">Comment</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a r:context="bulletin" r:name="viewComments" r:visibleWhen="#{item.expanded != 'true'}">View Comments (#{item.replies})</a>
						<a r:context="bulletin" r:name="hideComments" r:visibleWhen="#{item.expanded == 'true'}">Hide Comments (#{item.replies})</a>
						&nbsp;
						<label r:context="bulletin" class="notifycount" title="New comments unread" r:visibleWhen="#{item.notifycount}">#{item.notifycount}</label>
						<br>
						<template r:context="bulletin" r:id="comment_tpl" r:params="{objid:'#{item.objid}'}" />
					</td>
				</tr>
			</tbody>
		</table>
		
		<a r:context="bulletin" r:name="listModel.fetchNext" r:visibleWhen="#{eof=='false'}">View More</a>
	</jsp:body>
	
</t:content>

