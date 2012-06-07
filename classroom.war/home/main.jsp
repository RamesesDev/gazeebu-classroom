<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>


<t:content title="Home">
	<jsp:attribute name="style">
		.classhead td {
			padding:4px;
			font-size: 12px;
		}
		.classhead .col {
			background-color: lightgrey;
			font-weight:bolder;
		}
		.msg-divider {
			padding-top: 5px;
			border-top:1px sold lightgrey;
		}
	</jsp:attribute>
	
	<jsp:attribute name="head">
		<script type="text/javascript">
		$put(
			"main", 
			new function() {
				
				var svc = ProxyService.lookup( "ClassInvitationService" );
				var updatesSvc = ProxyService.lookup( "ClassUpdatesService" );
				var self = this;
				
				this._controller;
				
				this.hasInvitations = false;
				
				this.listModel = {
					fetchList: function(o) {
						svc.getInvitations(o, function(list){
							self.listModel.setList(list);
							self.hasInvitations = (list && list.length > 0)? true : false;
							self._controller.refresh();
						});
					}
				};
				
				this.updatesListModel = {
					eof: false,
					fetchList: function(o, last) {
						o._lastitem = last;
						updatesSvc.getUpdates(o, function(list){
							self.updatesListModel.appendAll(list);
							self.updatesListModel.eof = (list && list.length > 0)? false : true;
							self._controller.refresh();
						});
					}
				};
				
				this.selectedInvite;
				
				this.accept = function() {
					svc.accept( {classid: this.selectedInvite.classid, userid: this.selectedInvite.userid, usertype:this.selectedInvite.usertype}  );
					this._controller.reload();
					
					try {
						var homeController = $get('home');
						homeController.code.classListModel.load();
					}
					catch(e) {
						if(window.console) console.log(e);
					}
				}	

				this.ignore = function() {
					MsgBox.confirm(
						"You are about to discard this invitation. Continue?", 
						function() {
							svc.ignore( {classid: self.selectedInvite.classid, userid: self.selectedInvite.userid, usertype:self.selectedInvite.usertype}  );
							self.listModel.refresh(true);
						}
					);
				}	
				
			}
		);
		</script>
	</jsp:attribute>

	<jsp:attribute name="actions">
			
	</jsp:attribute>

	<jsp:attribute name="rightpanel">
		
	</jsp:attribute>
	
	<jsp:body>
		<div class="invitation-box" r:context="main" r:visibleWhen="#{hasInvitations}">
			<div class="title">Classroom Invitation(s)</div>
			<table r:context="main" r:model="listModel" r:varName="item" r:name="selectedInvite" 
			       cellpadding="0" cellspacing="0" width="100%" class="message">
				<tr>
					<td class="msg-divider sendername">#{item.sendername}</td> 
					<td class="msg-divider" align="right">
						<button r:context="main" r:name="accept">Accept</button>
						<button r:context="main" r:name="ignore">Not Now</button>
					</td>
				</tr>
				<tr>
					<td colspan="2"><b>Class:</b> #{item.classname} / #{item.schedules}</td>
				</tr>
				<tr r:visibleWhen="#{item.msg ? true : false}">
					<td colspan="2">#{item.msg? item.msg : ''}</td>
				</tr>
			</table>
		</div>
		
		<table r:context="main" r:model="updatesListModel" r:varName="item" r:name="selectedInvite" 
		       cellpadding="0" cellspacing="0" width="100%" class="message">
			<tr>
				<td valign="top" width="50px">
					<div class="profile" style="width: 40px; height: 40px;">
						<img src="${pageContext.request.contextPath}/profile/photo.jsp?id=#{item.userid}&t=thumbnail"
							 width="40px"/>
					</div>
				</td>
				<td valign="top">
					<span class="sendername">
						#{item.firstname} #{item.middlename} #{item.lastname}
					</span>
					<span class="dt-posted"> - Posted #{item.dtposted}</span>
					<br/>
					posted a #{item.msgtype} message on 
					<a href="classroom.jsp?classid=#{item.classid}">#{item.classname}</a>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="message-hr"></div>
					<br/>
				</td>
			</tr>
		</table>
		<a r:context="main" r:name="updatesListModel.fetchNext" r:visibleWhen="#{updatesListModel.eof==false}">View More</a>
	</jsp:body>
	
</t:content>

