<script>
   $put("buycredits", 
      new function() {
         var svc = ProxyService.lookup("CreditService");
         this.transactionid;
         this.currency;
         this.userid;
         this.cv_one = 0;
         this.cv_two = 0;
         this.cv_three = 0;
         this.cv_four = 0;
         this.cv_five = 0;     
         this.markuppercent = 0;
         this.totalPrice = 0;
         this.totalCredits = 0; 
         
         this.oneqty = 0;
         this.oneprice = 0;
         this.onetotal = 0;
         this.twoqty = 0;
         this.twoprice = 0;
         this.twototal = 0;
         this.threeqty = 0;
         this.threeprice = 0;
         this.threetotal = 0;
         this.fourqty = 0;
         this.fourprice = 0;
         this.fourtotal = 0;
         this.fiveqty = 0;
         this.fiveprice = 0;
         this.fivetotal = 0;
         
         this.onload = function() {
            this.transactionid = svc.generateTransactionID();
            this.currency = "PHP";
            this.cv_one = 100;
            this.cv_two = 200;
            this.cv_three = 300;
            this.cv_four = 400;
            this.cv_five = 500;
            this.markuppercent = 1.25;
            this.oneprice = this.cv_one * this.markuppercent;
            this.twoprice = this.cv_two * this.markuppercent;
            this.threeprice = this.cv_three * this.markuppercent;
            this.fourprice = this.cv_four * this.markuppercent;
            this.fiveprice = this.cv_five * this.markuppercent;
            
            this.buyone();
         }
         
         this.orderminimumlimit = function() {
            if(this.oneqty == 0 && this.twoqty == 0 && this.threeqty == 0 && this.fourqty == 0 && this.fiveqty == 0) {
               this.totalPrice = 0;
               this.totalCredits = 0;
               this.buyone();
            }
         }
         
         this.buyone = function() {
            this.oneqty++;
            this.onetotal = this.oneqty * this.cv_one * this.markuppercent;
            this.totalPrice = this.totalPrice + (this.cv_one * this.markuppercent);
            this.totalCredits = this.totalCredits + this.cv_one;
         }
         this.unbuyone = function() {
            if(this.oneqty > 0) {
               this.totalPrice = this.totalPrice - (this.cv_one * this.markuppercent);
               this.totalCredits = this.totalCredits - this.cv_one;
               this.oneqty--;
               this.onetotal = this.oneqty * this.cv_one * this.markuppercent;
            }
            
            this.orderminimumlimit();
         }
         
         this.buytwo = function() {
            this.twoqty++;
            this.twototal = this.twoqty * this.cv_two * this.markuppercent;
            this.totalPrice = this.totalPrice + (this.cv_two * this.markuppercent);
            this.totalCredits = this.totalCredits + this.cv_two;
         }
         this.unbuytwo = function() {
            if(this.twoqty > 0) {
               this.totalPrice = this.totalPrice - (this.cv_two * this.markuppercent);
               this.totalCredits = this.totalCredits - this.cv_two;
               this.twoqty--;
               this.twototal = this.twoqty * this.cv_two * this.markuppercent;
            }
            
            this.orderminimumlimit();
         }
         
         this.buythree = function() {
            this.threeqty++;
            this.threetotal = this.threeqty * this.cv_three * this.markuppercent;
            this.totalPrice = this.totalPrice + (this.cv_three * this.markuppercent);
            this.totalCredits = this.totalCredits + this.cv_three;
         }
         this.unbuythree = function() {
            if(this.threeqty > 0) {
               this.totalPrice = this.totalPrice - (this.cv_three * this.markuppercent);
               this.totalCredits = this.totalCredits - this.cv_three;
               this.threeqty--;
               this.threetotal = this.threeqty * this.cv_three * this.markuppercent;
            }
            
            this.orderminimumlimit();
         }
         
         this.buyfour = function() {
            this.fourqty++;
            this.fourtotal = this.fourqty * this.cv_four * this.markuppercent;
            this.totalPrice = this.totalPrice + (this.cv_four * this.markuppercent);
            this.totalCredits = this.totalCredits + this.cv_four;
         }
         this.unbuyfour = function() {
            if(this.fourqty > 0) {
               this.totalPrice = this.totalPrice - (this.cv_four * this.markuppercent);
               this.totalCredits = this.totalCredits - this.cv_four;
               this.fourqty--;
               this.fourtotal = this.fourqty * this.cv_four * this.markuppercent;
            }
            
            this.orderminimumlimit();
         }
         
         this.buyfive = function() {
            this.fiveqty++;
            this.fivetotal = this.fiveqty * this.cv_five * this.markuppercent;
            this.totalPrice = this.totalPrice + (this.cv_five * this.markuppercent);
            this.totalCredits = this.totalCredits + this.cv_five;
         }
         this.unbuyfive = function() {
            if(this.fiveqty > 0) {
               this.totalPrice = this.totalPrice - (this.cv_five * this.markuppercent);
               this.totalCredits = this.totalCredits - this.cv_five;
               this.fiveqty--;
               this.fivetotal = this.fiveqty * this.cv_five * this.markuppercent;
            }
            
            this.orderminimumlimit();
         }
         
         this.paying = function() {
            document.getElementById("customid").value = this.transactionid;
            document.getElementById("currencycode").value = this.currency != "PHP" ? "PHP" : this.currency;
            document.getElementById("business").value = "palen_dhel@yahoo.com.ph";
            document.getElementById("notify_url").value = "http://www.gazeebu.com/classroom/profile/paypalipn.jsp";
            document.getElementById("return_url").value = "http://www.gazeebu.com/classroom/profile.jsp#paymentsuccessful";
              
            this.data = {
               objid:this.userid,
               transactionid:this.transactionid,
               totalprice:this.totalPrice,
               totalcredits:this.totalCredits,
               checkid:svc.encryptIDs(this.userid, this.transactionid),
               paymentcurrency:this.currency,
               status:"DRAFT",
               receiveremail:"palen_dhel@yahoo.com.ph"
            };
            
            this.message  = svc.createDraftOrder(this.data);
        
            if(this.message) 
               alert("Redirecting to Paypal. Please Wait.");
            else
               alert("Error in saving Draft Order.");
               
            return "_close";
         }
      }
   );
</script>
<style>
   .buybutton
   {
      border:0;background:#6fb5f2;color:#4a4e53;
      border-top:1px solid white;
      border-left:1px solid white;
      border-bottom:1px solid #1d65dd;
      border-right:1px solid #1d65dd;
      margin:0;font-weight:bold;
   }
   
   .unbuybutton
   {
      border:0;background:#fcc3a5;color:#4a4e53;
      border-top:1px solid white;
      border-left:1px solid white;
      border-bottom:1px solid #f57a3a;
      border-right:1px solid #f57a3a;
      margin:0;font-weight:bold;
   }
   
   .buyspan
   {
      border:1px solid #255fc3;display:inline-block;padding:0;
   }
   
   .unbuyspan
   {
      border:1px solid #f57a3a;display:inline-block;padding:0;
   }
</style>
<div style="padding:5px;">
   <!-- https://www.paypal.com/cgi-bin/webscr -->
   <!-- https://www.sandbox.paypal.com/cgi-bin/webscr -->
   <form id="payPalForm" action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" target="_blank">
      <table class="page-form-table" width="90%" cellpadding="0" cellspacing="0" border="0"> 
         <tr>
            <th width="60"></th>
            <th width="60">Unit Price</th>
            <th width="90">Quantity</th>
            <th width="90">Price</th>
         </tr>
         
         <!-- Gazeebu Credits:100 -->
         <tr>
            <td class="center padding-top">
               <span class="buyspan">
               <input type="button" value="BUY 100" class="buybutton"
                     r:context="buycredits" r:name="buyone"/>
               </span>
               <span class="unbuyspan">
               <input type="button" value="X" class="unbuybutton"
                     r:context="buycredits" r:name="unbuyone"/>
               </span>
            </td>
            <td class="center padding-top"><label r:context="buycredits">#{oneprice}</label></td>
            <td class="center padding-top"><label r:context="buycredits">#{oneqty}</label></td>
            <td class="center padding-top"><label r:context="buycredits">#{onetotal}</label></td>
         </tr>
         <!-- END:100 -->
         
         <!-- Gazeebu Credits:200 -->
         <tr>
            <td class="center padding-top">
               <span class="buyspan">
               <input type="button" value="BUY 200" class="buybutton"
                     r:context="buycredits" r:name="buytwo"/>
               </span>
               <span class="unbuyspan">
               <input type="button" value="X" class="unbuybutton"
                     r:context="buycredits" r:name="unbuytwo"/>
               </span>
            </td>
            <td class="center padding-top"><label r:context="buycredits">#{twoprice}</label></td>
            <td class="center padding-top"><label r:context="buycredits">#{twoqty}</label></td>
            <td class="center padding-top"><label r:context="buycredits">#{twototal}</label></td>
         </tr>
         <!-- END:200 -->
         
         <!-- Gazeebu Credits:300 -->
         <tr>
            <td class="center padding-top">
               <span class="buyspan">
               <input type="button" value="BUY 300" class="buybutton"
                     r:context="buycredits" r:name="buythree"/>
               </span>
               <span class="unbuyspan">
               <input type="button" value="X" class="unbuybutton"
                     r:context="buycredits" r:name="unbuythree"/>
               </span>
            </td>
            <td class="center padding-top"><label r:context="buycredits">#{threeprice}</label></td>
            <td class="center padding-top"><label r:context="buycredits">#{threeqty}</label></td>
            <td class="center padding-top"><label r:context="buycredits">#{threetotal}</label></td>
         </tr>
         <!-- END:300 -->
         
         <!-- Gazeebu Credits:400 -->
         <tr>
            <td class="center padding-top">
               <span class="buyspan">
               <input type="button" value="BUY 400" class="buybutton"
                     r:context="buycredits" r:name="buyfour"/>
               </span>
               <span class="unbuyspan">
               <input type="button" value="X" class="unbuybutton"
                     r:context="buycredits" r:name="unbuyfour"/>
               </span>
            </td>
            <td class="center padding-top"><label r:context="buycredits">#{fourprice}</label></td>
            <td class="center padding-top"><label r:context="buycredits">#{fourqty}</label></td>
            <td class="center padding-top"><label r:context="buycredits">#{fourtotal}</label></td>
         </tr>
         <!-- END:400 -->
         
         <!-- Gazeebu Credits:400 -->
         <tr>
            <td class="center padding-top">
               <span class="buyspan">
               <input type="button" value="BUY 500" class="buybutton"
                     r:context="buycredits" r:name="buyfive"/>
               </span>
               <span class="unbuyspan">
               <input type="button" value="X" class="unbuybutton"
                     r:context="buycredits" r:name="unbuyfive"/>
               </span>
            </td>
            <td class="center padding-top"><label r:context="buycredits">#{fiveprice}</label></td>
            <td class="center padding-top"><label r:context="buycredits">#{fiveqty}</label></td>
            <td class="center padding-top"><label r:context="buycredits">#{fivetotal}</label></td>
         </tr>
         <!-- END:500 -->
         
         <!-- Summary -->
         <tr>
            <td></td>
            <td></td>
            <td colspan="2" class="right padding-top">
               <table class="page-form-table" 
                     width="100%" 
                     cellpadding="0" 
                     cellspacing="0" 
                     border="0">
                  <tr>
                     <th colspan="2">
                        Purchase Summary
                     </th>
                  </tr>
                  <tr class="caption">
                     <td>Total Price: &nbsp&nbsp</td>
                     <td style="text-align:right;">
                        <input type="hidden" name="item_name" value="Gazeebu Credits">
                        <input type="hidden" name="item_number" value="Credits">
                        <input type="text" name="amount" 
                              r:context="buycredits" 
                              r:name="totalPrice" 
                              size="5"
                              readonly 
                              style="text-align:right;border:0;background:transparent;">
                     </td>
                  </tr>
                  <tr>
                     <td class="caption">Total Credits: &nbsp&nbsp</td>
                     <td style="text-align:right;">
                        <label r:context="buycredits">#{totalCredits}</label>
                     </td>
                  </tr>
                  <tr>
                     <td colspan="2" class="right">
                        <div style="float:right;">
                           <input type="submit" 
                                 style="background:url('img/btn_xpressCheckout.gif'); padding-right:140px;padding-bottom:21px;border:0;"
                                 name="submit" 
                                 value=""
                                 alt="PayPal - The safer, easier way to pay online!"
                                 r:context="buycredits"
                                 r:name="paying">
                        </div>

                        <input type="hidden" name="cmd" value="_xclick">
                        <input type="hidden" name="business" id="business" value="">
                        <input type="hidden" name="currency_code" id="currencycode" value="">
                        <input type="hidden" name="upload" value="1">
                        <input type="hidden" name="notify_url" id="notify_url" value="">
                        <input type="hidden" name="at" value="TestGazeebuPaypal">
                        <input type="hidden" name="return" id="return_url" value=""> 
                        <input type="hidden" name="paymentaction" value="sale">
                        <input type="hidden" name="custom" id="customid" value=""> 
                     </td>
                  </tr>
               </table>
            </td>
         </tr>
      </table>
   </form>
</div>
