<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<s:invoke service="SessionService" method="getInfo" params="${SESSIONID}" var="SESSION_INFO"/>

<script>	
    $put("bulletin", 
	
        new function() {
			var newsfeedSvc = ProxyService.lookup("NewsfeedService");
			this.classid;
			this._controller;
			var self = this;
			this.list = [];
			
			this.onload = function() {
				this.classid = WindowUtil.getParameter("classid");
				Session.handler =  function(o) { 
					if(o.msgtype=='bulletin') { 
						self.list = newsfeedSvc.getUserMessages( { type: this.messageType, channelid: self.classid } );
						self._controller.refresh();
					};
				};
				this.list = newsfeedSvc.getUserMessages( { type: this.messageType, channelid: this.classid } );
			}
			
			this.messageType;
			this.messageTypes = [
								 {id:"", caption:"All"}, 
								 {id:"assignment", caption:"Assignment"},
								 {id:"todo",caption:"Todo"}, 
								 {id:"examresult", caption:"Exam Result"}
								];	
			
			this.propertyChangeListener = {
				"messageType" : function(o) { }
			}
			
			this.postAnnouncement = function() {
				return new PopupOpener("bulletin:announcement");
			}
			
			this.subscribeSMS = function() {
				return new PopupOpener("bulletin:subscribe_sms");
			}
			
			this.inviteTeacher = function() {
				return new PopupOpener("bulletin:teacher_invite");
			}
		}	
    );    
</script>
<style>
	.bulletin td{
		font-size:12px;font-family:arial;padding:6px;
	}
	.assignment {
		background-color:orange;color:white;padding:4px;text-align:center;font-size:10px;width:50px;
	}
	.announcement {
		background-color:green;color:white;padding:4px;text-align:center;font-size:10px;;
	}
	.Todo {
		background-color:green;color:white;padding:4px;text-align:center;font-size:10px;width:50px;
	}	
	.ExamResult {
		background-color:blue;color:white;padding:4px;text-align:center;font-size:10px;width:50px;
	}	
	.message {
		background-color:red;color:white;padding:4px;text-align:center;font-size:10px;width:50px;
	}
</style>


<t:content title="Bulletin Board" >

	<jsp:attribute name="actions">
		<div style="font-size:11px;">
			Show Only: <select context="bulletin" items="messageTypes" name="messageType" itemLabel="caption"></select>
		</div>
	</jsp:attribute>
	
	<jsp:body>
		<table width="100%">
			<tr>
				<td valign="top">
					<div context="bulletin" visibleWhen="#{list.length != 0}">
						<table width="550" context="bulletin" items="list" varName="item" cellpadding="0" cellspacing="0" class="bulletin">
							<tbody>
								<tr>
									<td valign="top" align="left" width="50" style="padding-top:10px;border-bottom:1px solid lightgrey" rowspan="2">
										<div class="#{item.msgtype}">#{item.msgtype}</div>
									</td>
									<td valign="top">
										#{item.message}	
									</td>
								</tr>
								<tr>
									<td style="border-bottom:1px solid lightgrey">
										<div style="font-size:11px;color:gray;">posted on #{item.dtfiled} by #{item.sendername}</div> 
									</td>
								</tr>
							</tbody>
						</table>	
					</div>
					<div context="bulletin" visibleWhen="#{list.length==0}">
						<i>There are no messages yet</i>
					</div>	
				</td>
				<td valign="top" width="150">
					<table style="font-size:11px;">
						<c:if test="${SESSION_INFO.usertype=='teacher'}">
							<tr>
								<td style="padding-bottom:10px;">
									<input type="button" context="bulletin" name="postAnnouncement" style="padding:2px;font-size:12px;" value="Post Announcement"/>
								</td>
							</tr>
						</c:if>
						<tr>
							<td style="font-size:12px;">
								Go Mobile!<br>
								<a context="bulletin" name="subscribeSMS" style="text-decoration:underline;color:blue">Subscribe to SMS</a> 
								to see messages posted in this bulletin sent to your cellphone. 	
							</td>
						</tr>
						<tr>
							<td style="font-size:12px;">
								<button>
									<a context="bulletin" name="inviteTeacher">Invite Teacher</a>   
								</button>
							</td>
						</tr>
						
					</table>
				</td>
			</tr>
		</table>
	</jsp:body>
	
</t:content>

