<html>
	<body>
		Hi ${recipientfname},<br><br>
	
		${senderlname}, ${senderfname} has accepted your
		${usertype == 'student'? 'invitation' : 'request'}
		to join 
		<b>
			<a href="www.gazeebu.com/classroom/classroom.jsp?classid=${classid}">${classname}</a>
		</b> 
		${schedules? '<i>'+ schedules +'</i>' : ''} class.
		<br><br>
			
		<br><br>	
		
		Thanks,<br><br>
		The Gazeebu Team
		
		<br>
		<br>
		<br>
		<a href="www.gazeebu.com">Click here</a> to enter Gazeebu.<br/>
		<i>This message is generated by Gazeebu. Please do not reply</i>
	</body>
</html>