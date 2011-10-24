<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>	
    $put("teacher_invite", 
	
        new function() {
			this.entry = {emails:[]};
			
			var svc = ProxyService.lookup("TeacherInviteService");
			this.email;
			this.submit = function() {
				svc.send( this.entry );
				return "_close";
			}
			
			this.add = function() {
				if( this.email ) {
					this.entry.emails.push( {email: this.email} );
					this.email = null;
				}
			}
        }
    );    
</script>

<t:popup>

	<jsp:attribute name="leftactions">
		<input type="button" context="teacher_invite" name="submit" value="Submit"/>
	</jsp:attribute>
	
	<jsp:body>
		Message <input type="text" context="teacher_invite" name="entry.message" /><br>
		<table context="teacher_invite" items="entry.emails" varName="item" varStatus="stat">
			<tbody>
				<tr>
					<td>#{item.email}</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<input type="text" context="teacher_invite" name="email"/>
					<input type="button" context="teacher_invite" name="add" value="Add"/>
				</tr>
			</tfoot>
		</table>
	</jsp:body>
	
</t:popup>

