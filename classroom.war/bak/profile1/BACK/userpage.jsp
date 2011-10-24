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
               this.typing = false;
               this.text = "text";
               this._controller;
               
               this.istyping = function() {
                  this.typing = !this.typing;
                  this._controller.refresh();
                  document.getElementById("textarea").focus();
               }
               
               this.share = function() {
                  alert(this.text);
               }
               
               this.addRecepient = function() {
                  alert("Add a Recepient");
               }
               
               this.atestfunction = function() {
                  alert("this is a test function");
               }
               
            }
         );
         
         function stretch(element) {
            var h = element.scrollHeight;
            element.style.height = 0;
            if(h > element.offsetHeight)
                element.style.height = element.scrollHeight + 'px';
         }
         
         function pm_mouseIn() {
            document.getElementById("pm1").src = "img/pm_icon_color.png";
            document.getElementById("pm").src = "img/pm_icon_color.png";
         }
         
         function pm_mouseOut() {
            document.getElementById("pm1").src = "img/pm_icon.png";
            document.getElementById("pm").src = "img/pm_icon.png";
         }
         
         function an_mouseIn() {
            document.getElementById("announcement1").src = "img/announcements_color.png";
            document.getElementById("announcement").src = "img/announcements_color.png";
         }
         
         function an_mouseOut() {
            document.getElementById("announcement1").src = "img/announcements.png";
            document.getElementById("announcement").src = "img/announcements.png";
         }
         
         document.getElementById("pm1").src = "img/pm_icon.png";
         document.getElementById("announcement1").src = "img/announcements.png";
         document.getElementById("pm").src = "img/pm_icon.png";
         document.getElementById("announcement").src = "img/announcements.png";
      </script>
      
      <!-- POSTING A COMMENT HERE -->
      <div style="float:left;">
         <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
               <td>
                  <div style="margin-bottom:10px;font-weight:bold;">
                     Post A Comment
                  </div>
               </td>
            </tr>
            <tr>
               <td colspan="2">
                  <div r:context="userpage" 
                        r:visibleWhen="#{!typing}"
                        r:action="istyping"
                        style="border:1px solid #a5aa84;">
                     <input type="text" r:context="userpage" value="Share what's new..."
                           style="border:1px solid white;padding:2px;outline:none;font-size:11px;font-weight:normal;padding:3px;" 
                           size="70"/>
                     <div style="float:right;">
                           <input type="image"
                                 style="padding:3px;margin:3px;"
                                 r:context="userpage"
                                 id="pm1"
                                 r:action="atestfunction" 
                                 onmouseover="pm_mouseIn()"
                                 onmouseout="pm_mouseOut()"/>
                           <input type="image"
                                 style="padding:3px;margin:3px;"
                                 r:context="userpage"
                                 id="announcement1"
                                 r:action="atestfunction" 
                                 onmouseover="an_mouseIn()"
                                 onmouseout="an_mouseOut()"/>
                     </div>
                  </div>
                  <div r:context="userpage" 
                        r:visibleWhen="#{typing}">
                     <div style="border:1px solid #a5aa84;">
                        <table class="page-form-table">  
                           <tr>
                              <td valign="top">
                                 <textarea rows="1" cols="80" 
                                          r:context="userpage" 
                                          r:name="text"
                                          id="textarea"
                                          onkeyup="stretch(this)"
                                          onkeydown="stretch(this)">
                                 </textarea>
                              </td>
                              <td valign="top">
                                 <a r:context="userpage" 
                                    r:name="istyping" 
                                    class="close">
                                    X
                                 </a>
                              </td>
                           </tr>
                        </table>
                        <div class="right">
                           <!-- ADD ADDITIONAL BUTTON HERE -->
                           <input type="image"
                                 style="padding:3px;margin:3px;"
                                 r:context="userpage"
                                 id="pm"
                                 r:action="atestfunction" 
                                 onmouseover="pm_mouseIn()"
                                 onmouseout="pm_mouseOut()"/>
                           <input type="image"
                                 style="padding:3px;margin:3px;"
                                 r:context="userpage"
                                 id="announcement"
                                 r:action="atestfunction" 
                                 onmouseover="an_mouseIn()"
                                 onmouseout="an_mouseOut()"/>
                        </div>
                     </div>
                     <div style="border:1px solid #a5aa84;margin-top:10px;margin-bottom:10px;padding:2px;">
                        <!-- RECEPIENTS HERE -->
                        RecepientPerson01, RecepientPerson02 
                        <input type="button" 
                              r:context="userpage"
                              r:name="addRecepient"
                              value="Add Recepient"/>
                     </div>
                     <input type="button" r:context="userpage" r:name="share" value="Share"/>
                  </div>
               </td>
            </tr>
          </table>
          
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
