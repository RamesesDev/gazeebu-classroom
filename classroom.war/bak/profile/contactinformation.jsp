<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content>
   <jsp:attribute name="script">
      Registry.add({id:"addemail", page:"account/addemail.jsp", context:"addemail"});
      
      $put("contactinformation",
         new function() {
            this.flag=0;
           
            var svc = ProxyService.lookup("AccountService");
            this.user;
            
            this.emails = [
               {email:"palen_dhel@yahoo.com.ph", im:"Yahoo Messenger"},
               {email:"windhel.palen@gmail.com", im:"Google Talk"}
            ];
            
            this.onload = function() {
               this.user = svc.getUser({uid:"00001"});
               //this.emails = this.name.emails;
            }
            
            this.screennames = [
               {email:"palen_dhel@yahoo.com.ph", im:"Yahoo Messenger"},
               {email:"windhel.palen@gmail.com", im:"Google Talk"}
            ];
            
            
            this.phoneinfo = [
               {type:"MOBILE", no:"012381984"},
               {type:"LANDLINE", no:"2512415"}
            ];
            
            this.imnames = [
               "Yahoo Messenger", "MSN", "Google Talk"
            ];
            
            this.phonetypes = [
               "MOBILE", "LANDLINE"
            ];
            
            this.contacts = [
               {name:"Jayrome Vergara", type:"MOBILE", no:"123456789"}
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
            
            this.addscreenname = function() {
                this.screennames.push({email:"", im:""});
            }
            this.deleteIM = function() {
               this.screennames.splice(this.flag, 1);
            }
            
            this.addanotherphone = function() {
               this.phoneinfo.push({type:"", no:""});
            }
            this.deletePhone = function() {
               this.phoneinfo.splice(this.flag, 1);
            }
            
            this.addanothercontact = function() {
               this.contacts.push({name:"", type:"", no:""});
            }
            this.deleteContact = function() {
               this.contacts.splice(this.flag, 1);
            }
            
         }
      );
   </jsp:attribute>
   <jsp:body>
      <label class="header" context="contactinformation">
         #{user.firstname} #{user.lastname} <img src="images/next.png"> Edit Profile
      </label>
      <br><br>
      <table class="page-form-table" width="80%" cellpadding="0" cellspacing="0" border="0">
         <tr class="bottom-border">
            <td class="caption right text-top padding-bottom padding-top">Emails: &nbsp&nbsp</td>
            <td class="padding-bottom padding-top">
               <table r:context="contactinformation" 
                     r:items="emails" 
                     r:varName="email" 
                     r:varStatus="n" 
                     class="inner-table" 
                     width="100%" 
                     cellpadding="0" 
                     cellspacing="0" 
                     border="0">
                  <tbody>
                     <tr>
                        <td>
                           #{email.email}
                        </td>
                        <td class="controls">
                           <a href="#" r:context="contactinformation" r:name="deleteEmail" r:params="{flag:' + #{n} +  '">
                              <b>x</b>
                           </a>
                        </td>
                     </tr>
                  </tbody>
               </table>
               <a href="#" r:context="contactinformation" r:name="addEmail">Add Email</a>
               <br>
            </td>
         </tr>
         
         <tr class="bottom-border">
            <td class="caption right text-top padding-bottom padding-top">IM Screen Names: &nbsp&nbsp</td>
            <td class="padding-bottom padding-top">
                <table r:context="contactinformation" 
                        r:items="screennames" 
                        r:varName="screenname" 
                        r:varStatus="n" 
                        class="inner-table" 
                        width="100%" 
                        cellpadding="0" 
                        cellspacing="0" 
                        border="0">
                  <tbody>
                     <tr>
                        <td>
                           <input type="text" class="text" r:context="contactinformation" r:name="screennames[#{n.index}].email"/>
                           <select r:context="contactinformation" r:items="imnames" r:name="screennames[#{n.index}].im"></select>
                        </td>
                        <td class="controls">
                           <a href="#" r:context="contactinformation" r:name="deleteIM" r:params="{flag:' + #{n} +  '">
                              <b>x</b>
                           </a>
                        </td>
                     </tr>
                  </tbody>
               </table>
               <a href="#" r:context="contactinformation" r:name="addscreenname">Add another Screen Name</a>
               <br>
            </td>
         </tr>
         
         <tr class="bottom-border">
            <td class="caption right text-top padding-bottom padding-top">Phones: &nbsp&nbsp</td>
            <td class="padding-bottom padding-top">
               <table r:context="contactinformation" 
                     r:items="phoneinfo" 
                     r:varName="pi" 
                     r:varStatus="n" 
                     class="inner-table" 
                     width="100%" 
                     cellpadding="0" 
                     cellspacing="0" 
                     border="0">
                  <tr>
                     <td>
                        <select r:context="contactinformation" r:items="phonetypes" r:name="phoneinfo[#{n.index}].type"></select>
                        <input type="text" class="text" value="#{pi.no}" name="phoneinfo[#{n.index}].no"/>
                     </td>
                     <td class="controls">
                        <a href="#" r:context="contactinformation" r:name="deletePhone" r:params="{flag:' + #{n} +  '">
                           <b>x</b>
                        </a>
                     </td>
                  </tr>
               </table>
               <a href="#" r:context="contactinformation" r:name="addanotherphone">Add another Phone</a>
               <br>
            </td>
         </tr>
         
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
                        <select r:context="contactinformation" r:items="phonetypes" r:name="phoneinfo[#{n.index}].type"></select>
                        <input type="text" class="text" value="#{contact.no}" name="phoneinfo[#{n.index}].no"/>
                     </td>
                     <td class="controls">
                        <a href="#" r:context="contactinformation" r:name="deleteContact" r:params="{flag:' + #{n} +  '">
                           <b>x</b>
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
            <td class="caption right text-top">City/Town: &nbsp&nbsp</td>
            <td class="text-top"> 
               <input type="text" class="text" r:context="contactinformation" r:name="user.citytown" size="60%"> 
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
   </jsp:body>
</t:content>
