<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Credits">
   <script>
      Registry.add({id:"sharecredit", page:"profile/sharecredit.jsp", context:"sharecredit"});
      Registry.add({id:"donate", page:"profile/donate.jsp", context:"donate"});
      Registry.add({id:"buycredits", page:"profile/buycredits.jsp", context:"buycredits"});
      Registry.add({id:"pendingorder", page:"profile/pendingorder.jsp", context:"pendingorder"});
      $put("credits", 
         new function() {
            var self = this;
            var creditsvc = ProxyService.lookup("CreditService");
            this.user = {};
            this.credits = {};
            this._controller;
            
            this.onload = function() {
               this.credits = creditsvc.getCredits({ objid:"${SESSION_INFO.userid}" });
            }
            
            this.sharecredit = function() {
               var popup = new PopupOpener('sharecredit', {credits:this.credits, handler: handler});
               popup.title="Share a Credit";
               popup.options={width:400, height:250, resizable:false};
               return popup;
            }
            
            this.donate = function() {
               var popup = new PopupOpener('donate', {credits:this.credits, handler: handler});
               popup.title="Make a Donation";
               popup.options={width:400, height:250, resizable:false};
               return popup;
            }
            
            function handler(){
               self.credits = creditsvc.getCredits({ objid:"${SESSION_INFO.userid}" });
               self._controller.refresh();
            }
            
            this.buycredits = function() {
               var popup;
               
               this.hasPendingOrder = creditsvc.hasPendingOrder({ objid:"${SESSION_INFO.userid}" });
               
               if(this.hasPendingOrder == null) {
                  popup = new PopupOpener('buycredits', {credits:this.credits, userid:"${SESSION_INFO.userid}"});
                  popup.title="Buy Credits";
                  popup.options={width:500, height:385, resizable:false};
               } else {
                  popup = new PopupOpener('pendingorder', {pendingOrder:this.hasPendingOrder, userid:"${SESSION_INFO.userid}"});
                  popup.title="Pending Order";
                  popup.options={width:250, height:175, resizable:false};
               }
               return popup;
            }
         }
      );
   </script>
   <div style="float:left;">
      <table class="page-data-table" width="100%" cellpadding="0" cellspacing="0" border="0">
         <tr>
            <td class="center">
               <a r:context="credits" r:name="buycredits">Buy</a>
            </td>
         </tr>
         <tr>
            <td class="center">
               <a r:context="credits" r:name="donate">Donate</a>
            </td>
         </tr>
         <tr>
            <td class="center">
               <a r:context="credits" r:name="sharecredit">Share Credit</a>
            </td>
         </tr>
      </table>
   </div>
   
   <div style="float:left;">
   <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
      <tr>
         <td class="right caption">Available Credits: &nbsp&nbsp</td>
         <td >
            <label r:context="credits">#{credits.availablecredits}</label>
         </td>
      </tr>
      <tr>
         <td class="right caption">Total Consumed: &nbsp&nbsp</td>
         <td>
            <label r:context="credits">#{credits.totalconsumed}</label>
         </td>
      </tr>
      <tr>
         <td class="right caption">Total Shared: &nbsp&nbsp</td>
         <td>
            <label r:context="credits">#{credits.totalshared}</label>
         </td>
      </tr>
      <tr>
         <td class="right caption">Total Donated: &nbsp&nbsp</td>
         <td>
            <label r:context="credits">#{credits.totaldonated}</label>
         </td>
      </tr>
   </table>
   </div>
</t:content>
