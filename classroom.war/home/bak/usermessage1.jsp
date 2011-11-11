<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<t:content>
	<jsp:attribute name="title">
		User Info
		<label r:context="usermessage">#{objid}</label>	
	</jsp:attribute>

	<jsp:attribute name="actions">
		
	</jsp:attribute>

	<jsp:attribute name="style">
		.message {
			font-size:11px;font-family:arial;padding:6px;
		}
		.news_action {
			font-size:11px;
		}
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put( "usermessage" ,
			new function() {
				var svc = ProxyService.lookup("MessageService");
				this.objid;
				this.classid = "${param['classid']}";
				this._controller;
				var self  = this; 
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
					Session.handler = function( o ) {
						if(o.msgtype && o.channelid == self.classid ) {
							self.listModel.prependItem( o );
						}
					}		
				}

				this.sendMessage = function() {
					if(this.sending == "true" && this.message.message) {
						var f = confirm( "Your message will be discarded. Continue?");
						if(!f) return;
					}
					this.sending = (this.sending=="true") ? "false" : "true";
					this.message = {channelid:this.classid, recipients:[]};
				}
				
				this.send = function() {
					this.message.recipients.push( {userid: this.objid } );
					svc.send( this.message );
					this.message = {channelid:this.classid, recipients:[]};
				}
			}
		);	
	</jsp:attribute>
	
	<jsp:body>
		<div style="width:80%;" r:context="usermessage" r:visibleWhen="#{sending == 'false'}">
			<a class="news_action" r:context="usermessage" r:name="sendMessage">Send Message</a>
		</div>
		<div style="width:80%;text-align:right;" r:context="usermessage" r:visibleWhen="#{sending == 'true'}">	
			<a class="news_action" r:context="usermessage" r:name="sendMessage">Cancel</a>
		</div>
		<div r:context="usermessage" r:visibleWhen="#{sending == 'true'}">
			<table width="80%" cellpadding="0" cellspacing="0">
				<tr>
					<td><textarea style="width:100%;height:50" r:context="usermessage" r:name="message.message" /></td>
				</tr>
				<tr>
					<td>
						<input type="button" r:context="usermessage" r:name="send" value="Send"/>
					</td>
				</tr>
			</table>
		</div>
		<table width="550" r:context="usermessage" r:model="listModel" r:varName="item" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td valign="top" align="left" width="50" style="padding-top:10px;border-bottom:1px solid lightgrey" rowspan="2">
						<img src="${pageContext.servletContext.contextPath}/#{item.senderprofile ?  item.senderprofile + '/thumbnail.jpg' : 'blank.jpg'}"></img>
					</td>
					<td valign="top" class="message">
						#{item.message}	
					</td>
					<td valign="top" align="right">
					</td>
				</tr>
				<tr>
					<td style="border-bottom:1px solid lightgrey" colspan="2">
						<div style="font-size:11px;color:gray;padding-left:6px;">posted on #{item.dtfiled} by #{item.sendername}</div> 
					</td>
				</tr>
			</tbody>
		</table>
		<a r:context="usermessage" r:name="listModel.fetchNext" r:visibleWhen="#{eof=='false'}">View More</a>
	</jsp:body>
	
</t:content>

