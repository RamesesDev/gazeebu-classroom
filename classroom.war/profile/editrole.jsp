<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<t:popup>
	<jsp:attribute name="head">
		<script>
		   $put("editrole", 
			  new function() {
				 var svc = ProxyService.lookup("UserProfileService");
				 this.user = {};
				 this.handler;  
				 
				 this.isteacher = false;
				 this.isstudent = false;
				 this.isparent = false;
				 
				 this.onload = function() {
					this.roles = this.user.roles.split("|");
					for(var i=0 ; i<this.roles.length ; i++) {
					   if(this.roles[i] == "teacher")
						  this.isteacher = true;
					   if(this.roles[i] == "student")
						  this.isstudent = true;
					   if(this.roles[i] == "parent")
						  this.isparent = true;
					}
				 }
				 
				 this.save = function() {
					this.user.roles = "";
					if(this.isteacher)
					   this.user.roles =  "teacher";
					if(this.isstudent) {
					   if(this.user.roles != "")
						  this.user.roles = this.user.roles + "|student";
					   else
						  this.user.roles = "student";
					}
					if(this.isparent) {
					   if(this.user.roles != "")
						  this.user.roles = this.user.roles + "|parent";
					   else
						  this.user.roles = "parent";
					}
					
					if(this.user.roles == "") {
					   alert("Please specify a role.");
					   return;
					}
				 
					svc.update(this.user);
					if(this.handler)
					   this.handler();
					
					return "_close";
				 }
			  }
		   );
		</script>
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<input type="button" 
		   r:context="editrole" 
		   r:name="save" 
		   value="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<table class="page-form-table" cellpadding="0" cellspacing="0" border="0" width="40%">
		  <tr>
			  <td class="caption left text-top">Roles</td>
			  <td>
				  <input type="checkbox" 
					 r:context="editrole" 
					 r:name="isteacher"/>Teacher<br>
				  <input type="checkbox" 
					 r:context="editrole" 
					 r:name="isstudent"/>Student<br>
				  <input type="checkbox" 
					 r:context="editrole" 
					 r:name="isparent"/>Parent<br>
			  </td>
		  </tr>
		</table>
	</jsp:body>
</t:popup>
