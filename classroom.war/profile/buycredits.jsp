<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Buy Credits">
   <script>
      $put("buycredits", 
         new function() {
            var creditsvc = ProxyService.lookup("CreditService");
            
            this.markuppercent = 1.25;
            this.one = 0;
            this.two = 0;
            this.three = 0;
            this.four = 0;
            this.five = 0;
            this.onetotal = 0;
            this.twototal = 0;
            this.threetotal = 0;
            this.fourtotal = 0;
            this.fivetotal = 0;
            this.totalPrice = 0;
            this.totalCredits = 0;
            
            this.submit = function() {
               this.totalPrice = (this.one * 100 * this.markuppercent) + 
                                 (this.two * 200 * this.markuppercent) + 
                                 (this.three * 300 * this.markuppercent) + 
                                 (this.four * 400 * this.markuppercent) + 
                                 (this.five * 500 * this.markuppercent);
            }
            
            this.buyone = function() {
               this.one += 1;
               this.onetotal = this.one * 100 * this.markuppercent;
               this.totalPrice = this.totalPrice + (100 * this.markuppercent);
               this.totalCredits = this.totalCredits + 100;
            }
            this.removeone = function() {
               if(this.one > 0) {
                  this.totalPrice = this.totalPrice - (100 * this.markuppercent);
                  this.totalCredits = this.totalCredits - 100;
                  this.one -= 1;
                  this.onetotal = this.one * 100 * this.markuppercent;
               }
            }
            
            this.buytwo = function() {
               this.two += 1;
               this.twototal = this.two * 200 * this.markuppercent;
               this.totalPrice = this.totalPrice + (200 * this.markuppercent);
               this.totalCredits = this.totalCredits + 200;
            }
            this.removetwo = function() {
               if(this.two > 0) {
                  this.totalPrice = this.totalPrice - (200 * this.markuppercent);
                  this.totalCredits = this.totalCredits - 200;
                  this.two -= 1;
                  this.twototal = this.two * 200 * this.markuppercent;
               }
            }
            
            this.buythree = function() {
               this.three += 1;
               this.threetotal = this.three * 300 * this.markuppercent;
               this.totalPrice = this.totalPrice + (300 * this.markuppercent);
               this.totalCredits = this.totalCredits + 300;
            }
            this.removethree = function() {
               if(this.three > 0) {
                  this.totalPrice = this.totalPrice - (300 * this.markuppercent);
                  this.totalCredits = this.totalCredits - 300;
                  this.three -= 1;
                  this.threetotal = this.three * 300 * this.markuppercent;
               }
            }
            
            this.buyfour = function() {
               this.four += 1;
               this.fourtotal = this.four * 400 * this.markuppercent;
               this.totalPrice = this.totalPrice + (400 * this.markuppercent);
               this.totalCredits = this.totalCredits + 400;
            }
            this.removefour = function() {
               if(this.four > 0) {
                  this.totalPrice = this.totalPrice - (400 * this.markuppercent);
                  this.totalCredits = this.totalCredits - 400;
                  this.four -= 1;
                  this.fourtotal = this.four * 400 * this.markuppercent;
               }
            }
            
            this.buyfive = function() {
               this.five += 1;
               this.fivetotal = this.five * 500 * this.markuppercent;
               this.totalPrice = this.totalPrice + (500 * this.markuppercent);
               this.totalCredits = this.totalCredits + 500;
            }
            this.removefive = function() {
               if(this.five > 0) {
                  this.totalPrice = this.totalPrice - (500 * this.markuppercent);
                  this.totalCredits = this.totalCredits - 500;
                  this.five -= 1;
                  this.fivetotal = this.five * 500 * this.markuppercent;
               }
            }
            
            this.paying = function() {
               alert("going to paypal");
            }
         }
      );
   </script>
   
   <form id="payPalForm" action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post">      
      <table class="page-form-table" width="60%" cellpadding="0" cellspacing="0" border="0"> 
         <tr>
            <th width="60">Denomination</th>
            <th width="60">Unit Price</th>
            <th width="90">Quantity</th>
            <th width="90">Price</th>
         </tr>
         
         <!-- Gazeebu Credits:100 -->
         <tr>
            <td class="center padding-top">
               <span style="border:1px solid #255fc3;display:inline-block;padding:0;">
               <input type="button" 
                     r:context="buycredits" 
                     r:name="buyone" 
                     value="BUY 100"
                     style="border:0;background:#6fb5f2;color:#4a4e53;
                           border-top:1px solid white;
                           border-left:1px solid white;
                           border-bottom:1px solid #1d65dd;
                           border-right:1px solid #1d65dd;
                           margin:0;font-weight:bold;"/>
               </span>
               <span style="border:1px solid #f57a3a;display:inline-block;padding:0;">
               <input type="button" 
                     r:context="buycredits" 
                     r:name="removeone" 
                     value="X"
                     style="border:0;background:#fcc3a5;color:#4a4e53;
                        border-top:1px solid white;
                        border-left:1px solid white;
                        border-bottom:1px solid #f57a3a;
                        border-right:1px solid #f57a3a;
                        margin:0;font-weight:bold;"/>
               </span>
            </td>
            <td class="center padding-top">
               <label r:context="buycredits"> #{markuppercent * 100} </label>
            </td>
            <td class="center padding-top">
               <input type="hidden" name="item_name_1" value="Gazeebu Credits:100">
               <input type="hidden" name="item_number_1" value="Credits:100">
               <input type="text" name="quantity_1" 
                     r:context="buycredits" 
                     r:name="one"
                     size="5"
                     readonly>
            </td>
            <td class="center padding-top">
               <input type="text" name="amount_1" 
                     r:context="buycredits" 
                     r:name="onetotal"
                     size="5"
                     readonly>
            </td>
         </tr>
         <!-- End:100-->
         
         <!-- Gazeebu Credits:200 -->
         <tr>  
            <td class="center padding-top">
               <span style="border:1px solid #255fc3;display:inline-block;padding:0;">
                  <input type="button" 
                        r:context="buycredits" 
                        r:name="buytwo" 
                        value="BUY 200"
                        style="border:0;background:#6fb5f2;color:#4a4e53;
                              border-top:1px solid white;
                              border-left:1px solid white;
                              border-bottom:1px solid #1d65dd;
                              border-right:1px solid #1d65dd;
                              margin:0;font-weight:bold;"/>
               </span>
               <span style="border:1px solid #f57a3a;display:inline-block;padding:0;">
                  <input type="button" 
                        r:context="buycredits" 
                        r:name="removetwo" 
                        value="X"
                        style="border:0;background:#fcc3a5;color:#4a4e53;
                              border-top:1px solid white;
                              border-left:1px solid white;
                              border-bottom:1px solid #f57a3a;
                              border-right:1px solid #f57a3a;
                              margin:0;font-weight:bold;"/>
               </span>
            </td>
            <td class="center padding-top">
               <label r:context="buycredits"> #{markuppercent * 200} </label>
            </td>
            <td class="center padding-top">
               <input type="hidden" name="item_name_2" value="Gazeebu Credits:200">
               <input type="hidden" name="item_number_2" value="Credits:200">
               <input type="text" name="quantity_2" 
                     r:context="buycredits" 
                     r:name="two"
                     size="5"
                     readonly>
            </td>
            <td class="center padding-top">
               <input type="text" name="amount_2" 
                     r:context="buycredits" 
                     r:name="twototal" 
                     size="5"
                     readonly>
            </td>
         </tr>
         <!-- End:200 -->
         
         <!-- Gazeebu Credits:300 -->
         <tr>
            <td class="center padding-top">
               <span style="border:1px solid #255fc3;display:inline-block;padding:0;">
                  <input type="button"
                        r:context="buycredits" 
                        r:name="buythree" 
                        value="BUY 300"
                        style="border:0;background:#6fb5f2;color:#4a4e53;
                              border-top:1px solid white;
                              border-left:1px solid white;
                              border-bottom:1px solid #1d65dd;
                              border-right:1px solid #1d65dd;
                              margin:0;font-weight:bold;"/>
               </span>
               <span style="border:1px solid #f57a3a;display:inline-block;padding:0;">
                  <input type="button"
                        r:context="buycredits" 
                        r:name="removethree" 
                        value="X"
                        style="border:0;background:#fcc3a5;color:#4a4e53;
                              border-top:1px solid white;
                              border-left:1px solid white;
                              border-bottom:1px solid #f57a3a;
                              border-right:1px solid #f57a3a;
                              margin:0;font-weight:bold;"/>
               </span>
            </td>
            <td class="center padding-top">
               <label r:context="buycredits"> #{markuppercent * 300} </label>
            </td>
            <td class="center padding-top">
               <input type="hidden" name="item_name_3" value="Gazeebu Credits:300">
               <input type="hidden" name="item_number_3" value="Credits:300">
               <input type="text" name="quantity_3" 
                     r:context="buycredits" 
                     r:name="three"
                     size="5"
                     readonly>
            </td>
            <td class="center padding-top">
               <input type="text" name="amount_3" 
                     r:context="buycredits" 
                     r:name="threetotal" 
                     size="5"
                     readonly>
            </td>
         </tr>
         <!-- End:300 -->
         
         <!-- Gazeebu Credits:400 -->
            <td class="center padding-top">
               <span style="border:1px solid #255fc3;display:inline-block;padding:0;">
                  <input type="button"
                        r:context="buycredits" 
                        r:name="buyfour" 
                        value="BUY 400"
                        style="border:0;background:#6fb5f2;color:#4a4e53;
                              border-top:1px solid white;
                              border-left:1px solid white;
                              border-bottom:1px solid #1d65dd;
                              border-right:1px solid #1d65dd;
                              margin:0;font-weight:bold;"/>
               </span>
               <span style="border:1px solid #f57a3a;display:inline-block;padding:0;">
                  <input type="button"
                        r:context="buycredits" 
                        r:name="removefour" 
                        value="X"
                        style="border:0;background:#fcc3a5;color:#4a4e53;
                              border-top:1px solid white;
                              border-left:1px solid white;
                              border-bottom:1px solid #f57a3a;
                              border-right:1px solid #f57a3a;
                              margin:0;font-weight:bold;"/>
               </span>
            </td>
            <td class="center padding-top">
               <label r:context="buycredits"> #{markuppercent * 400} </label>
            </td>
            <td class="center padding-top">
               <input type="hidden" name="item_name_4" value="Gazeebu Credits:400">
               <input type="hidden" name="item_number_4" value="Credits:400">
               <input type="text" name="quantity_4" 
                     r:context="buycredits" 
                     r:name="four"
                     size="5"
                     readonly>
            </td>
            <td class="center padding-top">
               <input type="text" name="amount_4" 
                     r:context="buycredits" 
                     r:name="fourtotal" 
                     size="5"
                     readonly>
            </td>
         <!-- End:400-->
         
         <!-- Gazeebu Credits:500 -->
         <tr>
            <td class="center padding-top">
               <span style="border:1px solid #255fc3;display:inline-block;padding:0;">
                  <input type="button" 
                        r:context="buycredits" 
                        r:name="buyfive" 
                        value="BUY 500"
                        style="border:0;background:#6fb5f2;color:#4a4e53;
                              border-top:1px solid white;
                              border-left:1px solid white;
                              border-bottom:1px solid #1d65dd;
                              border-right:1px solid #1d65dd;
                              margin:0;font-weight:bold;"/>
               </span>
               <span style="border:1px solid #f57a3a;display:inline-block;padding:0;">
                  <input type="button"
                        r:context="buycredits" 
                        r:name="removefive" 
                        value="X"
                        style="border:0;background:#fcc3a5;color:#4a4e53;
                              border-top:1px solid white;
                              border-left:1px solid white;
                              border-bottom:1px solid #f57a3a;
                              border-right:1px solid #f57a3a;
                              margin:0;font-weight:bold;"/>
               </span>
            </td>
            <td class="center padding-top">
               <label r:context="buycredits"> #{markuppercent * 500} </label>
            </td>
            <td class="center padding-top">
               <input type="hidden" name="item_name_5" value="Gazeebu Credits:500">
               <input type="hidden" name="item_number_5" value="Credits:500">
               <input type="text" name="quantity_5" 
                     r:context="buycredits" 
                     r:name="five"
                     size="5"
                     readonly>
            </td>
            <td class="center padding-top">
               <input type="text" name="amount_5" 
                     r:context="buycredits" 
                     r:name="fivetotal" 
                     size="5"
                     readonly>
            </td>
         </tr>
         <!-- End:500 -->
         
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
                        <label r:context="buycredits">#{totalPrice}</label>
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
                        <input type="hidden" name="cmd" value="_cart">
                        <input type="hidden" name="business" value="palen__1317697568_biz@yahoo.com.ph">
                        <input type="hidden" name="currency_code" value="PHP">
                        <input type="hidden" name="upload" value="1">
                        <input type="hidden" name="tx" value="000121x423"> 
                        <input type="hidden" name="at" value="TestGazeebuPaypal">
                        <input type="hidden" name="notify_url" value="http://gazeebu.com/classroom/profile/paypalipn.jsp">
                        <!--
                        <input type="hidden" name="return" value="return_url"> 
                        -->
                     </td>
                  </tr>
               </table>
            </td>
         </tr>
      </table>
   </form>
</t:content>
