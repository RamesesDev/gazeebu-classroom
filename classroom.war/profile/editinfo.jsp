<script src="js/ext/birthdate.js"></script>
<script>
   $put("editinfo", 
      new function() {
         var svc = ProxyService.lookup("UserProfileService");
         this.user = {};
         this.handler;
			this.gender = [ 
			  {id:"M", name:"Male"}, 
			  {id:"F", name:"Female"}
			];
			
		   this.onload = function() {
			   if( this.user.birthdate ) {
				   var b = this.user.birthdate.split('-');
				   this.birthdate = new DateModel(parseInt(b[1]), parseInt(b[2]), parseInt(b[0]));
			   }
			   else {
				   this.birthdate = new DateModel();
			   }
			}
      
         this.save = function() {
            svc.update(this.user);
            if(this.handler)
               this.handler();
               
            return "_close";
         }
      }
   );
</script>

<table class="page-form-table" cellpadding="0" cellspacing="0" border="0">
   <tr>
      <td class="caption right">
         Gender: &nbsp;&nbsp;
      </td>
      <td>
         <select r:context="editinfo" 
               r:name="user.gender" 
               r:caption="Gender" 
               r:items="gender" 
               r:itemKey="id" 
               r:itemLabel="name" 
               r:required="true">
         </select>
      </td>
   </tr>
   <tr>
      <td class="caption right">
         Birthday: &nbsp;&nbsp;
      </td>
      <td>
         <birthdate r:context="editinfo" r:model="birthdate" r:name="user.birthdate"/>
      </td>
   </tr>
   <tr>
      <td class="caption right">
         Language: &nbsp;&nbsp;
      </td>
      <td>
         <input type="text" 
               class="text" 
               r:context="editinfo" 
               r:name="user.languages"
               size="40"/>
      </td>
   </tr>
   <tr>
      <td class="caption right" valign="top">
         About Me: &nbsp;&nbsp;
      </td>
      <td>
		<textarea type="text" 
		          class="text" 
		          r:context="editinfo" 
		          r:name="user.aboutme"
		          cols="39" rows="8">
		</textarea>
      </td>
   </tr>
   <tr>
      <td class="text-top padding-top right" colspan="2">
         <input type="button" 
               r:context="editinfo" 
               r:name="save" 
               value="Save"/>
      </td>
   </tr>
</table>
