<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content>
   <jsp:attribute name="script">
      Registry.add({id:"sharecredit", page:"account/sharecredit.jsp", context:"sharecredit"});
      Registry.add({id:"donate", page:"account/donate.jsp", context:"donate"});
      $put("credits", 
         new function() {
            var svc = ProxyService.lookup("AccountService");
            this.user = svc.getUser({uid:"00001"});
            this.credits = svc.getCredits({uid:"00001"});
            /*this.credits = {
               uid:"00001",
               totalcredits:50,
               availablecredits:50,
               totalconsumed:0,
               totalshared:0,
               totaldonated:0
            };*/
            
            this.sharecredit = function() {
               var popup = new PopupOpener('sharecredit', {credits:this.credits, handler:this.handler});
               popup.title="Share Credit";
               popup.options={width:300, height:250, resizable:false};
               return popup;
            }
            
            this.donate = function() {
               var popup = new PopupOpener('donate', {credits:this.credits, handler:this.handler});
               popup.title="Donate";
               popup.options={width:300, height:250, resizable:false};
               return popup;
            }
            
            this._controller;
            this.handler = function() {
               this.credits = svc.getCredits({uid:"00001"});
               alert("refreshing" + this.credits.availablecredits);
               this._controller.refresh();
            }
         }
      );
   </jsp:attribute>
<jsp:body>
   <label class="header">
      Credits
   </label>
   <br><br>
   
   <table class="page-form-table" width="40%" cellpadding="0" cellspacing="0" border="0">
      <tr>
         <td colspan="2" class="center">
            <form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post">
               <input type="hidden" name="cmd" value="_s-xclick">
               <input type="hidden" name="encrypted" value="-----BEGIN PKCS7-----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-----END PKCS7-----">
               <input type="image" src="https://www.sandbox.paypal.com/en_US/i/btn/btn_buynow_SM.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
               <img alt="" border="0" src="https://www.sandbox.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
              
               <a href="#" class="button" r:context="credits" r:name="donate">DONATE</a>
               <a href="#" class="button" r:context="credits" r:name="sharecredit">SHARE CREDIT</a>
               <a href="#" >View Credit History</a>
            </form>
         </td>
      </tr>
      <tr>
         <td class="right caption padding-top">Available Credits: &nbsp&nbsp</td>
         <td class="padding-top">
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
   
   </jsp:body>
</t:content>
