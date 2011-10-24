<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content>
   <jsp:attribute name="script">
      $put("profilepicture",
         new function() {
            this.name = {
               firstname:"Windhel",
               middlename:"Gilos",
               lastname:"Palen",
               userid:"palen_dhel",
               email:"palen_dhel@yahoo.com.ph",
               imscreenname:"palen_dhel",
               mobileno:"09335588774",
               address:"Camparville Buhisan Cebu City",
               citytown:"Cebu, Philippines",
               zip:"",
               neighborhood:"",
               website:"",
               currentcity:"Cebu City",
               hometowncity:"Cebu City"
            };
            
            this.photo;
            this.phototemp;
            this._controller;
            
            this.doneupload = function() {
               this.phototemp = this.photo;
               this._controller.refresh();
            }
            
            this.change = function() {
               this.photo = null;
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
   </jsp:attribute>
<jsp:body>
   <label class="header" r:context="profilepicture">
      #{name.firstname} #{name.middlename} #{name.lastname} <img src="images/next.png"> Edit Profile
   </label>
   <br><br>
   <table class="page-form-table" width="80%" cellpadding="0" cellspacing="0" border="0">
      <tr>
         <td style="padding-bottom:50px;" width="40%">
            <table align="center">
               <tr>
                  <td align="center">
                     <label r:context="profilepicture">
                        <img src="#{phototemp? phototemp.url : 'images/no_photo.jpg'}"/>
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
            <div r:context="profilepicture"  r:visibleWhen="#{!photo}">
               <input type="file" 
                      r:context="profilepicture" 
                      r:name="photo"
                      r:caption="Choose File"
                      r:oncomplete="doneupload"
                      r:url="account/submit.jsp"/>
            </div>
            <input type="button" 
                   r:context="profilepicture" 
                   r:value="Change Photo" 
                   r:name="change" 
                   r:visibleWhen="#{photo}">
         </td>
      </tr>
      <!--
      <tr>
         <td style="padding-top:40px;">
            Row of photos top of profile 
            Unhide All
         </td>
      </tr>
      -->
   </table>
   </jsp:body>
</t:content>
