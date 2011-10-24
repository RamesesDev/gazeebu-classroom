<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Account Settings">
   <script>
      $put("accountsettings", 
         new function() {
            var svc = ProxyService.lookup("AccountService");
            this.user;
		    this.editName = false;
			this.editemail = false;
			   
			this.onload = function() {
				this.user = svc.getInfo( { objid: "${SESSION_INFO.userid}" } );
			}
			
            this.saveName = function() {
               alert("save name");
               this.showEditName();
            }
			   this.showEditName = function() {
				   this.editname = !this.editname;
			   }
			   
			   this.saveemail = function() {
			      alert("save email");
			      this.showEditEmail();
			   }
			   this.showEditEmail = function() {
			      this.editemail = !this.editemail;
			   }
         }
      );
   </script>
   <table width="80%" border="0" cellpadding="0" cellspacing="0">
      <tr>
         <td colspan="3">
			   <div r:context="accountsettings" r:visibleWhen="#{!editname}">
               <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                     <td class="caption right" width="20%">Name: &nbsp&nbsp</td>
                     <td><label r:context="accountsettings">#{user.firstname} #{user.lastname}</label></td>
                     <td class="right"><a r:context="accountsettings" r:name="showEditName">Edit</a></td>
                  </tr>
               </table>
            </div>
			
            <div style="border-bottom:1px solid #cecfce;" r:context="accountsettings" r:visibleWhen="#{editname}">
               <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                     <td>
                        <b>Name</b>
                     </td>
                     <td class="right">
                        <input type="button" class="button" r:context="accountsettings" r:name="saveName" value="Save"/>
                        <input type="button" class="button" r:context="accountsettings" r:name="showEditName" value="Cancel"/>
                     </td>
                  </tr>
                  <tr>
                     <td class="caption right text-top padding-top">First Name: &nbsp&nbsp</td>
                     <td class="text-top padding-top">
                        <input type="text" class="text" r:context="accountsettings" r:name="user.firstname"/>
                     </td>
                  </tr>
                  <tr>
                     <td class="caption right text-top">Last Name: &nbsp&nbsp</td>
                     <td class="text-top">
                        <input type="text" class="text" r:context="accountsettings" r:name="user.lastname"/>
                     </td>
                  </tr>
               </table>
            </div>
         </td>
      </tr>
      <tr>
         <td colspan="3">
            <div r:context="accountsettings" r:visibleWhen="#{!editemail}">
               <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                     <td class="caption right" width="20%">Email: &nbsp&nbsp</td>
                     <td>
                        <label r:context="accountsettings">#{user.email}</label>
                     </td>
                     <td class="right"><a r:context="accountsettings" r:name="showEditEmail">Edit</a></td>
                  </tr>
               </table>
            </div>
            
            <div style="border-bottom:1px solid #cecfce;border-top:1px solid #cecfce;" r:context="accountsettings" r:visibleWhen="#{editemail}">
               <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                     <td>
                        <b>E-mail Address</b>
                     </td>
                     <td class="right">
                        <input type="button" class="button" r:context="accountsettings" r:name="saveEmail" value="Save"/>
                        <input type="button" class="button" r:context="accountsettings" r:name="showEditEmail" value="Cancel"/>
                     </td>
                  </tr>
                  <tr>
                     <td class="caption right text-top padding-top">Email: &nbsp&nbsp</td>
                     <td class="text-top padding-top">
                        <input type="text" class="text" r:context="accountsettings" r:name="user.email"/>
                     </td>
                  </tr>
               </table>
            </div>
         </td>
      </tr>
      <tr>
   </table>
</t:content>
