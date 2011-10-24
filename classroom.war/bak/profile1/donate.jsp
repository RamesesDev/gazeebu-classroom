<script>
   $put("donate", 
      new function() {
         var svc = ProxyService.lookup("AccountService");
         this.credits;
         this.handler;
         this.donation = {};
         this.students;
         
         this.types = [
            {code:"SS", name:"School Supplies"},
            {code:"TXT", name:"Text Messages"}
         ];
         
         this.onload = function() {
            this.donation.from = this.credits.objid;
            this.donation.amount = 0;
            
            for(var i=0 ; i<this.students.length ; i++) {
               this.students[i].name = this.students[i].firstname + " " + this.students[i].lastname;
            }
         }
         
         this.donate = function() {
            if(this.donation.amount > this.credits.availablecredits) {
               alert("Insufficient Credits.");
            } else {
               svc.donate({from:this.donation.from, to:this.donation.to, amount:this.donation.amount, type:this.donation.type});
               this.credits.availablecredits = this.credits.availablecredits - this.donation.amount;
               this.credits.totaldonated = this.credits.totaldonated + this.donation.amount;
            }
            
            if(this.handler)
               this.handler();
            
            return "_close";
         }
      }
   );
</script>

<table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
   <tr>
      <td class="right caption text-top">Available Credits: &nbsp&nbsp</td>
      <td class="text-top">
         <label r:context="donate">#{credits.availablecredits}</label>
      </td>
   </tr>
   <tr>
      <td class="right caption text-top padding-top"> To: &nbsp&nbsp</td>
      <td class="text-top padding-top">
         <select r:context="donate" r:items="students" r:name="donation.to" r:itemKey="objid" r:itemLabel="name"/>
      </td>
   </tr>
   <tr>
      <td class="right caption text-top padding-top"> Type: &nbsp&nbsp</td>
      <td class="text-top padding-top">
         <select r:context="donate" r:items="types" r:name="donation.type" r:itemKey="code" r:itemLabel="name"/>
      </td>
   </tr>
   <tr>
      <td class="right caption text-top padding-top">Amount: &nbsp&nbsp</td>
      <td class="text-top padding-top">
         <input type="text" class="text" r:context="donate" r:name="donation.amount"/>
      </td>
   </tr>
   <tr>
      <td class="text-top padding-top"></td>
      <td class="text-top padding-top">
         <input type="button" r:context="donate" r:name="donate" value="Donate"/>
      </td>
   </tr>
</table>
