<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content>
   <jsp:attribute name="title">
      <table class="page-form-table" width="80%" cellpadding="0" cellspacing="0" border="0">
         <tr>
            <td rowspan="4" width="60" style="padding-right:10px;">
               <label r:context="userpage">
                        <img src="#{photo}"/>
                     </label>
            </td>
         </tr>
         <tr>
            <td class="caption" style="font-size:14px;">
               <label r:context="userpage">#{user.firstname} #{user.lastname}</label>
            </td>
            <td>
               <img src="img/phone.png" style="padding-right:5px;"/>093333333333
            </td>
         </tr>
         <tr>
            <td>
               Teacher <!-- USER TYPE HERE-->
            </td>
            <td>
               <img src="img/email.png" style="padding-right:5px;"/>
               <label r:context="userpage">#{user.email}</label>
            </td>
         </tr>
      </table>
   </jsp:attribute>
   
   <jsp:body>
      <script src="js/ext/birthdate.js"></script>
      <script>
         var self;
         $put("userpage",
            new function() {
               self = this;
               var svc = ProxyService.lookup("AccountService");
               this.user = svc.getInfo({objid:"TCH74a18681:131daf6cf9f:-7ffe"});
               
               this.photo = "photos/" + this.user.photo + "/small.jpg";
               this.text = "text";
               this._controller;
               
               this.typing = false;
               this.istyping = function() {
                  this.typing = true;
                  document.getElementById("textarea").rows = "2";
                  document.getElementById("textarea").style.height = 38+24;
               }
               
               this.nottyping = function() {
                  this.typing = false;
                  document.getElementById("textarea").rows = "1";
                  this.text = "";
                  document.getElementById("textarea").style.height = 24;
               }
               
               this.share = function() {
                  alert(this.text);
               }
               
               this.addPerson = function() {
                  alert("Add a Person");
               }
               
               this.atestfunction = function() {
                  alert("this is a test function");
               }
               
            }
         );
         
         function pm_mouseIn() {
            document.getElementById("pm").src = "img/pm_icon_color.png";
         }
         
         function pm_mouseOut() {
            document.getElementById("pm").src = "img/pm_icon.png";
         }
         
         document.getElementById("pm").src = "img/pm_icon.png";
         
         function an_mouseIn() {
            document.getElementById("an").src = "img/announcements_color.png";
         }
         
         function an_mouseOut() {
            document.getElementById("an").src = "img/announcements.png";
         }
         
         document.getElementById("an").src = "img/announcements.png";
         document.getElementById("pm").src = "img/pm_icon.png";
      </script>
      
      <!-- POSTING A COMMENT HERE -->
      <div style="float:left;">
         <t:textarea context="userpage">
            <jsp:attribute name="textareacontrols">
               <input type="image"
                     value="test" 
                     id="pm"
                     r:context="userpage"
                     r:action="atestfunction"
                     onmouseover="pm_mouseIn()"
                     onmouseout="pm_mouseOut()"/>
               <input type="image"
                     value="test" 
                     id="an"
                     r:context="userpage"
                     r:action="atestfunction"
                     onmouseover="an_mouseIn()"
                     onmouseout="an_mouseOut()"/>
            </jsp:attribute>
            <jsp:body>
               <div r:context="userpage" 
                     r:visibleWhen="#{typing}" 
                     style="border:1px solid #a5aa84;margin-top:10px;margin-bottom:10px;padding:3px;">
                  Person01, Person02 <input type="button" value="Add Person" r:context="userpage" r:name="addPerson">
               </div>
               <input type="button" value="Share" r:context="userpage" r:name="share" r:visibleWhen="#{typing}">
            </jsp:body>
         </t:textarea>
         
          <!-- POSTED MESSAGES ARE SHOW HERE -->
          <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
               <td rowspan="4" valign="top" class="padding-top">
                  <img src="img/announcements.png"/>
               </td>
            </tr>
            <tr>
               <td valign="top" class="padding-top">
                  Monday, August 1, 2001
               </td>
            </tr>
            <tr>
               <td>
                  This is an announcement.
               </td>
            </tr>
            <tr>
               <td>
                  The Details of the announcement.
               </td>
            </tr>
          </table>
          
          <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
               <td rowspan="4" valign="top" class="padding-top">
                  <img src="img/pm_icon.png"/>
               </td>
            </tr>
            <tr>
               <td valign="top" class="padding-top">
                  Monday, August 1, 2001
               </td>
            </tr>
            <tr>
               <td>
                  This is a Private Message.
               </td>
            </tr>
            <tr>
               <td>
                  The Details of the Private Message.
               </td>
            </tr>
          </table>
          
          <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
               <td rowspan="4" valign="top" class="padding-top">
                  <img src="img/exam_result.png"/>
               </td>
            </tr>
            <tr>
               <td valign="top" class="padding-top">
                  Monday, August 1, 2001
               </td>
            </tr>
            <tr>
               <td>
                  This is an Exam Result.
               </td>
            </tr>
            <tr>
               <td>
                  The Details of the Exam Result.
               </td>
            </tr>
          </table>
      </div>
      
      <!-- ACTIVITIES HERE -->
      <div style="float:right;" class="page-form-table">
         <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
               <th class="center" colspan="2">Recent Activities</th>
            </tr>
            <tr>
               <td rowspan="4">
                  picture here
               </td>
            </tr>
            <tr>
               <td>
                  activity title here
               </td>
            </tr>
            <tr>
               <td>
                  activity details here
               </td>
            </tr>
         </table>
      </div>
   </jsp:body>
</t:content>
