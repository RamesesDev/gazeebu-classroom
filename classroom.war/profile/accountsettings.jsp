<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Account Settings">
   <script src="js/ext/birthdate.js"></script>
   <script>
	   Registry.add({id:"editcontacts", page:"profile/editcontacts.jsp", context:"editcontacts"});
	   Registry.add({id:"editname", page:"profile/editname.jsp", context:"editname"});
	   Registry.add({id:"editemail", page:"profile/editemail.jsp", context:"editemail"});
	   Registry.add({id:"editaddress", page:"profile/editaddress.jsp", context:"editaddress"});
	   Registry.add({id:"editinfo", page:"profile/editinfo.jsp", context:"editinfo"});
	   Registry.add({id:"editrole", page:"profile/editrole.jsp", context:"editrole"});
	   
      $put("accountsettings", 
         new function() 
		 {
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
            
            this.editname = function() {
               var popup = new PopupOpener('editname', {handler:handler, user:this.user});
               popup.title="Edit Name";
               popup.options={width:350, height:150, resizable:false};
               return popup;
            }
            
            this.editemail = function() {
               var popup = new PopupOpener('editemail', {handler:handler, user:this.user});
               popup.title="Edit Email";
               popup.options={width:375, height:125, resizable:false};
               return popup;
            }
            
            this.editaddress = function () {
               var popup = new PopupOpener('editaddress', {handler:handler, user:this.user});
               popup.title="Edit Address";
               popup.options={width:375, height:150, resizable:false};
               return popup;
            }
            
            this.editinfo = function() {
               var popup = new PopupOpener('editinfo', {handler:handler, user:this.user});
               popup.title="Edit Information";
               popup.options={width:350, height:350, resizable:false};
               return popup;
            }
            
            this.editcontacts = function() {
               var popup = new PopupOpener('editcontacts', {handler:handler, user:this.user});
               popup.title="Edit Contacts";
               popup.options={width:500, height:200, resizable:false};
               return popup;
            }
            
            this.editrole = function() {
               var popup = new PopupOpener('editrole', {handler:handler, user:this.user});
               popup.title="Edit Role";
               popup.options={width:350, height:150, resizable:false};
               return popup;
            }
         }
      );
   </script>
   
   <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
      <tr class="bottom-border">
         <td class="caption left padding-bottom" width="150">
            Name
         </td>
         <td class="padding-bottom">
            <label r:context="accountsettings" style="color:#848284;font-weight:bold;">
               #{user.firstname} #{user.lastname}
            </label>
         </td>
         <td class="right padding-bottom">
            <a r:context="accountsettings" r:name="editname">
               Edit
            </a>
         </td>
      </tr>
      <tr class="bottom-border">
         <td class="caption left padding-bottom padding-top">
            Email
         </td>
         <td class="padding-bottom padding-top" style="color:#848284;font-weight:bold;">
            <label r:context="accountsettings">
               #{user.email}
            </label>
         </td>
         <td class="right padding-bottom padding-top">
            <a r:context="accountsettings" r:name="editemail">
               Edit
            </a>
         </td>
      </tr>
      <tr>
         <td class="caption left padding-top padding-bottom">
            Address
         </td>
         <td class="padding-top padding-bottom">
            <label r:context="accountsettings" style="color:#848284;font-weight:bold;">
               #{!user.homeaddress.address ? '' : user.homeaddress.address}
            </label>
         </td>
         <td class="right padding-top padding-bottom">
            <a r:context="accountsettings" r:name="editaddress">
               Edit
            </a>
         </td>
      </tr>
      <tr class="bottom-border">
         <td class="caption left padding-bottom">
            Zip
         </td>
         <td class="padding-bottom" colspan="2">
            <label r:context="accountsettings" style="color:#848284;font-weight:bold;">
               #{!user.homeaddress.zip ? '' : user.homeaddress.zip}
            </label>
         </td>
      </tr>
      <tr class="bottom-border">
         <td class="caption left padding-bottom padding-top">
            Contacts
         </td>
         <td class="padding-bottom padding-top">
            <table r:context="accountsettings" 
                  r:items="user.contacts" r:varName="contact" r:varStatus="n" 
                  class="page-form-table" width="60%" cellpadding="0" cellspacing="0" border="0">
               <tr>
                  <td style="color:#848284;font-weight:bold;">
                     #{contact.type}
                  </td>
                  <td style="color:#848284;font-weight:bold;">
                     #{contact.value}
                  </td>
               </tr>
            </table>
         </td>
         <td class="right padding-bottom padding-top">
            <a r:context="accountsettings" r:name="editcontacts">
               Edit
            </a>
         </td>
      </tr>
      <tr>
         <td class="caption left text-top padding-bottom padding-top" width="95">
            Gender
         </td>
         <td class="padding-bottom padding-top">
            <label r:context="accountsettings" style="color:#848284;font-weight:bold;">
               #{user.gender == 'M' ? 'Male' : 'Female'}
            </label>
         </td>
         <td class="right padding-bottom padding-top">
            <a r:context="accountsettings" r:name="editinfo">
               Edit
            </a>
         </td>
      </tr>
      <tr>
         <td class="caption left padding-bottom">
            Birthday
         </td>
         <td class="padding-bottom" colspan="2">
            <label r:context="accountsettings" style="color:#848284;font-weight:bold;">
               #{!user.birthdate ? '' : user.birthdate}
            </label>
         </td>
      </tr>
      <tr>
         <td class="caption left padding-bottom">
            Language
         </td>
         <td class="padding-bottom" colspan="2">
            <label r:context="accountsettings" style="color:#848284;font-weight:bold;">
               #{!user.languages ? '' : user.languages}
            </label>
         </td>
      </tr>
      <tr class="bottom-border">
         <td class="caption left padding-bottom padding-top">
            About Me
         </td>
         <td class="padding-bottom padding-top" colspan="2">
            <label r:context="accountsettings" style="color:#848284;font-weight:bold;">
               #{!user.aboutme ? '' : user.aboutme}
            </label>
         </td>
      </tr>
      <tr class="bottom-border">
         <td class="caption left padding-bottom padding-top">
           Roles
         </td>
         <td class="padding-bottom padding-top">
            <label r:context="accountsettings" style="color:#848284;font-weight:bold;">
               #{!user.roles ? '' : user.roles}
            </label>
         </td>
         <td class="right padding-bottom padding-top">
            <a r:context="accountsettings" r:name="editrole">
               Edit
            </a>
         </td>
      </tr>
   </table>
</t:content>
