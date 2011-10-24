<script>
   $put("customkeyword",
      new function() {
         this.customkeywords = [];
         this.entity = [];
         this.handler;
         
         this.save = function() {
            this.customkeywords.push(this.entity);
            if(this.handler)
               this.handler();
            
            return "_close";
         }
      }
   );
</script>

<table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
   <tr>
      <td class="caption right">Keyword:&nbsp;&nbsp;</td>
      <td>
         <label style="border:1px solid #a5aa84;">
            GZ
         </label>
         <input type="text" r:context="customkeyword" r:name="entity.keyword" 
               style="border:1px solid #a5aa84;">
      </td>
   </tr>
   <tr>
      <td class="caption right">Key:&nbsp;&nbsp;</td>
      <td><input type="text" class="text" r:context="customkeyword" r:name="entity.key"></td>
   </tr>
   <tr>
      <td class="caption right">Class URL:&nbsp;&nbsp;</td>
      <td><input type="text" class="text" r:context="customkeyword" r:name="entity.classurl"></td>
   </tr> 
   <tr>
      <td colspan="2" class="right">
         <input type="button" r:context="customkeyword" r:name="save" value="Save"/>
      </td>
   </tr>
</table>


