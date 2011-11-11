<script>
   $put("editemail", 
      new function() {
         var svc = ProxyService.lookup("UserProfileService");
         this.user = {};
         this.handler;
      
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
         Email: &nbsp;&nbsp;
      </td>
      <td>
         <input type="text" 
               class="text" 
               r:context="editemail" 
               r:name="user.email"
               size="50"/>
      </td>
   </tr>
   <tr>
      <td class="text-top padding-top right" colspan="2">
         <input type="button" 
               r:context="editemail" 
               r:name="save" 
               value="Save"/>
      </td>
   </tr>
</table>
