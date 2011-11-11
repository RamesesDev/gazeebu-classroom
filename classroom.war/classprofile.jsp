<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:secured-master>

	<jsp:attribute name="head">
		<link href="classprofile/main.css" type="text/css" rel="stylesheet" />
		<script>
		    $register({id:"classinfo", page:"classprofile/classinfo.jsp", context:"classinfo"});
		    $register({id:"calendar", page:"classprofile/calendar.jsp", context:"calendar"});
			$register({id:"grading_criteria", page:"classprofile/grading_criteria.jsp", context:"grading_criteria"});
			$register({id:"class_term", page:"classprofile/class_term.jsp", context:"class_term"});
			
			$put( "classprofile", 
				new function() {
					this.classid = "${param['classid']}";
					this.onload = function() {
						if( !window.location.hash ) {
							window.location.hash = "classinfo";
						}
					}
					
				}
			);	
			
		</script>
	</jsp:attribute>

   <jsp:body>
		<a href="home.jsp?classid=${param['classid']}#news">Home</a>
	   <div>
		  <a href="#classinfo">General</a><br>
		  <a href="#grading_criteria">Grading Criteria</a><br>
		  <a href="#class_term">Class Term</a><br>
		  <a href="#calendar">Calendar</a><br>
	   </div>
	   
   </jsp:body>

</t:secured-master>
