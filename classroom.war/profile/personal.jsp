<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="General Information">
	<jsp:attribute name="head">
		<script>
			Registry.add({id:"editaddress", page:"profile/editaddress.jsp", context:"editaddress"});
			Registry.add({id:"editinfo", page:"profile/editinfo.jsp", context:"editinfo"});
		   
			$put("personal", 
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

					this.editaddress = function () {
						var popup = new PopupOpener('editaddress', {handler:handler, user:this.user});
						popup.title="Edit Address";
						popup.options={width:360, height:160, resizable:false};
						return popup;
					}
				
					this.editinfo = function() {
						var popup = new PopupOpener('editinfo', {handler:handler, user:this.user});
						popup.title="Edit Information";
						popup.options={width:500, height:450, resizable:false};
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
					Personal Information
				</span>
				<span class="controls">
					<a r:context="personal" r:name="editinfo">
					   Edit
					</a>
				</span>
			</div>
			<table class="page-form-table" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="caption padding-bottom" style="padding-right:10px;font-size:11px;" width="100">
						Name
					</td>
					<td class="padding-bottom">
						<label r:context="personal" style="color:#848284;font-weight:bold;">
						  #{user.firstname} #{user.lastname}
					   </label>
					</td>
				</tr>
				<tr>	
					<td class="caption padding-bottom" style="padding-right:10px;font-size:11px;" >
						Email
					</td>
					<td class="padding-bottom" >
						<label r:context="personal" style="color:#848284;font-weight:bold;">
							  #{user.email}
						   </label>
					</td>
				</tr>
				<tr>
					<td class="caption padding-bottom" style="padding-right:10px;font-size:11px;">
						Gender
					</td>
					<td class="padding-bottom">
						<label r:context="personal" style="color:#848284;font-weight:bold;">
							   #{user.gender == 'M' ? 'Male' : 'Female'}
							</label>
					</td>
				</tr>
				<tr>
					<td class="caption padding-bottom" style="padding-right:10px;font-size:11px;">
						Birthday
					</td>
					<td class="padding-bottom">
						<label r:context="personal" style="color:#848284;font-weight:bold;">
							  #{!user.birthdate ? '' : user.birthdate}
						   </label>
					</td>
				</tr>
				<tr>
					<td class="caption padding-bottom" style="padding-right:10px;font-size:11px;">
						Language
					</td>
					<td class="padding-bottom">
						<label r:context="personal" style="color:#848284;font-weight:bold;">
							  #{!user.languages ? '' : user.languages}
						   </label>
					</td>
				</tr>
				<tr>
					<td class="caption padding-bottom" style="padding-right:10px;font-size:11px;">
						About Me
					</td>
					<td class="padding-bottom">
						<label r:context="personal" style="color:#848284;font-weight:bold;">
								#{!user.aboutme ? '' : user.aboutme}
							</label>
					</td>
				</tr>
			</table>

			<div class="section">
				<span class="sectiontitle">
					Address Information
				</span>
				<span class="controls">
					<a r:context="personal" r:name="editaddress">
					   Edit
					</a>
				</span>
			</div>
			<table class="page-form-table" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="caption padding-bottom" style="padding-right:10px;font-size:11px;" width="100">
						Home Address
					</td>
					<td class="padding-bottom">
						<label r:context="personal" style="color:#848284;font-weight:bold;">
								#{!user.homeaddress.address ? '' : user.homeaddress.address}
							</label>
					</td>
				</tr>
				<tr>
					<td class="caption padding-bottom" style="padding-right:10px;font-size:11px;">
						Zip
					</td>
					<td class="padding-bottom" >
						<label r:context="personal" style="color:#848284;font-weight:bold;">
							  #{!user.homeaddress.zip ? '' : user.homeaddress.zip}
						   </label>
					</td>
				</tr>
			</table>
		</div>
	</jsp:body>
</t:content>

