<script>
   Registry.add({id:"addcontact", page:"profile/addcontact.jsp", context:"addcontact"});
   $put("editcontacts", 
      new function() 
	  {
         var svc = ProxyService.lookup("UserProfileService");
         this.user = {};
         this.handler;
		 this.selectedIndex;
		 
         this.types = [
            "MOBILE", "LANDLINE", "WEBSITE"
         ];
         
         this.onload = function() {
            if( !this.user.contacts ) this.user.contacts = [];
         }
         
         this.save = function() {
			svc.update(this.user);
            if(this.handler)
               this.handler();
               
            return "_close";
         }
         
         this.addanothercontact = function() {
            this.user.contacts.push({type:"", value:""});
         }
         
         this.deleteContact = function() {
            this.user.contacts.splice( this.selectedIndex, 1 );
         }
      }
   );
</script>
<table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
   <tr>
      <td>
         <table r:context="editcontacts" 
            r:items="user.contacts" r:varStatus="n"
            class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
               <td>
					<select r:context="editcontacts" r:items="types" r:name="user.contacts[#{n.index}].type"></select>
					<input type="text" class="text" value="#{contact.value == null ? '' : contact.value}" 
						r:context="editcontacts"
						r:name="user.contacts[#{n.index}].value"
						r:hint="Value"/>
               </td>
               <td class="controls">
                  <a r:context="editcontacts" r:name="deleteContact" r:params="{selectedIndex: #{n.index}}" class="close">
                     X
                  </a>
               </td>
            </tr>
         </table>
      </td>
   </tr>
   <tr>
      <td class="left">
         <a href="#" r:context="editcontacts" r:name="addanothercontact">
            Add another Contact
         </a>
      </td>
   </tr>
   <tr>
      <td class="text-top padding-top right">
         <input type="button" 
               r:context="editcontacts" 
               r:name="save" 
               value="Save"/>
      </td>
   </tr>
</table>
