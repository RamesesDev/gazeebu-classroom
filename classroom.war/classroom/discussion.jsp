<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<t:content title="Discussion">

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
		.discussion_action {
			font-size:11px;
		}
		.inquireAction {
			color: lightgrey;
		}
		.inquireAction:hover {
			color:blue;
			font-weight:bold;
		}
		.emptyText {
			color:red;
			font-weight: bold;
			font-size:14px;
		}
		.comments td {
			font-size:10px;
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
			"discussion",
			new function() {
			
				var svc = ProxyService.lookup("MessageService");
				var self = this;
				this._controller;
				this.classid = "${param['classid']}";
				this.sending = "false";
				this.message;
				this.eof = "false";
				this._controller;
				
				this.listModel = {
					fetchList: function( p, last ){
						var m = {channelid: self.classid};
						if(last) m.lastmsgid = last.objid; 
						m.msgtype = "discussion";
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
						if(o.scope == "public" && o.channelid == self.classid && o.msgtype == 'discussion') {
							if( o.parentid ) {
								self.viewComments();
								self.listModel.refresh(true);
							}
							else {
								self.listModel.prependItem( o );
							}	
						}
					}
				}
				
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
					this.message.scope = "public";
					this.message.msgtype = "discussion";
					this.message.channelid = this.classid;
					svc.send( this.message );
					this.message = {}
				}
				
				this.comment = function(msg) {
					var o = prompt("Enter comment");
					if( o ) {
						var m = {};
						m.parentid = msg[0];
						m.message = o;
						m.recipients = [{userid: msg[1]}];
						m.channelid = this.classid;
						m.scope = "public";
						m.msgtype = "discussion";
						svc.send( m );
					}
				}
				
				this.msgid;
				this.comments = {}
				
				this.viewComments = function() {
					if( !this.comments[this.msgid] ) {
						this.comments[this.msgid] = svc.getResponses( {parentid: this.msgid } );
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
					<a r:context="discussion" r:name="subscribe">Subscribe to SMS</a> 
					to receive messages on your cellphone. 	
				</td>
			</tr>
		</table>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<!-- this is called by the template tag -->
		<div id="comment_tpl" style="display:none;">
			<br/>
			<table class="comments" r:context="discussion" r:items="comments[params.objid]" r:varName="comment" cellpadding="0" cellspacing="0" width="100%">
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
		<p style="font-size:11px;font-family:verdana">Post Questions or thoughts you like to discuss</p>
		<div r:context="discussion" r:visibleWhen="#{sending == 'false'}">
			<a r:context="discussion" r:name="postMessage">Post</a>
			<br><br>
		</div>
		<div style="width:80%;text-align:right;" r:context="discussion" r:visibleWhen="#{sending == 'true'}">	
			<a class="discussion_action" r:context="discussion" r:name="postMessage">Cancel</a>
		</div>
		<div r:context="discussion" r:visibleWhen="#{sending == 'true'}">
			<table width="80%" cellpadding="0" cellspacing="0">
				<tr>
					<td><textarea style="width:100%;height:50" r:context="discussion" r:name="message.message" /></td>
				</tr>
				<tr>
					<td>
						<input type="button" r:context="discussion" r:name="send" value="Post"/>
					</td>
				</tr>
			</table>
		</div>
		<br>
		
		<table width="550" r:context="discussion" r:model="listModel" r:varName="item" r:varStatus="stat" 
			r:emptyText="No messages for discussion posted yet" cellpadding="0" cellspacing="0" class="discussion">
			
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
						<a class="inquireAction" href="javascript:$get('discussion').invoke(this, 'comment', ['#{item.objid}','#{item.senderid}'] );">Comment</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a r:context="discussion" r:name="viewComments" r:params="{msgid: '#{item.objid}' }">View Comments (#{item.replies})</a>&nbsp;&nbsp;
						<br>
						<template r:context="discussion" r:id="comment_tpl" r:params="{objid:'#{item.objid}'}" />
					</td>
				</tr>
			</tbody>
		</table>
		
		<a r:context="discussion" r:name="listModel.fetchNext" r:visibleWhen="#{eof=='false'}">View More</a>
	</jsp:body>
	
</t:content>

