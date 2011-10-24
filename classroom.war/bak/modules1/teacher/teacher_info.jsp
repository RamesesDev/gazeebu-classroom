<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	$put("teacher_info",
		new function() {
			var teacherSvc = ProxyService.lookup("TeacherService");
			var msgSvc = ProxyService.lookup("MessagingService");
		
			this.objid;
			this.teacher;
			
			this.message;
			
			this.onload = function() {
				$ctx("session").notifier.handler =  function(o) {
					if(o.msgtype == 'chat' ) {
						$('#message').append("<div>"+ o.message +"</div>"); 
					}
				};
				this.teacher = teacherSvc.getInfo( {objid: this.objid} );
			}
			
			this.sendMessage = function() {
				if(this.message) {
					msgSvc.send( {senderid: $ctx('user_profile').userid, recipients: [{objid:this.objid}], message:this.message} ); 
					this.message = null;
				}
			}
		}
	);
</script>
<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top" style="border-bottom:1px solid lightgrey;">
			<table>
				<tr>
					<td valign="top">
						<img src="img/profilephoto.png"/>
					</td>
					<td valign="top" style="font-size:18px;font-weight:bolder;padding-left:10px;">
						<label context="teacher_info">#{teacher.lastname}, #{teacher.firstname}</label>
						<div style="font-size:12px;">Teacher</div>	
					</td>
				</tr>
			</table>	
		</td>
		<td rowspan="2" width="250" valign="top" style="font-size:10px;padding-left:20px;">
			<b>Assignments</b><br>
			Has passed all assignments<br>
			Not yet submitted the last one
		</td>
	</tr>
	<tr>
		<td>
			<table width="100%">
				<tr>
					<td><b>Messages</b></td>
				</tr>
				<tr>
					<td><textarea context="teacher_info" name="message"  style="width:100%;height:50;"></textarea></td>
				</tr>
				<tr>
					<td align="right">
						<input type="button" context="teacher_info" name="sendMessage" value="Submit"/> 
					</td>
				</tr>
				<tr>
					<td>Today</td>
				</tr>
				<tr>
					<td valign="top">
						<div id="message"></div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>