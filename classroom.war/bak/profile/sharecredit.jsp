<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:popup>
   <jsp:attribute name="script">
      $put("sharecredit", 
         new function() {
            var svc = ProxyService.lookup("AccountService");
            this.credits;
            this.handler;
            this.creditto = {};
            
            this.users = [
               {name:"Rolando, Evalle", uid:"00002"},
               {name:"Magalona, Alvin", uid:"00003"},
               {name:"Ramos, Michael", uid:"00004"}
            ];
            
            
            this.onload = function() {
               this.creditto.from = this.credits.uid;
               this.creditto.amount = 0;
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
   </jsp:attribute>
   <jsp:body>
      <table class="page-form-table" cellpadding="0" cellspacing="0" border="0">
         <tr>
            <td class="right text-top padding-top">Available Credits: &nbsp&nbsp</td>
            <td class="text-top padding-top">
               <label r:context="sharecredit">#{credits.availablecredits}</label>
            </td>
         </tr>
         <tr>
            <td class="right text-top padding-top"> To: &nbsp&nbsp</td>
            <td class="text-top padding-top">
               <select r:context="sharecredit" r:items="users" r:name="creditto.to" r:itemKey="uid" r:itemLabel="name"/>
            </td>
         </tr>
         <tr>
            <td class="right text-toppadding-top">Amount: &nbsp&nbsp</td>
            <td class="text-top padding-top">
               <input type="text" r:context="sharecredit" r:name="creditto.amount"/>
            </td>
         </tr>
         <tr>
            <td class="text-top padding-top"></td>
            <td class="text-top padding-top">
               <input type="button" r:context="sharecredit" r:name="share" value="Share Credit"/>
            </td>
         </tr>
      </table>
   </jsp:body>
</t:popup>
