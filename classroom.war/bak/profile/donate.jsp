<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:popup>
   <jsp:attribute name="script">
      $put("donate", 
         new function() {
            var svc = ProxyService.lookup("AccountService");
            this.credits;
            this.handler;
            this.donation = {};
            
            this.users = [
               {name:"Rolando, Evalle", uid:"00002"},
               {name:"Magalona, Alvin", uid:"00003"},
               {name:"Ramos, Michael", uid:"00004"}
            ];
            
            this.types = [
               {code:"SS", name:"School Supplies"},
               {code:"TXT", name:"Text Messages"}
            ];
            
            this.onload = function() {
               this.donation.from = this.credits.uid;
               this.donation.amount = 0;
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
   </jsp:attribute>
   <jsp:body>
      <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
         <tr>
            <td caption="right">Available Credits: &nbsp&nbsp</td>
            <td>
               <label r:context="donate">#{credits.availablecredits}</label>
            </td>
         </tr>
         <tr>
            <td class="right text-top padding-top"> To: &nbsp&nbsp</td>
            <td class="text-top padding-top">
               <select r:context="donate" r:items="users" r:name="donation.to" r:itemKey="uid" r:itemLabel="name"/>
            </td>
         </tr>
         <tr>
            <td class="right text-top padding-top"> To: &nbsp&nbsp</td>
            <td class="text-top padding-top">
               <select r:context="donate" r:items="types" r:name="donation.type" r:itemKey="code" r:itemLabel="name"/>
            </td>
         </tr>
         <tr>
            <td class="right text-toppadding-top">Amount: &nbsp&nbsp</td>
            <td class="text-top padding-top">
               <input type="text" r:context="donate" r:name="donation.amount"/>
            </td>
         </tr>
         <tr>
            <td class="text-top padding-top"></td>
            <td class="text-top padding-top">
               <input type="button" r:context="donate" r:name="donate" value="Share Credit"/>
            </td>
         </tr>
      </table>
   </jsp:body>
</t:popup>
