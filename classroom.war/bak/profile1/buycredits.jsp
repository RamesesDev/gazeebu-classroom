<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Buy Credits">
   <script>
      $put("buycredits", 
         new function() {
            this.markuppercent = 1.25;
            this.one = 0;
            this.two = 0;
            this.three = 0;
            this.four = 0;
            this.five = 0;
            this.total = 0;
            
            this.submit = function() {
               this.total = (this.one * 100 * this.markuppercent) + (this.two * 200 * this.markuppercent) + (this.three * 300 * this.markuppercent) + (this.four * 400 * this.markuppercent) + (this.five * 500 * this.markuppercent);
            }
            
            this.buyone = function() {
               this.one += 1;
               this.total = this.total + (this.one * 100 * this.markuppercent);
            }
            this.removeone = function() {
               if(this.one > 0) {
                  this.total = this.total - (this.one * 100 * this.markuppercent);
                  this.one -= 1;
               }
            }
            
            this.buytwo = function() {
               this.two += 1;
               this.total = this.total + (this.two * 200 * this.markuppercent);
            }
            this.removetwo = function() {
               if(this.two > 0) {
                  this.total = this.total - (this.two * 200 * this.markuppercent);
                  this.two -= 1;
               }
            }
            
            this.buythree = function() {
               this.three += 1;
               this.total = this.total + (this.three * 300 * this.markuppercent);
            }
            this.removethree = function() {
               if(this.three > 0) {
                  this.total = this.total - (this.three * 300 * this.markuppercent);
                  this.three -= 1;
               }
            }
            
            this.buyfour = function() {
               this.four += 1;
               this.total = this.total + (this.four * 400 * this.markuppercent);
            }
            this.removefour = function() {
               if(this.four > 0) {
                  this.total = this.total - (this.four * 400 * this.markuppercent);
                  this.four -= 1;
               }
            }
            
            this.buyfive = function() {
               this.five += 1;
               this.total = this.total + (this.five * 500 * this.markuppercent);
            }
            this.removefive = function() {
               if(this.five > 0) {
                  this.total = this.total - (this.five * 500 * this.markuppercent);
                  this.five -= 1;
               }
            }
         }
      );
   </script>

   <table class="page-form-table" width="40%" cellpadding="0" cellspacing="0" border="0">
      <tr>
         <th>Denomination</th>
         <th>Quantity</th>
         <th>Price</th>
      </tr>
      <tr>
         <td width="20%" class="center padding-top">
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
         <td width="10%" class="center padding-top">
            <label r:context="buycredits">#{one}</label>
         </td>
         <td width="10%" class="center padding-top">
            <label r:context="buycredits" r:depends="one">#{one * 100 * markuppercent}</label>
         </td>
      </tr>
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
            <label r:context="buycredits">#{two}</label>
         </td>
         <td class="center padding-top">
            <label r:context="buycredits" r:depends="one">#{two * 200 * markuppercent}</label>
         </td>
      </tr>   
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
            <label r:context="buycredits">#{three}</label>
         </td>
         <td class="center padding-top">
            <label r:context="buycredits" r:depends="one">#{three * 300 * markuppercent}</label>
         </td>
      </tr>
      <tr>
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
            <label r:context="buycredits">#{four}</label>
         </td>
         <td class="center padding-top">
            <label r:context="buycredits" r:depends="one">#{four * 400 * markuppercent}</label>
         </td>
      </tr>
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
            <label r:context="buycredits">#{five}</label>
         </td>
         <td class="center padding-top">
            <label r:context="buycredits" r:depends="one">#{five * 500 * markuppercent}</label>
         </td>
      </tr>
      <tr>
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
                  <td>Total: &nbsp&nbsp</td>
                  <td>
                     <label r:context="buycredits">#{total}</label>
                  </td>
               </tr>
               <tr>
                  <td colspan="2" class="right">
                     <input type="button" r:context="buycredits" r:name="submit" value="Checkout with Paypal"/>
                  </td>
               </tr>
            </table>
         </td>
      </tr>
   </table>
   
</t:content>
