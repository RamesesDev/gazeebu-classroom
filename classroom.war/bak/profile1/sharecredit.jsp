<script>
   $put("sharecredit", 
      new function() {
         var svc = ProxyService.lookup("AccountService");
         this.credits;
         this.handler;
         this.creditto = {};
         this.students;
         
         this.onload = function() {
            this.creditto.from = this.credits.objid;
            this.creditto.amount = 0;
            
            for(var i=0 ; i<this.students.length ; i++) {
               this.students[i].name = this.students[i].firstname + " " + this.students[i].lastname;
            }
         }
         
         this.share = function() {
            if(this.creditto.amount > this.credits.availablecredits) {
               alert("Insufficient Credits.");
            } else {
               svc.shareCredits({from:this.creditto.from, to:this.creditto.to, amount:this.creditto.amount});
               this.credits.availablecredits = this.credits.availablecredits - this.creditto.amount;
               this.credits.totalshared = this.credits.totalshared + this.creditto.amount;
            }
            if(this.handler)
               this.handler();
            
            return "_close";
         }
      }
   );
</script>

<table class="page-form-table" cellpadding="0" cellspacing="0" border="0">
   <tr>
      <td class="right caption text-top padding-top">Available Credits: &nbsp&nbsp</td>
      <td class="text-top padding-top">
         <label r:context="sharecredit">#{credits.availablecredits}</label>
      </td>
   </tr>
   <tr>
      <td class="right caption text-top padding-top"> To: &nbsp&nbsp</td>
      <td class="text-top padding-top">
         <select r:context="sharecredit" r:items="students" r:name="creditto.to" r:itemKey="objid" r:itemLabel="name"/>
      </td>
   </tr>
   <tr>
      <td class="right caption text-top padding-top">Amount: &nbsp&nbsp</td>
      <td class="text-top padding-top">
         <input type="text" class="text" r:context="sharecredit" r:name="creditto.amount"/>
      </td>
   </tr>
   <tr>
      <td class="text-top padding-top"></td>
      <td class="text-top padding-top">
         <input type="button" r:context="sharecredit" r:name="share" value="Share"/>
      </td>
   </tr>
</table>
   
