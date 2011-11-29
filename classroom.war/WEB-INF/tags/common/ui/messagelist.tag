<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags/common" prefix="common" %>
<%@ tag import="com.rameses.web.support.*" %>
<%@ tag import="com.rameses.server.common.*" %>
<%@ tag import="java.util.*" %>

<%@ attribute name="context" %>
<%@ attribute name="showPost" %>
<%@ attribute name="canRemove" %>
<%@ attribute name="proxyService" %>
<%@ attribute name="messagewidth" %>
<%@ attribute name="parentid" %>


<style>
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
</style>

<script>
	$put(
		"${context}",
		new function() {
			var svc = ProxyService.lookup("${proxyService}");
			var self = this;
			this._controller;
			this.classid = "${param['classid']}";
			this.message = {};
			this.eof = "false";
			this.listModel = {
				fetchList: function( p, last ){
					var m = {channelid: self.classid};
					<c:if test="${! empty parentid}">
					m.parentid = "${parentid}";
					</c:if>
					if(last) m.lastmsgid = last.objid; 
					var list =  svc.getMessages( m );
					if(list.length==0) {
						self.eof = "true";
					}	
					return list;
				}
			};
			
			this.onload = function() {
				if(!this.classid) this.classid = null;
				Session.handler = function( o ) {
					if(o.scope == "public" && o.channelid == self.classid && o.msgtype == '${context}') {
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
					else if( o.channelid == self.classid && o.msgtype == '${context}-removed') {
						self.listModel.refresh(true);
					}
				}
			}
			
			this.send = function() {
				if(!this.message.message) {
					alert( "Please write a message");
					return;
				}
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
					svc.send( m );
				}
				return new DropdownOpener("comment", {saveHandler: saveHandler} );
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
			
			this.removeMessage = function() {
				if(confirm("Removing this message will also remove associated comments. Continue?")) {
					svc.removeMessage( {objid: this.selectedMessage.objid, channelid: this.classid} );
				}
			}
		}
	);	
</script>

<div id="comment_tpl" style="display:none;">
	<br/>
	<table class="comments" r:context="${context}" r:items="comments[params.objid]" r:varName="comment" 
		cellpadding="0" cellspacing="0" width="100%" width="100%">
		<tr>
			<td valign="top" width="50" rowspan="2" class="msg-divider">
				<img src="profile/photo.jsp?id=#{comment.senderid}&t=thumbnail" width="60%"/>
			</td>
			<td valign="top"  id="sendername" class="msg-divider">
				#{comment.lastname}, #{comment.firstname} 
				<span style="font-size:11px;color:gray;font-weight:normal;"> - Posted #{comment.dtfiled}</span>
			</td>
		</tr>
		</tr>	
			<td valign="top">
				#{comment.message}
			</td>
		</tr>		
	</table>
</div>

<div class="post-message" style="width:80%">
	<div r:context="${context}" r:type="textarea" r:name="message.message" r:hint="Post message." class="inner">
		<div class="controls-wrapper">
			<div class="controls">
				<div class="left">
					<button r:context="" r:name="">Attach</button>
				</div>
				<div class="right">
					<button r:context="${context}" r:name="send">Post</button>
				</div>
			</div>
		</div>
	</div>
</div>

<br/>
<table width="90%" r:context="${context}" r:model="listModel" r:varName="item" r:varStatus="stat" cellpadding="0" 
	r:emptyText="No messages posted yet" cellspacing="0" class="${context}" r:name="selectedMessage">
	<tbody>
		<tr>
			<td valign="top" align="center" width="70"  class="msg-divider" rowspan="3">
				<img src="profile/photo.jsp?id=#{item.senderid}&t=thumbnail"/>
			</td>
			<td valign="top" id="sendername"  class="msg-divider">
				#{item.lastname}, #{item.firstname}	
				<span style="font-size:11px;color:gray;font-weight:normal;"> - Posted #{item.dtfiled}</span>
			</td>
			<td align="right" style="padding-right:2px;"  class="msg-divider">
				<c:if test="${canRemove}">
					<a r:context="${context}" r:name="removeMessage" title="remove message">x</a>
				</c:if>
			</td>
		</tr>
		<tr>
			<td valign="top" colspan="2" style="padding-top:5px;padding-bottom:5px;">
				#{item.message}	
			</td>
		</tr>
		<tr>
			<td valign="bottom" colspan="2">
				<a r:context="${context}" r:name="comment">Comment</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a r:context="${context}" r:name="viewComments" r:visibleWhen="#{item.expanded != 'true'}">View Comments (#{item.replies})</a>
				<a r:context="${context}" r:name="hideComments" r:visibleWhen="#{item.expanded == 'true'}">Hide Comments (#{item.replies})</a>
				&nbsp;
				<label r:context="${context}" class="notifycount" title="New comments unread" r:visibleWhen="#{item.notifycount}">#{item.notifycount}</label>
				<br>
				<template r:context="${context}" r:id="comment_tpl" r:params="{objid:'#{item.objid}'}" />
			</td>
		</tr>
	</tbody>
</table>
<a r:context="${context}" r:name="listModel.fetchNext" r:visibleWhen="#{eof=='false'}">View More</a>




