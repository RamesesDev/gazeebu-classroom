<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:popup>
   <jsp:attribute name="script">
      $put("addemail", 
         new function() {
            this.emails;
            this.entity={};
            
            this.add = function() {
               this.emails.push(this.entity);
               return "_close";
            }
         }
      );
   </jsp:attribute>
   <jsp:body>
      <table class="page-form-table" cellpadding="0" cellspacing="0" border="0">
         <tr>
            <td class="right text-top padding-top"> Email: &nbsp&nbsp</td>
            <td class="text-top padding-top">
               <input type="text" class="text" r:context="addemail" r:name="entity.email"/>
            </td>
         </tr>
         <tr>
            <td class="text-top padding-top"></td>
            <td class="text-top padding-top">
               <input type="button" href="#" r:context="addemail" r:name="add" value="Add Email"/>
            </td>
         </tr>
      </table>
   </jsp:body>
</t:popup>
