<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content>
   <jsp:attribute name="script">
      $(document).ready(function(){
         $(".diveditinfo").hide();
         $(".diveditpassword").hide();
      
         $(".editinfo").click(function(){
            $(".divinfo").hide();
            $(".diveditinfo").show();
         });
         $(".cancelinfo").click(function(){
            $(".diveditinfo").hide();
            $(".divinfo").show();
         });
         $(".editpassword").click(function(){
            $(".divinfo").hide();
            $(".diveditpassword").show();
         });
         $(".cancelpassword").click(function(){
            $(".diveditpassword").hide();
            $(".divinfo").show();
         });
      });
      
      $put("account-profile", 
         new function() {
            this.name = {
               firstname:"Windhel",
               lastname:"Palen",
               userid:"palen_dhel"
            };
                        
            this.password = function(o) {
               alert("change password");
            }
            
            this.save = function(o) {
               alert(this.name.userid);
            }
            
            this.savepassword = function(o) {
               alert("save password");
            }
         }
      );
   </jsp:attribute>
<jsp:body>
   <label class="header">
      Account
   </label>
   <br><br>
   <table class="account" width="70%" border="0" cellpadding="0" cellspacing="0">
      <tr>
         <td class="image" style="border-right:1px solid #cecbc6;">
            <img src="images/no_photo.jpg"/>
         </td>
         <td  valign="top">
            <div class="divinfo">
               <table border="0" cellpadding="0" cellspacing="0" >
                  <tr>
                     <td colspan="3"> 
                        <a class="button editinfo" href="#">Edit</a>
                        <a class="button editpassword" href="#">Change Password</a>
                     </td>
                  </tr>
                  <tr>
                     <td class="caption">Usernamne</td>
                     <td>:</td>
                     <td class="value"><label context="account-profile">#{name.userid}</label></td>
                  <tr>
                     <td class="caption">First Name</td>
                     <td>:</td>
                     <td class="value"><label context="account-profile">#{name.firstname}</label></td>
                  </tr>
                  <tr>
                     <td class="caption">Last Name</td>
                     <td>:</td>
                     <td class="value"><label context="account-profile">#{name.lastname}</label></td>
                  </tr>
                  <tr>
                     <td class="caption">Accounts</td>
                     <td>:</td>
                     <td class="value">-------</td>
                  </td>
               </table>
            </div>
            
            <div class="diveditinfo">
               <table border="0" cellpadding="0" cellspacing="0" >
                  <tr>
                     <td colspan="3"> 
                        <a class="button" context="account-profile" name="save" href="#">Save</a>
                        <a class="button cancelinfo" href="#">Cancel</a>
                     </td>
                  </tr>
                  <tr>
                     <td class="caption">Usernamne</td>
                     <td>:</td>
                     <td class="value">
                        <input type="text" context="account-profile" name="name.userid"/>
                     </td>
                  <tr>
                     <td class="caption">First Name</td>
                     <td>:</td>
                     <td class="value">
                        <input type="text" context="account-profile" name="name.firstname"/>
                     </td>
                  </tr>
                  <tr>
                     <td class="caption">Last Name</td>
                     <td>:</td>
                     <td class="value">
                        <input type="text" context="account-profile" name="name.lastname"/>
                     </td>
                  </tr>
                  <tr>
                     <td class="caption">Accounts</td>
                     <td>:</td>
                     <td class="value">-------</td>
                  </td>
               </table>
            </div>
            
            <div class="diveditpassword">
               <table border="0" cellpadding="0" cellspacing="0" >
                  <tr>
                     <td colspan="3"> 
                        <a class="button" context="account-profile" name="savepassword" href="#">Save</a>
                        <a class="button cancelpassword" href="#">Cancel</a>
                     </td>
                  </tr>
                  <tr>
                     <td class="caption">Old Password</td>
                     <td>:</td>
                     <td class="value">
                        <input type="password"/>
                     </td>
                  <tr>
                     <td class="caption">New Password</td>
                     <td>:</td>
                     <td class="value">
                        <input type="password"/>
                     </td>
                  </tr>
                  <tr>
                     <td class="caption">Confirm Password</td>
                     <td>:</td>
                     <td class="value">
                        <input type="password"/>
                     </td>
                  </tr>
               </table>
            </div>
            
         </td>
      </tr>
   </table>
   </jsp:body>
</t:content>
