<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<t:content title="Incoming Messages" subtitle="View your private messages">
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
		$put( "news" ,
			new function() {
				var svc = ProxyService.lookup("MessageService");
				var self = this;
				this._controller;
				this.classid = "${param['classid']}";
				this.message;
				this.eof = "false";
				this.comments = {};
				this.selectedMessage;
				
				this.listModel = {
					fetchList: function( p, last ){
						var m = {channelid: self.classid};
						if(last) m.lastmsgid = last.objid; 
						m.msgtype = "news";
						var list =  svc.getIncomingPrivateMessages( m );
						if(list.length==0) self.eof = "true";
						return list;
					}
				};
				
				this.onload = function() {
					if(!this.classid) this.classid = null;
					Session.handler = function( o ) {
						if(o.scope=='private' && o.channelid == self.classid && o.senderid != "${SESSION_INFO.userid}" ) {
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
				
				this.reply = function() {
					var saveHandler = function(o) {
						var m = {};
						m.parentid = self.selectedMessage.objid;
						m.message = o;
						m.recipients = [{userid:self.selectedMessage.senderid}];
						m.channelid = self.classid;
						m.scope = "private";
						m.msgtype = "private";
						svc.send( m );
					}
					return new PopupOpener("comment", {saveHandler: saveHandler} );
				}
				
				
				
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
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="rightpanel">
		<table style="font-size:11px;">
			<tr>
				<td style="font-size:12px;">
					Sponsored Ads<br>
				</td>
			</tr>
		</table>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<!-- this is called by the template tag -->
		<div id="comment_tpl" style="display:none;">
			<br/>
			<table class="comments" r:context="news" r:items="comments[params.objid]" r:varName="comment" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td valign="top" width="50" rowspan="2"  class="msg-divider">
						<img src="${!comment.profile ? 'blank.jpg' : comment.profile + '/thumbnail.jpg'}" width="60%"/>
					</td>
					<td valign="top" id="sendername" class="msg-divider">
						#{comment.lastname}, #{comment.firstname} 
					</td>
					<td valign="top" align="right"  class="msg-divider">
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
		<table width="550" r:context="news" r:model="listModel" r:varName="item" r:varStatus="stat" 
			r:emptyText="No messages posted yet" cellpadding="0" cellspacing="0" class="news" r:name="selectedMessage">
			
			<tbody>
				<tr>
					<td valign="top" align="center" width="70" style="padding-bottom:10px;"  class="msg-divider" rowspan="3">
						<img src="${pageContext.servletContext.contextPath}/#{item.profile ?  item.profile + '/thumbnail.jpg' : 'blank.jpg'}"></img>
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
				<tr>
					<td colspan="2">
						<a r:context="news" r:name="reply">Reply</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a r:context="news" r:name="viewComments" r:visibleWhen="#{item.expanded != 'true'}">View replies (#{item.replies})</a>
						<a r:context="news" r:name="hideComments" r:visibleWhen="#{item.expanded == 'true'}">Hide replies (#{item.replies})</a>
						&nbsp;
						<label r:context="news" class="notifycount" title="New replies unread" r:visibleWhen="#{item.notifycount}">#{item.notifycount}</label>
						<br>
						<template r:context="news" r:id="comment_tpl" r:params="{objid:'#{item.objid}'}" />
					</td>
				</tr>
			</tbody>
		</table>
	
		<br/>
		<a r:context="news" r:name="listModel.fetchNext" r:visibleWhen="#{eof=='false'}">View More</a>

	</jsp:body>
	
</t:content>

