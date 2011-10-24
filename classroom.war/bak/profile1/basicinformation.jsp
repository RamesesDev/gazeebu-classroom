<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Edit Profile">
   <script src="js/ext/birthdate.js"></script>
   <script>
      $put("basicinformation",
         new function() {
            var svc = ProxyService.lookup("AccountService");
            this.user = svc.getInfo({objid:"TCH74a18681:131daf6cf9f:-7ffe"});
            
            this.gender = ["Male", "Female"];
            this.month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Nov", "Dec"];
            this.day = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"];
            this.year = ["1987","1988", "1989", "1990", "1991", "1992"];
            
            this.save = function() {
               alert("save");
            }
            
            this.birthdate = new DateModel(02, 17, 1989);
         }
      );
   </script>
   
   <table class="page-form-table" width="80%" cellpadding="0" cellspacing="0" border="0">
      <tr>
         <td class="caption right text-top padding-top">Current City: &nbsp&nbsp</td>
         <td class="text-top padding-top" colspan="2">
            <input type="text" class="text" r:context="basicinformation" r:name="user.currentcity" caption="Current City" size="60%"> 
         </td>
      </tr>
      <tr class="bottom-border">
         <td class="caption right text-top padding-bottom">Hometown City: &nbsp&nbsp</td>
         <td class="text-top padding-bottom"> 
            <input type="text" class="text" r:context="basicinformation" r:name="user.homecity" r:caption="HomeTown City" size="60%"> 
         </td>
      </tr>
      <tr class="bottom-border">
         <td class="caption right text-top padding-bottom padding-top">I am:&nbsp&nbsp</td>
         <td class="text-top padding-bottom padding-top"> 
            <select r:context="basicinformation" r:name="user.gender" r:caption="Gender" r:items="gender" r:required="true"></select>
         </td>
      </tr>
      <tr>
         <td class="caption right text-top padding-top">Birthday: &nbsp&nbsp</td>
         <td class="text-top padding-top" colspan="2"> 
            <birthdate r:context="basicinformation" r:model="birthdate"/>
         </td>
      </tr>
      <tr class="bottom-border">
         <td class="caption right text-top padding-bottom padding-top">Languages: &nbsp&nbsp</td>
         <td class="text-top padding-bottom padding-top"> 
            <input type="text" class="text" r:context="basicinformation" r:name="user.languages" size="60%"> 
         </td>
      </tr> 
      <tr class="bottom-border">
         <td class="caption right text-top padding-bottom padding-top">About Me: &nbsp&nbsp</td>
         <td class="text-top padding-bottom padding-top" colspan="2"> 
            <textarea r:context="basicinformation" r:name="user.aboutme" rows="2" cols="40%">
            </textarea>
         </td>
      </tr>
      <tr>
         <td class="caption right text-top padding-bottom padding-top"></td>
         <td class="text-top padding-bottom padding-top" colspan="2">
            <input type="button" class="button" href="#" r:context="basicinformation" r:name="save" value="Save Changes"/>
         </td>
      </tr>
   </table>
   
</t:content>
