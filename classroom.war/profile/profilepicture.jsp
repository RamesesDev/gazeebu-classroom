<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Edit Profile">
   <script>
      $put("profilepicture",
         new function() 
		 {
            var svc = ProxyService.lookup("UserProfileService");
            this._controller;
            this.upload = false;
			this.user;
			
			this.imgversion = 0;
            
            this.onload = function() {
               this.user = svc.getInfo( { objid:"${SESSION_INFO.userid}" } );
            }
            
            this.doneupload = function() {
               this._controller.reload();
            }
            
            this.change = function() {
               this.upload = true;
            }
            
            this.removepic = function() {
               this._controller.refresh();
            }
         }
      );
   </script>
   
	<style>
		.img-control a { font-size: 14pt; text-decoration: underline; }
	</style>
   
   <table class="page-form-table" width="80%" cellpadding="0" cellspacing="0" border="0">
      <tr>
         <td style="padding-bottom:50px;" width="40%">
            <table align="center">
               <tr>
                  <td align="center">
                     <label r:context="profilepicture">
                        <img src="${pageContext.servletContext.contextPath}/#{user.info.photoversion == null? 'img/profilephoto.png' : user.profile+'/medium.jpg?v='+user.info.photoversion}"/>
                     </label>
                  </td>
               </tr>
               <tr>
                  <td align="center">
					<!--
                     <a href="#" r:context="profilepicture" r:name="removepic">Remove Your Picture</a>
					-->
                  </td>
               </tr>
            </table>
         </td>
         <td class="img-control" valign="top" width="60%">
            <div r:context="profilepicture" r:visibleWhen="#{upload}">
               <input type="file" 
                      r:context="profilepicture" 
                      r:caption="Choose File"
                      r:oncomplete="doneupload"
                      r:url="profile/submit.jsp"/>
            </div>
            <input type="button" 
                   r:context="profilepicture" 
                   value="Change Photo" 
                   r:name="change" 
                   r:visibleWhen="#{!upload}">
         </td>
      </tr>
   </table>
</t:content>
