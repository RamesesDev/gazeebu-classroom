<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Payment Successful">
   <script>
      Registry.add({id:"sharecredit", page:"profile/sharecredit.jsp", context:"sharecredit"});
      Registry.add({id:"donate", page:"profile/donate.jsp", context:"donate"});
      
      $put("paymentsuccessful", 
         new function() {
            var self = this;
            var creditsvc = ProxyService.lookup("CreditService");
            this.credits;
            this.availablecredits = 0;
            
            this.onload = function() {
               this.credits = creditsvc.getCredits({ objid:"${SESSION_INFO.userid}" });
               this.availablecredits = this.credits.availablecredits;
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
         }
      );
   </script>
   <style>
      .thankyou 
      {
         font-size:12px;
      }
      
      a
      {
         text-decoration:none;
         font-weight:bold;
      }
      
      a:hover
      {
         text-decoration:underline;
      }
   </style>
   <div class="thankyou">
   <p>
      Thank You for buying Gazeebu Credits. You currently have <b><label r:context="paymentsuccessful">#{availablecredits}</label> Credits</b>.
   </p>  
   <p>
      You can <a r:context="paymentsuccessful" r:name="donate">Donate</a> or <a r:context="paymentsuccessful" r:name="sharecredit">Share Credit</a> these credits,
   </p>
   <p>
       or spend them with our partners:
   </p>
   <p>
      [Partner 1] <br/>
      [Partner 2] <br/>
   </p>
   </div>
</t:content>
