<script>
   $put("addcontact", 
      new function() {
         this.contacts = [];
         this.list = [];
         this.entity={};
         this.types = [
            "MOBILE", "LANDLINE", "WEBSITE"
         ];
         
         this.add = function() {
            //this.contacts.push(this.entity);
            this.list.push(this.entity);
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
         Description: &nbsp;&nbsp;
      </td>
      <td>
         <input type="text" class="text" 
               r:context="addcontact" r:name="entity.name" r:hint="Name"/>
      </td>
   </tr>
   <tr>
      <td class="caption right">
         Type: &nbsp;&nbsp:
      </td>
      <td>
         <select r:context="addcontact" r:items="types" r:name="entity.type"></select>
      </td>
   </tr>
   <tr>
      <td class="caption right">
         Value: &nbsp;&nbsp;
      </td>
      <td>
         <input type="text" class="text" 
               r:context="addcontact" r:name="entity.value" r:hint="Value"/>
      </td>
   </tr>
   <tr>
      <td class="text-top padding-top"></td>
      <td class="text-top padding-top">
         <input type="button" r:context="addcontact" r:name="add" value="Add"/>
      </td>
   </tr>
</table>
