<html>
	<body>
		Hi ${user.firstname},<br><br>
	
		Thank you for registering with Gazeebu Classroom.<br><br>
		
		To start, click on the link below (or copy the url in your browser) to activate your account<br><br>  
		<a href="http://localhost:8080/classroom/teacher_activate.jsp?objid=${java.net.URLEncoder.encode(user.objid)}">
			http://localhost:8080/classroom/teacher_activate.jsp?objid=${java.net.URLEncoder.encode(user.objid)}
		</a>
		<br>
		<br>
			
		As a teacher, Gazeebu provides you with tools to help you
		organize your work to manage your students. We hope you like 
		our service and if you do, we would appreciate it you send us 
		feedback, or tell your fellow teachers regarding our service.<br><br>	
		
		Thanks and best regards,<br><br>
		Gazeebu Classroom Team
	</body>
</html>