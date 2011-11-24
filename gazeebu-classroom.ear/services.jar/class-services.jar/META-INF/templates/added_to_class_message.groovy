<html>
	<body>
		Hi ${user.firstname},<br><br>
	
		Thank you for registering with Gazeebu Classroom.<br><br>
		
		To start, click on the link below (or copy the url in your browser) to activate your account<br><br>  
		<a href="http://localhost:8080/classroom/student_activate.jsp?id=${java.net.URLEncoder.encode(user.objid)}">
			http://localhost:8080/classroom/student_activate.jsp?id=${java.net.URLEncoder.encode(user.objid)}
		</a>
		<br>
		<br>
			
		We hope you like our service and if you do, we would appreciate it you send us 
		feedback, or inform your other teachers of this service.<br><br>	
		
		Thanks and best regards,<br><br>
		Gazeebu Classroom Team
	</body>
</html>