<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content>
   <jsp:attribute name="script">
      $put("basicinformation",
         new function() {
            var svc = ProxyService.lookup("AccountService");
            this.user = svc.getUser({uid:"00001"});
            
            this.gender = ["Male", "Female"];
            this.month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
            this.day = ["1", "2", "3", "4", "5", "6"];
            this.year = ["1988", "1989", "1990", "1991", "1992"];
            
            this.save = function() {
               alert("save");
            }
         }
      );
   </jsp:attribute>
<jsp:body>
   <label class="header" r:context="basicinformation">
      #{user.firstname} #{user.lastname} <img src="images/next.png"> Edit Profile
   </label>
   <br><br>
   <table class="page-form-table" width="80%" cellpadding="0" cellspacing="0" border="0">
      <tr>
         <td class="caption right text-top padding-top">Current City: &nbsp&nbsp</td>
         <td class="text-top padding-top" colspan="2">
            <input type="text" class="text" r:context="basicinformation" r:name="user.currentcity" caption="Current City" size="60%"> 
         </td>
      </tr>
      <tr class="bottom-border">
         <td class="caption right text-top padding-bottom">Hometown City: &nbsp&nbsp</td>
         <td class="text-top padding-bottom" colspan="2"> 
            <input type="text" class="text" r:context="basicinformation" r:name="user.homecity" r:caption="HomeTown City" size="60%"> 
         </td>
      </tr>
      <tr class="bottom-border">
         <td class="caption right text-top padding-bottom padding-top">I am:&nbsp&nbsp</td>
         <td class="text-top padding-bottom padding-top"> 
            <select r:context="basicinformation" nr:ame="user.gender" r:caption="Gender" r:items="gender" r:required="true"></select>
         </td>
         <td class="padding-bottom padding-top">
            <input type="checkbox" r:context="basicinformation" r:name="user.showgender" r:caption="Show Gender" r:mode="set" r:checkedValue="true"/> show my sex in my profile<br>
         </td>
      </tr>
      <tr>
         <td class="caption right text-top padding-top">Birthday: &nbsp&nbsp</td>
         <td class="text-top padding-top" colspan="2"> 
            <select r:context="basicinformation" r:name="user.month" r:caption="Month" r:items="month" r:required="true"></select>
            <select r:context="basicinformation" r:name="user.day" r:caption="Day" r:items="day"></select>
            <select r:context="basicinformation" r:name="user.year" r:caption="Year" r:items="year"></select>
         </td>
      </tr>
      <tr class="bottom-border">
         <td class="caption right text-top padding-bottom"></td>
         <td class="text-top padding-bottom" colspan="2"> 
            <input type="checkbox" r:context="basicinformation" r:name="user.birthdaysetting" r:caption="Birthday Setting" r:mode="set" r:checkedValue="true"/> show my birthday in my profile<br>
         </td>
      </tr>
      <tr class="bottom-border">
         <td class="caption right text-top padding-bottom padding-top">Interested In: &nbsp&nbsp</td>
         <td class="text-top padding-bottom padding-top" colspan="2"> 
            <input type="checkbox" r:context="basicinformation" r:name="user.women" r:mode="set" r:checkedValue="true"/>Women
            <input type="checkbox" r:context="basicinformation" r:name="user.men" r:mode="set" r:checkedValue="true"/>Men
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
   </jsp:body>
</t:content>
