<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>


<t:content title="Home">
	<jsp:attribute name="actions">
			
	</jsp:attribute>

	<jsp:attribute name="rightpanel">
		Sponsored Ads
	</jsp:attribute>
	
	<jsp:attribute name="style">
		.classhead td {
			padding:4px;
			font-size: 12px;
		}
		.classhead .col {
			background-color: lightgrey;
			font-weight:bolder;
		}
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put("main", 
			new function() {
				this._controller;
				var svc = ProxyService.lookup( "ClassInvitationService" );
				this.listModel = {
					rows: 10,
					fetchList: function(o) {
						return svc.getInvitations(o);
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
					if(confirm("You are about to discard this invitation. Continue?")) {
						svc.ignore( {classid: this.selectedInvite.classid, userid: this.selectedInvite.userid, usertype:this.selectedInvite.usertype}  );
						this.listModel.refresh(true);
					}
				}	
				
			}
		);	
	</jsp:attribute>
	
	
	<jsp:body>
		<h2>Pending Invitations</h2>
		<table r:context="main" r:model="listModel" r:varName="item" r:name="selectedInvite" cellpadding="0" cellspacing="0" width="80%">
			<tr>
				<td valign="top"> #{item.classname} #{item.schedules}</td>
				<td valign="top" rowspan="2">
					<input type="button" r:context="main" r:name="accept" value="Accept" /> 
					<input type="button" r:context="main" r:name="ignore" value="Ignore" /> 
				</td>
			</tr>
			<tr>
				<td valign="top">#{item.msg} send by #{item.sendername}</td>
			</tr>
		</table>
	</jsp:body>
	
</t:content>

