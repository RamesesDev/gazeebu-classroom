<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content>
	<jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/profile/profile.css" type="text/css" rel="stylesheet" />
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
		$put(
			"usermessage",
			new function() {
				var self = this;
				var profSvc = ProxyService.lookup("UserProfileService");
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
					this.user = profSvc.getInfo({ objid: this.objid });
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
		  
		function pm_mouseIn() {
			document.getElementById("pm").src = "img/pm_icon_color.png";
		}

		function pm_mouseOut() {
			document.getElementById("pm").src = "img/pm_icon.png";
		}

		function an_mouseIn() {
			document.getElementById("an").src = "img/announcements_color.png";
		}

		function an_mouseOut() {
			document.getElementById("an").src = "img/announcements.png";
		}

		document.getElementById("pm").src = "img/pm_icon.png";
		document.getElementById("an").src = "img/announcements.png";
		document.getElementById("pm").src = "img/pm_icon.png";
	</jsp:attribute>
	
	<jsp:attribute name="rightpanel">
	  <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
		 <tr>
			<th class="center" colspan="2">Recent Activities</th>
		 </tr>
		 <tr>
			<td rowspan="4">
			   picture here
			</td>
		 </tr>
		 <tr>
			<td>
			   activity title here
			</td>
		 </tr>
		 <tr>
			<td>
			   activity details here
			</td>
		 </tr>
	  </table>
	</jsp:attribute>
	
	<jsp:body>
		<table class="page-form-table" width="80%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td rowspan="4" width="60" style="padding-right:10px;">
					<label r:context="usermessage">
						<img src="#{user.profile}/thumbnail.jpg"/>
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
					&nbsp;
				</td>
				<td>
					<img src="img/email.png" style="padding-right:5px;"/>
					<label r:context="usermessage">#{user.email}</label>
				</td>
			</tr>
		</table>
	   
	   <!-- POSTING A COMMENT HERE -->
	   <div style="float:left;">
			<t:textarea id="message" context="usermessage" hint="Write a message">
			 <jsp:attribute name="textareacontrols">
				<input type="image"
					  value="test" 
					  id="pm"
					  r:context="usermessage"
					  r:action="atestfunction"
					  onmouseover="pm_mouseIn()"
					  onmouseout="pm_mouseOut()"/>
				<input type="image"
					  value="test" 
					  id="an"
					  r:context="usermessage"
					  r:action="atestfunction"
					  onmouseover="an_mouseIn()"
					  onmouseout="an_mouseOut()"/>
			 </jsp:attribute>
			 <jsp:body>
				<div r:context="usermessage"
					  style="border:1px solid #a5aa84;margin-top:10px;margin-bottom:10px;padding:3px;">
				   Person01, Person02 <input type="button" value="Add Person" r:context="usermessage" r:name="addPerson">
				</div>
				<input type="button" value="Share" r:context="usermessage" r:name="send"/>
			 </jsp:body>
			</t:textarea>
		  
			<!-- POSTED MESSAGES ARE SHOW HERE -->
			<table width="550" r:context="usermessage" r:model="listModel" r:varName="item" cellpadding="0" cellspacing="0">
				<tbody>
					<tr>
						<td valign="top" align="left" width="50" style="padding-top:2px;border-top:1px solid lightgrey" rowspan="2">
							<img src="${pageContext.servletContext.contextPath}/#{item.senderprofile ?  item.senderprofile + '/thumbnail.jpg' : 'blank.jpg'}"></img>
						</td>
						<td valign="top" class="message" style="border-top:1px solid lightgrey">
							<b>#{item.senderlastname}, #{item.senderfirstname}</b>	
						</td>
						<td valign="top" align="right" style="border-top:1px solid lightgrey">
							<div style="font-size:11px;color:gray;padding-left:6px;">posted on #{item.dtfiled}</div> 
						</td>
					</tr>
					<tr>
						<td valign="top" class="message" colspan="2">
							#{item.message}	
						</td>
					</tr>
					
				</tbody>
			</table>
	   </div>
	</jsp:body>
</t:content>
