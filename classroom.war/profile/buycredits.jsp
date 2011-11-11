<script>
   $put("buycredits", 
      new function() {
         this.markuppercent = 1.25;
         this.totalPrice = 0;
         this.totalCredits = 0;
         
         this.oneqty = 0;
         this.oneprice = 100 * this.markuppercent;
         this.onetotal = 0;
         
         this.twoqty = 0;
         this.twoprice = 200 * this.markuppercent;
         this.twototal = 0;
         
         this.threeqty = 0;
         this.threeprice = 300 * this.markuppercent;
         this.threetotal = 0;
         
         this.fourqty = 0;
         this.fourprice = 400 * this.markuppercent;
         this.fourtotal = 0;
         
         this.fiveqty = 0;
         this.fiveprice = 500 * this.markuppercent;
         this.fivetotal = 0;
         
         this.buyone = function() {
            this.oneqty += 1;
            this.onetotal = this.oneqty * 100 * this.markuppercent;
            this.totalPrice = this.totalPrice + (100 * this.markuppercent);
            this.totalCredits = this.totalCredits + 100;
         }
         this.unbuyone = function() {
            if(this.oneqty > 0) {
               this.totalPrice = this.totalPrice - (100 * this.markuppercent);
               this.totalCredits = this.totalCredits - 100;
               this.oneqty -= 1;
               this.onetotal = this.oneqty * 100 * this.markuppercent;
            }
         }
         
         this.buytwo = function() {
            this.twoqty += 1;
            this.twototal = this.twoqty * 200 * this.markuppercent;
            this.totalPrice = this.totalPrice + (200 * this.markuppercent);
            this.totalCredits = this.totalCredits + 200;
         }
         this.unbuytwo = function() {
            if(this.twoqty > 0) {
               this.totalPrice = this.totalPrice - (200 * this.markuppercent);
               this.totalCredits = this.totalCredits - 200;
               this.twoqty -= 1;
               this.twototal = this.twoqty * 200 * this.markuppercent;
            }
         }
         
         this.buythree = function() {
            this.threeqty += 1;
            this.threetotal = this.threeqty * 300 * this.markuppercent;
            this.totalPrice = this.totalPrice + (300 * this.markuppercent);
            this.totalCredits = this.totalCredits + 300;
         }
         this.unbuythree = function() {
            if(this.threeqty > 0) {
               this.totalPrice = this.totalPrice - (300 * this.markuppercent);
               this.totalCredits = this.totalCredits - 300;
               this.threeqty -= 1;
               this.threetotal = this.threeqty * 300 * this.markuppercent;
            }
         }
         
         this.buyfour = function() {
            this.fourqty += 1;
            this.fourtotal = this.fourqty * 400 * this.markuppercent;
            this.totalPrice = this.totalPrice + (400 * this.markuppercent);
            this.totalCredits = this.totalCredits + 400;
         }
         this.unbuyfour = function() {
            if(this.fourqty > 0) {
               this.totalPrice = this.totalPrice - (400 * this.markuppercent);
               this.totalCredits = this.totalCredits - 400;
               this.fourqty -= 1;
               this.fourtotal = this.fourqty * 400 * this.markuppercent;
            }
         }
         
         this.buyfive = function() {
            this.fiveqty += 1;
            this.fivetotal = this.fiveqty * 500 * this.markuppercent;
            this.totalPrice = this.totalPrice + (500 * this.markuppercent);
            this.totalCredits = this.totalCredits + 500;
         }
         this.unbuyfive = function() {
            if(this.fiveqty > 0) {
               this.totalPrice = this.totalPrice - (500 * this.markuppercent);
               this.totalCredits = this.totalCredits - 500;
               this.fiveqty -= 1;
               this.fivetotal = this.fiveqty * 500 * this.markuppercent;
            }
         }
         
         this.paying = function() {
            alert("Redirecting to Paypal. Please Wait.");
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
   <form id="payPalForm" action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" target="_blank">
      <table class="page-form-table" width="90%" cellpadding="0" cellspacing="0" border="0"> 
         <tr>
            <th width="60">Denomination</th>
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
                  <tr>
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
                     <td>Total Credits: &nbsp&nbsp</td>
                     <td style="text-align:right;">
                        <label r:context="buycredits">#{totalCredits}</label>
                     </td>
                  </tr>
                  <tr>
                     <td colspan="2" class="right">
                        <input type="submit" name="PaypalPayment" value="Pay Now"
                              r:context="buycredits"
                              r:name="paying">
                        <!-- IMPORTANT HERE -->
                        <input type="hidden" name="cmd" value="_xclick">
                        <input type="hidden" name="business" value="palen_dhel@yahoo.com.ph">
                        <input type="hidden" name="currency_code" value="PHP">
                        <input type="hidden" name="upload" value="1">
                        <input type="hidden" name="at" value="TestGazeebuPaypal">
                        <input type="hidden" name="return" value="http://www.gazeebu.com/classroom/profile/paymentsuccessful.jsp"> 
                        <input type="hidden" name="paymentaction" value="sale">
                        <input type="hidden" name="custom" value="000121x423"> 
                     </td>
                  </tr>
               </table>
            </td>
         </tr>
      </table>
   </form>
</div>
