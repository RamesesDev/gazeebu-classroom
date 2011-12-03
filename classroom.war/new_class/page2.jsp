<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<p>
Write a welcome message for your students.
</p>
<div r:type="richtext" r:context="new_class" r:name="classinfo.info.welcome_message" ></div>
<p>Upload Course Syllabus</p>
<input type="file"
	  r:context="new_class" 
	  r:caption="Upload Syllabus"
	  r:oncomplete="afterAttach"
	  r:expression="#{filename}"
	  r:onremove="removeSyllabus"
	  r:url="classroom/classinfo/syllabus_upload.jsp"/>