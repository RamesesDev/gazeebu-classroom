<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Account Settings">
   <script src="js/ext/birthdate.js"></script>
   <script>
	   Registry.add({id:"addcontact", page:"profile/addcontact.jsp", context:"addcontact"});
      $put("accountsettings", 
         new function() {
            var svc = ProxyService.lookup("UserProfileService");
            this.user;
            this.editingName = false;
			this.editingEmail = false;
			
			this.gender = [ 
			  {id:"M", name:"Male"}, 
			  {id:"F", name:"Female"}
			];
			
            this.types = [
               "MOBILE", "LANDLINE", "WEBSITE"
            ];
			
            this.birthdate;
            this.contacts=[];
            this.flag=0;
            
			this.onload = function() {
				this.user = svc.getInfo({ objid:"${SESSION_INFO.userid}" });
				if( this.user.homeaddress == null ) this.user.homeaddress = {};
				if(this.user.contacts) {
					for(var i=0 ; i<this.user.contacts.length ; i++) {
						this.contacts.push(this.user.contacts[i]);
					}
				} else {
					this.user.contacts = [];
				}
				
				if( this.user.birthdate ) {
					var b = this.user.birthdate.split('-');
					this.birthdate = new DateModel(parseInt(b[1]), parseInt(b[2]), parseInt(b[0]));
				}
				else {
					this.birthdate = new DateModel();
				}
			}
			
            this.saveName = function() {
				this.showEditingName();
				svc.save(this.user);
            }
			this.showEditingName = function() {
			   this.editingName = !this.editingName;
			}

			this.saveEmail = function() {
				this.showEditingEmail();
				svc.save(this.user);
			}
			this.showEditingEmail = function() {
			  this.editingEmail = !this.editingEmail;
			}
			   
            this.addanothercontact = function() {
               var popup = new PopupOpener('addcontact', {contacts:this.user.contacts, list:this.contacts, handler:this.handler});
               popup.title="Add Contact";
               popup.options={width:375, height:200, resizable:false};
               return popup;
            }
            this.deleteContact = function() {
               this.contacts.splice(this.flag, 1);
            }
            
            this.save = function() {
                this.user.contacts = this.contacts;
                svc.update(this.user);
            }
            
            this._controller;
            this.handler = function() {
               this.user = svc.getInfo( { objid:"${SESSION_INFO.userid}" } );
               this._controller.refresh();
            }
         }
      );
   </script>
   
   <table class="page-form-table" width="80%" cellpadding="0" cellspacing="0" border="0">
      <tr>
         <td colspan="2" class="caption right text-top">
            <div r:context="accountsettings" r:visibleWhen="#{!editingName}">
               <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                     <td class="caption right" width="90">
                        Name: &nbsp;&nbsp;
                     </td>
                     <td>
                        <label r:context="accountsettings">
                           #{user.firstname} #{user.lastname}
                        </label>
                     </td>
                     <td class="right">
                        <a r:context="accountsettings" r:name="showEditingName">
                           Edit
                        </a>
                     </td>
                  </tr>
               </table>
            </div>
            <div r:context="accountsettings" r:visibleWhen="#{editingName}">
               <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                     <td style="color:#a5aa84;font-size:16px;text-align:center;font-weight:bold;">
                        Name
                     </td>
                     <td class="right">
                        <input type="button" class="button" 
                              r:context="accountsettings" r:name="saveName" 
                              value="Save"/>
                        <input type="button" class="button" 
                              r:context="accountsettings" r:name="showEditingName" 
                              value="Cancel"/>
                     </td>
                  </tr>
                  <tr>
                     <td class="caption right text-top" width="90">
                        First Name: &nbsp;&nbsp;
                     </td>
                     <td class="text-top">
                        <input type="text" class="text" size="60%"
                              r:context="accountsettings" 
                              r:name="user.firstname"/>
                     </td>
                  </tr>
                  <tr>
                     <td class="caption right text-top" width="90">
                        Last Name: &nbsp;&nbsp;
                     </td>
                     <td class="text-top">
                        <input type="text" class="text" size="60%" 
                              r:context="accountsettings" 
                              r:name="user.lastname"/>
                     </td>
                  </tr>
               </table>
            </div>
         </td>
      </tr>
      <tr class="bottom-border">
         <td colspan="2" class="caption right text-top">
            <div r:context="accountsettings" r:visibleWhen="#{!editingEmail}">
               <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                     <td class="caption right" width="90">
                        Email: &nbsp;&nbsp;
                    </td>
                     <td>
                        <label r:context="accountsettings">
                           #{user.email}
                        </label>
                     </td>
                     <td class="right">
                        <a r:context="accountsettings" r:name="showEditingEmail">
                           Edit
                        </a>
                     </td>
                  </tr>
               </table>
            </div>
            <div r:context="accountsettings" r:visibleWhen="#{editingEmail}">
               <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                     <td style="color:#a5aa84;font-size:16px;text-align:center;font-weight:bold;">
                        E-mail
                     </td>
                     <td class="right">
                        <input type="button" class="button" 
                              r:context="accountsettings" r:name="saveEmail" 
                              value="Save"/>
                        <input type="button" class="button" 
                              r:context="accountsettings" r:name="showEditingEmail"
                              value="Cancel"/>
                     </td>
                  </tr>
                  <tr>
                     <td class="caption right text-top" width="90">
                        Email: &nbsp;&nbsp;
                     </td>
                     <td class="text-top">
                        <input type="text" class="text" size="60%"
                              r:context="accountsettings" 
                              r:name="user.email"/>
                     </td>
                  </tr>
               </table>
            </div>
         </td>
      </tr>
      <tr>
         <td class="caption right text-top padding-bottom padding-top" width="95">
            Address: &nbsp;&nbsp;
         </td>
         <td class="text-top padding-top">
            <input type="text" class="text" 
                  r:context="accountsettings" r:name="user.homeaddress.address" 
                  caption="Address" size="60%"> 
         </td>
      </tr><tr class="bottom-border">
         <td class="caption right text-top padding-bottom padding-top" width="95">
            Zip: &nbsp;&nbsp;
         </td>
         <td class="text-top padding-bottom padding-top">
            <input type="text" class="text" 
                  r:context="accountsettings" r:name="user.homeaddress.zip" 
                  caption="Zip" size="60%"> 
         </td>
      </tr>
      <tr>
         <td class="caption right text-top padding-top" width="95">
            I am:&nbsp;&nbsp;
         </td>
         <td class="text-top padding-top"> 
            <select r:context="accountsettings" 
                  r:name="user.gender" r:caption="Gender" r:items="gender" 
                  r:itemKey="id" r:itemLabel="name" r:required="true">
            </select>
         </td>
      </tr>
      <tr class="bottom-border">
         <td class="caption right text-top padding-top padding-bottom" width="95">
            Birthday: &nbsp;&nbsp;
         </td>
         <td class="text-top padding-top padding-bottom"> 
            <birthdate r:context="accountsettings" r:model="birthdate" r:name="user.birthdate"/>
         </td>
      </tr>
      <tr class="bottom-border">
         <td class="caption right text-top padding-bottom padding-top" width="95">
            Contacts: &nbsp;&nbsp;
         </td>
         <td class="padding-bottom padding-top">
            <table r:context="accountsettings" 
                  r:items="contacts" r:varName="contact" r:varStatus="n" 
                  class="inner-table" width="100%" cellpadding="0" cellspacing="0" border="0">
               <tr>
                  <td>
                     <input type="text" class="text" value="#{contact.name == null ? '' : contact.name}" 
                           r:context="accountsettings" 
                           r:hint="Name"/>
                     <select r:context="accountsettings" r:items="types" r:name="#{contact.type}"></select>
                     <input type="text" class="text" value="#{contact.value == null ? '' : contact.value}" 
                           r:context="accountsettings" 
                           r:hint="Value"/>
                  </td>
                  <td class="controls">
                     <a r:context="accountsettings" r:name="deleteContact" 
                        r:params='"{flag:" + #{n}'
                        class="close">
                        X
                     </a>
                  </td>
               </tr>
            </table>
            <a href="#" r:context="accountsettings" r:name="addanothercontact">
               Add another Contact
            </a>
         </td>
      </tr>
      
      <tr>
         <td class="caption right text-top padding-top" width="95">
            Languages: &nbsp;&nbsp;
         </td>
         <td class="text-top padding-top"> 
            <input type="text" class="text" r:context="accountsettings" r:name="user.languages" size="60%"> 
         </td>
      </tr> 
      <tr class="bottom-border">
         <td class="caption right text-top padding-bottom padding-top" width="95">
            About Me: &nbsp;&nbsp;
         </td>
         <td class="text-top padding-bottom padding-top"> 
            <textarea r:context="accountsettings" r:name="user.aboutme" 
                     rows="2" cols="40">
            </textarea>
         </td>
      </tr>
      <tr>
         <td class="caption right text-top padding-bottom padding-top"></td>
         <td class="text-top padding-bottom padding-top">
            <input type="button" class="button" href="#" r:context="accountsettings" r:name="save" value="Save Changes"/>
         </td>
      </tr>
   </table>
</t:content>
