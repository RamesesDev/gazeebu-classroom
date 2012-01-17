<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="contact">
	<jsp:attribute name="head">
		<script>
			Registry.add({id:"editcontacts", page:"profile/editcontacts.jsp", context:"editcontacts"});
		   
			$put("contact", 
				new function() {
					var self = this;
					var svc = ProxyService.lookup("UserProfileService");
					this.user;
					this._controller;
				
					this.onload = function() {
						self.user = svc.getInfo({ objid:"${SESSION_INFO.userid}" });
					}
				
					var handler = function() {
						self.onload();
						self._controller.refresh();
					}

					this.editcontacts = function() {
						var popup = new PopupOpener('editcontacts', {handler:handler, user:this.user});
						popup.title="Edit Contacts";
						popup.options={width:500, height:300, resizable:false};
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
					Contacts
				</span>
				<span class="controls">
					<a r:context="contact" r:name="editcontacts">
					   Edit
					</a>
				</span>
			</div>

			<table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0"
				   r:context="contact" 
				   r:items="user.contacts" 
				   r:varName="contact" 
				   r:varStatus="n">
			   <tr>
				  <td class="caption" style="padding-right:10px;" width="20%">
					 #{contact.type}
				  </td>
				  <td style="color:#848284;font-weight:bold;">
					 #{contact.value}
				  </td>
			   </tr>
			</table>
		</div>
	</jsp:body>
</t:content>

