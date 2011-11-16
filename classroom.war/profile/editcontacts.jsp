<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<t:popup>
	<jsp:attribute name="head">
		<script>
		   Registry.add({id:"addcontact", page:"profile/addcontact.jsp", context:"addcontact"});
		   $put("editcontacts", 
			  new function() 
			  {
				 var svc = ProxyService.lookup("UserProfileService");
				 this.user = {};
				 this.handler;
				 this.selectedIndex;
				 
				 this.contacts;
				 
				 this.types = [
					"MOBILE", "LANDLINE", "WEBSITE"
				 ];
				 
				 this.onload = function() {
					if( !this.user.contacts ) this.user.contacts = [];
					this.contacts = [];
					for(var i=0; i<this.user.contacts.length; ++i) this.contacts.push(this.user.contacts[i]);
					if( this.contacts.length == 0 ) this.addanothercontact();
				 }
				 
				 this.save = function() {
					this.user.contacts.remove(0,-1);
					for(var i=0; i<this.contacts.length; ++i) {
						var c = this.contacts[i];
						if( !c.value ) continue;
						this.user.contacts.push(c);
					}
					
					svc.update(this.user);
					if(this.handler)
					   this.handler();
					   
					return "_close";
				 }
				 
				 this.addanothercontact = function() {
					this.contacts.push({type:"", value:""});
				 }
				 
				 this.deleteContact = function() {
					this.contacts.splice( this.selectedIndex, 1 );
					if( this.contacts.length == 0 ) this.addanothercontact();
				 }
			  }
		   );
		</script>
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<button r:context="editcontacts" r:name="addanothercontact">
			Add another Contact
		</button>
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<input type="button" 
		   r:context="editcontacts" 
		   r:name="save" 
		   value="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<div style="overflow:auto;height:200px">
			<table r:context="editcontacts" r:items="contacts" r:varStatus="n" 
			       class="page-form-table" width="200" cellpadding="0" cellspacing="0" border="0">
				<tbody>
					<tr>
						<td>
							<select r:context="editcontacts" r:items="types" r:name="contacts[#{n.index}].type"></select>
						</td>
						<td>
							<input type="text" class="text"
								r:context="editcontacts"
								r:name="contacts[#{n.index}].value"
								r:hint="Value"/>
						</td>
						<td class="controls" style="padding-left:5px;">
							<a r:context="editcontacts" r:name="deleteContact" r:params="{selectedIndex: #{n.index}}" class="close">
								X
							</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</jsp:body>
</t:popup>
