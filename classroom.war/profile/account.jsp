<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Account Settings">
	<jsp:attribute name="head">
		<script>
			Registry.add({id:"editpassword", page:"profile/editpassword.jsp", context:"editpassword"});
			Registry.add({id:"editsecurity", page:"profile/editsecurity.jsp", context:"editsecurity"});
			Registry.add({id:"editrole", page:"profile/editrole.jsp", context:"editrole"});

			$put("account", 
				new function() {
					var self = this;
					var svc = ProxyService.lookup("UserProfileService");
					this.user;
					this._controller;
				
					this.onload = function() {
						this.user = svc.getInfo({ objid:"${SESSION_INFO.userid}" });
						if( this.user.homeaddress == null ) this.user.homeaddress = {};
					}
				
					var handler = function() {
						self.onload();
						self._controller.refresh();
					}

					this.editrole = function() {
						var popup = new PopupOpener('editrole', {handler:handler, user:this.user});
						popup.title="Edit Role";
						popup.options={width:350, height:170, resizable:false};
						return popup;
					}
				
					this.editpassword = function() {
						var popup = new PopupOpener('editpassword', {handler:handler, user:this.user});
						popup.title="Edit Password";
						popup.options={width:500, height:210, resizable:false};
						return popup;
					}
					
					this.editsecurity = function() {
						var popup = new PopupOpener('editsecurity', {handler:handler, user:this.user});
						popup.title="Edit Account Security";
						popup.options={width:550, height:300, resizable:false};
						return popup;
					}
				}
			);
		</script>
	</jsp:attribute>
   
	<jsp:body>
		<div class="form-panel">
			<div class="section">
				<span class="sectiontitle">
					Login Account
				</span>
				<span class="controls">
					<a r:context="account" r:name="editpassword">
						Change Password
					</a>
				</span>
			</div>
			<table class="page-form-table" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td colspan="2" style="align:center;">
						<table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0"
								style="margin-left:20px;">
							<tr>
									<td class="caption padding-bottom" style="padding-right:10px;font-size:11px;" width="100">
										User Id
									</td>
									<td class="padding-bottom">
										<label r:context="account" style="color:#848284;font-weight:bold;">
										   #{user.username}
										</label>
									</td>
								</tr>
								<tr>
									<td class="caption padding-bottom" style="padding-right:10px;font-size:11px;">
										Password
									</td>
									<td class="padding-bottom">
										************
									</td>
								</tr>
						</table>
					</td>
				</tr>
			</table>
			
			<div class="section">
				<span class="sectiontitle">
					Security Question
				</span>
				<span class="controls">
					<a r:context="account" r:name="editsecurity">
					   Edit
					</a>
				</span>
			</div>
			<table class="page-form-table" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td colspan="2" style="align:center;">
						<table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0"
								style="margin-left:20px;">
							<tr>
									<td class="caption padding-bottom" style="padding-right:10px;font-size:11px;" width="100">
										Question
									</td>
									<td class="padding-bottom">
										<label r:context="account" style="color:#848284;font-weight:bold;">
										   #{user.info.security_question? user.info.security_question : ''}
										</label>
									</td>
								</tr>
								<tr>
									<td class="caption padding-bottom" style="padding-right:10px;font-size:11px;">
										Answer
									</td>
									<td class="padding-bottom">
										<label r:context="account" style="color:#848284;font-weight:bold;">
										   #{user.info.security_answer? user.info.security_answer : ''}
										</label>
									</td>
								</tr>
						</table>
					</td>
				</tr>
			</table>
			
			<div class="section">
				<span class="sectiontitle">
					Role
				</span>
				<span class="controls">
					<a r:context="account" r:name="editrole">
					   Edit
					</a>
				</span>
			</div>
			<table class="page-form-table" cellpadding="0" cellspacing="0" border="0">
				<tr>				
					<td colspan="2" style="align:center;">
						<table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0
								style="margin-left:20px;">
							<tr>
								<td class="caption padding-bottom" style="padding-right:10px;font-size:11px;" width="100">
									Roles
								</td>
								<td class="padding-bottom">
									<label r:context="account" style="color:#848284;font-weight:bold;">
										#{!user.roles ? '' : user.roles.replace('|',', ')}
									</label>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</jsp:body>
</t:content>

