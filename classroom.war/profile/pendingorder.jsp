<script>
   $put("pendingorder", 
      new function() {
         var creditsvc = ProxyService.lookup("CreditService");
         this.pendingOrder;
         this.totalPrice;
         this.currency;
         this.userid;
         
         this.onload = function() {
            this.totalPrice = this.pendingOrder.totalprice;
            this.currency = "PHP";
         }
         
         this.paying = function() {   
            document.getElementById("customid").value = this.pendingOrder.transactionid;
            document.getElementById("currencycode").value = this.currency != "PHP" ? "PHP" : this.currency;
            document.getElementById("business").value = "palen_dhel@yahoo.com.ph";
            document.getElementById("notify_url").value = "http://www.gazeebu.com/classroom/profile/paypalipn.jsp";
            document.getElementById("return_url").value = "http://www.gazeebu.com/classroom/profile.jsp#paymentsuccessful";
            
            return "_close";
         }
         
         this.cancelOrder = function() {
            var answer = confirm ("Cancel this order?")
            if (answer) {
               creditsvc.cancelPendingOrder( {objid:this.userid, transactionid:this.pendingOrder.transactionid, totalcredits:this.pendingOrder.totalcredits} );
               alert("Order has been cancelled.");
               return "_close";
            }
         }
      }
   );
</script>

<div style="padding:5px;">
   <!-- https://www.paypal.com/cgi-bin/webscr -->
   <!-- https://www.sandbox.paypal.com/cgi-bin/webscr -->
   <form id="payPalForm" action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" target="_blank">
      <input type="hidden" name="item_name" value="Gazeebu Credits">
      <input type="hidden" name="item_number" value="Credits">
      <input type="hidden" name="amount" r:context="pendingorder" r:name="totalPrice" >
      <input type="hidden" name="cmd" value="_xclick">
      <input type="hidden" name="upload" value="1">
      <input type="hidden" name="at" value="TestGazeebuPaypal"> 
      <input type="hidden" name="paymentaction" value="sale">
      <input type="hidden" name="notify_url" id="notify_url" value="">
      <input type="hidden" name="return" id="return_url" value="">
      <input type="hidden" name="business" id="business" value="">
      <input type="hidden" name="currency_code" id="currencycode" value="">
      <input type="hidden" name="custom" id="customid" value=""> 
   
      <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
         <tr>
            <td></td>
            <td style="text-align:right;">
               <a r:context="pendingorder" 
                  r:name="cancelOrder">
                  Cancel Order
               </a>
            </td>
         </tr>
         <tr>
            <td class="caption"> 
               Total Credits: &nbsp;&nbsp;
            </td>
            <td style="text-align:right;">
               <label r:context="pendingorder">#{pendingOrder.totalcredits}</label>
            </td>
         </tr>
         <tr>
            <td class="caption">
               Total Price (<label r:context="pendingorder" style="font-weight:normal;">#{currency}</label>): &nbsp;&nbsp;
            </td>
            <td style="text-align:right;">
               <input type="text" name="amount" 
                        r:context="pendingorder" 
                        r:name="totalPrice" 
                        size="5"
                        readonly 
                        style="text-align:right;border:0;background:transparent;">
            </td>
         </tr>
      </table>
      
      <div style="float:right;">
         <input type="submit" 
               style="background:url('img/btn_xpressCheckout.gif'); padding-right:140px;padding-bottom:21px;border:0;"
               name="submit" 
               value=""
               class="right"
               alt="PayPal - The safer, easier way to pay online!"
               r:context="pendingorder"
               r:name="paying">
      </div>
   </form>
</div>
