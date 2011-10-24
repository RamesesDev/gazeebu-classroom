<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Edit Profile">
   <script>
      $put("profilepicture",
         new function() {
            var svc = ProxyService.lookup("AccountService");
            this.user = svc.getInfo({objid:"TCH74a18681:131daf6cf9f:-7ffe"});
            
            this.photo;
            this.phototemp = [];
            this._controller;
            this.flag = false;
            
            this.onload = function() {
               if(this.user.photo && this.user.ext) {
                  this.phototemp.url = "photos/" + this.user.photo + "/medium." + this.user.ext;
                  this.photo = this.phototemp.url;
                  
               }
            }
            
            this.doneupload = function() {
               this.phototemp = this.photo;
               this.flag = true;
               this._controller.refresh();
               //save photo here
               //save the ff:
               //this.phototemp.url
               //this.phototemp.ext
            }
            
            this.change = function() {
               this.photo = null;
               this.flag = false;
            }
            
            this.save = function() {
               alert("save");
            }
            
            this.removepic = function() {
               this.photo = null;
               this.phototemp = null;
               this._controller.refresh();
            }
         }
      );
   </script>
   
   <table class="page-form-table" width="80%" cellpadding="0" cellspacing="0" border="0">
      <tr>
         <td style="padding-bottom:50px;" width="40%">
            <table align="center">
               <tr>
                  <td align="center">
                     <label r:context="profilepicture">
                        <img src="#{phototemp.url? phototemp.url : 'img/no_photo.jpg'}"/>
                     </label>
                  </td>
               </tr>
               <tr>
                  <td align="center">
                     <a href="#" r:context="profilepicture" r:name="removepic">Remove Your Picture</a>
                  </td>
               </tr>
            </table>
         </td>
         <td valign="top" width="60%">
            <div r:context="profilepicture" r:visibleWhen="#{!photo}">
               <input type="file" 
                      r:context="profilepicture" 
                      r:name="photo"
                      r:caption="Choose File"
                      r:oncomplete="doneupload"
                      r:url="profile/submit.jsp"/>
            </div>
            <input type="button" 
                   r:context="profilepicture" 
                   value="Change Photo" 
                   r:name="change" 
                   r:visibleWhen="#{photo}">
         </td>
      </tr>
   </table>
</t:content>
