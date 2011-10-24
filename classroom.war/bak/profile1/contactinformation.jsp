<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Edit Profile">
   <script>
      Registry.add({id:"addemail", page:"account/addemail.jsp", context:"addemail"});
      $put("contactinformation",
         new function() {
            var svc = ProxyService.lookup("AccountService");
            this.user = [];
            this.contacts = [];
            
            this.flag=0;
           
            this.onload = function() {
               this.user = svc.getInfo({objid:"TCH74a18681:131daf6cf9f:-7ffe"});
               this.contacts = this.user.contacts;
            }
            
            this.phonetypes = [
               "MOBILE", "LANDLINE"
            ];
            
            this.addEmail = function() {
               var popup = new PopupOpener('addemail', {emails:this.emails});
               popup.title="Add Email";
               popup.options={width:375, height:200, resizable:false};
               return popup;
            }
            this.deleteEmail = function() {
               this.emails.splice(this.flag, 1);
            }
            
            this.save = function() {
               for(var i=0 ; i<this.screennames.length ; i++) {
                  alert("> " + this.screennames[i].email);
               }
            
               alert("save");
            }
            
            this.addanothercontact = function() {
               this.contacts.push({name:"", type:"", phoneno:""});
            }
            this.deleteContact = function() {
               this.contacts.splice(this.flag, 1);
            }
            
         }
      );
   </script>
   <table class="page-form-table" width="80%" cellpadding="0" cellspacing="0" border="0">
      
      <tr class="bottom-border">
         <td class="caption right text-top padding-bottom padding-top">Contacts: &nbsp&nbsp</td>
         <td class="padding-bottom padding-top">
            <table r:context="contactinformation" 
                  r:items="contacts" 
                  r:varName="contact" 
                  r:varStatus="n" 
                  class="inner-table" 
                  width="100%" 
                  cellpadding="0" 
                  cellspacing="0" 
                  border="0">
               <tr>
                  <td>
                     <input type="text" class="text" value="#{contact.name}"/>
                     <select r:context="contactinformation" r:items="phonetypes" r:name="#{contact.type}"></select>
                     <input type="text" class="text" value="#{contact.phoneno}"/>
                  </td>
                  <td class="controls">
                     <a r:context="contactinformation" 
                        r:name="deleteContact" 
                        r:params="{flag:' + #{n} +  '"
                        class="close">
                        X
                     </a>
                  </td>
               </tr>
            </table>
            <a href="#" r:context="contactinformation" r:name="addanothercontact">Add another Contact</a>
            <br>
         </td>
      </tr>
      <tr>
         <td class="caption right text-top padding-top">Address: &nbsp&nbsp</td>
         <td class="text-top padding-top"> 
            <input type="text" class="text" r:context="contactinformation" r:name="user.address" size="60%">
         </td>
      </tr>
     <tr>
         <td class="caption right text-top">Zip: &nbsp&nbsp</td>
         <td class="text-top"> 
            <input type="text" class="text" r:context="contactinformation" r:name="user.zip" size="60%"> 
         </td>
      </tr>
      <tr class="bottom-border"">
         <td class="caption right text-top padding-bottom">Neighborhood: &nbsp&nbsp</td>
         <td class="text-top padding-bottom"> 
            <input type="text" class="text" r:context="contactinformation" r:name="user.neighborhood" size="60%"> 
         </td>
      </tr>
      <tr class="bottom-border">
         <td class="caption right text-top padding-bottom padding-top">Website: &nbsp&nbsp</td>
         <td class="padding-bottom padding-top"> 
            <textarea r:context="contactinformation" r:name="user.website" rows="2" cols="40%">
            </textarea>
         </td>
      </tr>
      <tr>
         <td class="caption right text-top padding-bottom padding-top"></td>
         <td class="text-stop padding-bottom padding-top">
            <input type="button" class="button" href="#" r:context="contactinformation" r:name="save" value="Save Changes"/>
         </td>
      </tr>
   </table>
</t:content>
