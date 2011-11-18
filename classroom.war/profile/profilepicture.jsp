<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Edit Profile">
   <script>
	   $put("profilepicture",
         new function() 
		 {
            this._controller;

            this.doneupload = function() {
               this._controller.reload();
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
                    <img src="profile/photo.jsp?id=${SESSION_INFO.userid}&t=medium&v=${SESSION_INFO.photoversion}"/>
                  </td>
               </tr>
            </table>
         </td>
         <td class="img-control" valign="top" width="60%">
			<input type="file" 
				  r:context="profilepicture" 
				  r:caption="Change Photo"
				  r:oncomplete="doneupload"
				  r:url="profile/upload_photo.jsp"/>
         </td>
      </tr>
   </table>
</t:content>
