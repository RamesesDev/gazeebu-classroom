<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Mobile Settings">
   <script>
      $register({id:"customkeyword", page:"profile/customkeyword.jsp", context:"customkeyword"});
      $put("mobilesettings",
         new function() {
            this.entity = [];
            this.flag;
            this.customkeywords = [
               {keyword:"GZ A1", key:"A", classurl:"class1"}
            ];
            
            this.createcustomkeyword = function() {
               var popup = new PopupOpener('customkeyword', {customkeywords:this.customkeywords, handler:this.handler});
               popup.title="Create a Custom Keyword";
               popup.options={width:300, height:175, resizable:false};
               return popup;
            }
            
            this._controller;
            this.handler = function() {
               this._controller.refresh();
            }
            
            this.save = function() {
               alert("save");
            }
            this.remove = function() {
               this.customkeywords.splice(this.flag, 1);
            }
         }
      );
   </script>
   <div style="float:top;">
      <table class="page-form-table" 
            style="border-bottom:1px solid #a5aa84;"
            width="100%" cellpadding="0" cellspacing="0" border="0" >
         <tr>
            <td>
               <b>Subscription</b>
            </td>
         </tr>
         <tr>
            <td style="padding-left:15px;">
               <input type="checkbox" context="mobilesettings" name="entity.announcement" checkedValue="1" uncheckedValue="0""/>Announcement
            </td>
         </tr>
         <tr>
            <td style="padding-left:15px;">
               <input type="checkbox" context="mobilesettings" name="entity.privatemessage" checkedValue="1" uncheckedValue="0""/>Private Message
            </td>
         </tr>
         <tr>
            <td style="padding-left:15px;">
               <input type="checkbox" context="mobilesettings" name="entity.examresults" checkedValue="1" uncheckedValue="0""/>Exam Results
            </td>
         </tr>
         <tr>
            <td style="padding-left:15px; padding-bottom:15px; margin-bottom:15px;">
               <input type="button" r:context="mobilesettings" r:name="save" value="Save Settings"/>
            </td>
         </tr>
      </table>
   </div>
   <div style="float:top; padding-top:15px;">
      <table class="page-form-table" 
            r:context="mobilesettings"
            r:items="customkeywords"
            r:varName="keyword"
            r:varStatus="n"
            width="50%" cellpadding="0" cellspacing="0" border="0">
         <thead>
            <tr>
               <td colspan="3">
                  Sending a Message <input type="button" r:context="mobilesettings" r:name="createcustomkeyword" value="Create a Custom Keyword"/>
               </td>
            </tr>
            <tr>
               <td><b>Keyword</b></td>
               <td><b>Code</b></td>
               <td></td>
            </tr>
         </thead>
         <tbody>
            <tr>
               <td>
                  #{keyword.keyword}
               </td>
               <td>
                  #{keyword.key} #{keyword.classurl}
               </td>
               <td>
                  <a r:context="mobilesettings" 
                     r:name="remove" 
                     r:params="{flag:' + #{n} +  '"
                     class="close">
                     X
                  </a>
               </td>
            </tr>
         </tbody>
      </table>
   </div>
</t:content>
