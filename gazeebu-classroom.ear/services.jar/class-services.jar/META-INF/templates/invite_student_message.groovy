<html>
	<body>
		<table>
			<tr>
				<td>
					Hi ${recipientfname},<br><br>
				
					${senderlname}, ${senderfname} is inviting you to join the class <b>${classname}</b> ${schedules? '<i>'+ schedules +'</i>' : ''}.<br><br>
					
					${msg? '<div style="border:solid 1px #ccc;padding:20px;">' + msg + '</div>' : ''}
						
					<br><br>	
					
					Thanks,<br><br>
					The Gazeebu Team
					
					<br>
					<br>
					<br>
					<a href="www.gazeebu.com">Click here</a> to enter Gazeebu.<br/>
					<i>This message is generated by Gazeebu. Please do not reply</i>
				</td>
			</tr>	
		</table>
	</body>
</html>