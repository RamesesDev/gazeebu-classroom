<html>
	<body>
		Request for invitation<br><br>
		
		${user.note}
		
		<br><br>
		Click to approve:<br><br>  
		<a href="http://localhost:8080/gazeebu-classroom/service/TeacherRegistrationService.approve?objid=${java.net.URLEncoder.encode(user.objid)}">
			http://localhost:8080/gazeebu-classroom/service/TeacherRegistrationService.approve?objid=${java.net.URLEncoder.encode(user.objid)}
		</a>
		<br>
		<br>
	</body>
</html>