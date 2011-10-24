<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Credits">
   <script>
      Registry.add({id:"sharecredit", page:"profile/sharecredit.jsp", context:"sharecredit"});
      Registry.add({id:"donate", page:"profile/donate.jsp", context:"donate"});
      Registry.add({id:"buycredits", page:"profile/buycredits.jsp", context:"buycredits"});
      $put("credits", 
         new function() {
            var svc = ProxyService.lookup("AccountService");
            this.user = svc.getInfo({objid:"TCH74a18681:131daf6cf9f:-7ffe"});
            this.credits = svc.getCredits({objid:"TCH74a18681:131daf6cf9f:-7ffe"});
            this.students = svc.getStudents();
            
            this.sharecredit = function() {
               var popup = new PopupOpener('sharecredit', {credits:this.credits, handler:this.handler, students:this.students});
               popup.title="Share a Credit";
               popup.options={width:400, height:250, resizable:false};
               return popup;
            }
            
            this.donate = function() {
               var popup = new PopupOpener('donate', {credits:this.credits, handler:this.handler, students:this.students});
               popup.title="Make a Donation";
               popup.options={width:400, height:250, resizable:false};
               return popup;
            }
            
            this._controller;
            this.handler = function() {
               this.credits = svc.getCredits({objid:"TCH74a18681:131daf6cf9f:-7ffe"});
               this._controller.refresh();
            }
            
         }
      );
   </script>
   <div style="float:left;">
      <table class="page-data-table" width="100%" cellpadding="0" cellspacing="0" border="0">
         <tr>
            <td class="center">
               <a href="#buycredits">Buy</a>
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
