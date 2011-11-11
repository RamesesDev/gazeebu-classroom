<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<t:content title="Announcements">

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
			"news",
			new function() {
			
				var svc = ProxyService.lookup("MessageService");
				var self = this;
				this._controller;
				this.classid = "${param['classid']}";
				this.sending = "false";
				this.message = {};
				this.sendMode = 0;
				this.eof = "false";
				this.sendModes = [{id:0, title:"This class only"}, {id:1,title:"To All"} ];
				
				this.listModel = {
					fetchList: function( p, last ){
						var m = {channelid: self.classid};
						if(last) m.lastmsgid = last.objid; 
						m.msgtype = "announcement";
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
						if(o.scope == "public" && o.channelid == self.classid ) {
							self.listModel.prependItem( o );
						}
					}
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
				
				this.comment = function(msg) {
					var o = prompt("Enter inquiry");
					if( o ) {
						var m = {};
						m.parentid = msg[0];
						m.message = o;
						m.recipients = [{userid: msg[1]}];
						m.channelid = this.classid;
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

		<div style="width:550px">
			<t:textarea id="message" context="news" name="message.message" hint="Write a message">
				<jsp:attribute name="leftcontrols">
					<a href="#" title="attach a link"><img src="img/post-icons/doc-attach.png"/></a>
				</jsp:attribute>
				<jsp:attribute name="rightcontrols">
					<select r:context="news" r:items="sendModes" r:name="sendMode" r:itemLabel="title" r:itemKey="id" ></select>
					<input type="button" value="Send" r:context="news" r:name="send"/>
				</jsp:attribute>
			</t:textarea>
		</div>
		
		<table width="550" r:context="news" r:model="listModel" r:varName="item" r:varStatus="stat" cellpadding="0" cellspacing="0" class="bulletin">
			<tbody>
				<tr>
					<td valign="top" align="center" width="50" style="padding-top:10px;border-bottom:1px solid lightgrey" rowspan="3">
						<img src="${pageContext.servletContext.contextPath}/img/post-icons/announcement24.png" />
					</td>
					<td valign="top">
						#{item.message}	
					</td>
					<td valign="top" align="right">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<a class="inquireAction" href="javascript:$get('news').invoke(this, 'comment', ['#{item.objid}','#{item.senderid}'] );">Comment</a>
						&nbsp;&nbsp;&nbsp;
						<span style="font-size:11px;color:gray;">posted on #{item.dtfiled}</span> 
					</td>
				</tr>
				<tr>
					<td style="border-bottom:1px solid lightgrey" colspan="2">
						<a r:context="news" r:name="viewComments" r:params="{msgid: '#{item.objid}' }">View Comments (#{item.replies})</a>&nbsp;&nbsp;
						<br>
						<template r:context="news" r:id="comment_tpl" r:params="{objid:'#{item.objid}'}" />
					</td>
				</tr>
			</tbody>
		</table>
		
		<!-- this is called by the template tag -->
		<div id="comment_tpl" style="display:none;">
			<ul r:context="news" r:items="comments[params.objid]" r:varName="comment">
				<li>#{comment.message}</li>		
			</ul>
		</div>
		
		<br/>
		
		<a r:context="news" r:name="listModel.fetchNext" r:visibleWhen="#{eof=='false'}">View More</a>
	</jsp:body>
	
</t:content>

