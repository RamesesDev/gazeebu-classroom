<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<t:content title="Bulletin">
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
								self.viewComments();
								self.listModel.refresh(true);
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
				
				this.comment = function(msg) {
					var o = prompt("Enter comment");
					if( o ) {
						var m = {};
						m.parentid = msg[0];
						m.message = o;
						m.recipients = [{userid: msg[1]}];
						m.channelid = this.classid;
						m.scope = "public";
						m.msgtype = "bulletin";
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
					<a r:context="bulletin" r:name="subscribe">Subscribe to SMS</a> 
					to receive messages on your cellphone. 	
				</td>
			</tr>
		</table>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="comment_tpl" style="display:none;">
			<br/>
			<table class="comments" r:context="bulletin" r:items="comments[params.objid]" r:varName="comment" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td valign="top" width="50" rowspan="2" style="border-top:1px dashed lightgrey">
						<img src="${!comment.profile ? 'blank.jpg' : comment.profile + '/thumbnail.jpg'}" width="60%"/>
					</td>
					<td valign="top" style="border-top:1px dashed lightgrey">
						#{comment.lastname}, #{comment.firstname} 
					</td>
					<td valign="top" align="right" style="border-top:1px dashed lightgrey">
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
			r:emptyText="No messages posted yet" cellspacing="0" class="bulletin">
			<tbody>
				<tr>
					<td valign="top" align="center" width="70" style="padding-bottom:10px;padding-top:2px;border-top:1px solid lightgrey" rowspan="3">
						<img src="${pageContext.servletContext.contextPath}/#{item.senderprofile ?  item.senderprofile + '/thumbnail.jpg' : 'blank.jpg'}"></img>
					</td>
					<td valign="top"   style="border-top:1px solid lightgrey;color:darkslateblue;font-size:12px;font-weight:bold;">
						#{item.lastname}, #{item.firstname}	
					</td>
					<td valign="top" align="right"  style="border-top:1px solid lightgrey">
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
						<a class="inquireAction" href="javascript:$get('bulletin').invoke(this, 'comment', ['#{item.objid}','#{item.senderid}'] );">Comment</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a r:context="bulletin" r:name="viewComments" r:params="{msgid: '#{item.objid}' }">View Comments (#{item.replies})</a>&nbsp;&nbsp;
						<br>
						<template r:context="bulletin" r:id="comment_tpl" r:params="{objid:'#{item.objid}'}" />
					</td>
				</tr>
			</tbody>
		</table>
		
		<a r:context="bulletin" r:name="listModel.fetchNext" r:visibleWhen="#{eof=='false'}">View More</a>
	</jsp:body>
	
</t:content>

