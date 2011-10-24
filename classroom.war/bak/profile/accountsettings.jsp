<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>



<t:content title="Account Settings">
	${SESSIONID}

   <script>
      $put("accountsettings", 
         new function() {
            //var svc = ProxyService.lookup("AccountService");
            //this.user = svc.getUser({uid:"00001"});
            this.user = {firstname:"elmo",lastname:"nazareno",primaryemail:"yahoo.com"}
            this.savename = function() {
               alert("save");
            }
            
			this.editname = false;
			this.showEditName = function() {
				alert('editname');
				this.editname = !this.editname;
			}
         }
      );
   </script>

   <label class="header">
      Account Settings
   </label>
   <br><br>
   <table width="80%" border="0" cellpadding="0" cellspacing="0">
      <tr>
         <th colspan="3">
            <table class="page-data-table" width="100%" border="0" cellpadding="0" cellspacing="0">
               <tr>
                  <th colspan="3">
                  </th>
               </tr>
            </table>
         </th>
      </tr>
      <tr>
         <td colspan="3">
            
			<div class="divname" r:context="accountsettings" r:visibleWhen="#{!editname}">
            <table class="page-data-table" width="100%" cellpadding="0" cellspacing="0" border="0">
               <tr>
                  <td class="caption" width="20%">Name</td>
                  <td><label r:context="accountsettings">#{user.firstname} #{user.lastname}</label></td>
                  <td class="right"><a r:context="accountsettings" r:name="showEditName">Edit</a></td>
               </tr>
            </table>
            </div>
			
			
            <div class="diveditname" style="border-bottom:1px solid #cecfce;" r:context="accountsettings" r:visibleWhen="#{editname}">
               <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                     <td>
                        <b>Name</b>
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
                  <tr>
                     <td class="caption right text-top">
                     </td>
                     <td class="text-top">
                        <input type="button" class="button savename" r:context="accountsettings" r:name="savename" value="Save"/>
                     </td>
                  </tr>
               </table>
            </div>
         </td>
      </tr>
      <tr>
         <td colspan="3">
            <table class="page-data-table" width="100%" cellpadding="0" cellspacing="0" border="0">
               <tr>
                  <td class="caption" width="20%">User Id</td>
                  <td>
                     <label r:context="accountsettings">#{user.primaryemail}</label>
                  </td>
                  <td class="right"><a href="#">Edit</a></td>
               </tr>
            </table>
         </td>
      </tr>
      <tr>
   </table>
</t:content>
