<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>


<t:content title="News">
	<jsp:attribute name="actions">
			
	</jsp:attribute>

	<jsp:attribute name="rightpanel">
		<div style="font-family:helvetica;font-size:1.3em;color:red;font-weight:bolder;">Deals for the day</div>
		<br>
		<i>No deals today in your area</i>
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
		.msg-divider {
			padding-top: 5px;
			border-top:1px sold lightgrey;
		}
	</jsp:attribute>
	
	<jsp:attribute name="head">
		<script type="text/javascript">
		$put("main", 
			new function() {
				
				var svc = ProxyService.lookup( "ClassInvitationService" );
				this._controller;
				
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
		</script>
	</jsp:attribute>
	
	
	<jsp:body>
		<table r:context="main" r:model="listModel" r:varName="item" r:name="selectedInvite" cellpadding="0" cellspacing="0" width="80%">
			<tr>
				<td style="font-size:14px;color:darkslateblue;font-weight:bolder;" class="msg-divider">#{item.sendername}</td> 
				<td valign="top" rowspan="3"  class="msg-divider">
					<input type="button" r:context="main" r:name="accept" value="Accept" /> 
					<input type="button" r:context="main" r:name="ignore" value="Not Now" /> 
				</td>
			</tr>
			<tr>
				<td valign="top"><b>Class:</b> #{item.classname} #{item.schedules}</td>
			</tr>
			<tr>
				<td valign="top">#{item.msg? item.msg : ''}</td>
			</tr>
		</table>
	</jsp:body>
	
</t:content>

