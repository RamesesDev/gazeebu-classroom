<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>


<t:popup>

	<jsp:attribute name="script">
		$put("new_exam",
			new function() {
				var svc = ProxyService.lookup("ExamService");
				this.saveHandler;
				this.gradingTypes = [{id:"100", name:"percentage"}, {id:"A", name:"A,B,C"} ];
				this.exam = {classid: "${param['classid']}"};
				
				this.save = function() {
					var o = svc.create( this.exam );
					if(this.saveHandler) this.saveHandler(o);	
					return "_close";
				}	

			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="new_exam" r:name="save" value="Save" /> 
	</jsp:attribute>
	
	<jsp:body>
		<div>Exam Title</div>
		<div><input type="text" r:context="new_exam" r:name="exam.title" r:caption="Title" style="width:300px;"/></div>
		<br>
		<div>Date of Exam</div>
		<div><input type="text" r:context="new_exam" r:name="exam.examdate" r:datatype="date"  r:caption="Date of Exam"/></div>
		<br>
		<div>Grading Type<select r:context="new_exam" r:name="exam.gradingtype" r:items="gradingTypes" r:itemKey="id" r:itemLabel="name"  r:caption="Grading Type"/></div>
		<div>Max. Score<input type="text" r:context="new_exam" r:name="exam.maxscore" r:caption="Max Score" /></div>
		<div>Passing Score<input type="text" r:context="new_exam" r:name="exam.passingscore" r:caption="Max Score" /></div>
		<br><br>
		<div>Online Exam<input type="checkbox" r:context="new_exam" r:name="exam.online" r:caption="Online" r:checkedValue="1" r:uncheckedValue="0"/></div>
		<div r:context="new_exam" r:visibleWhen="#{exam.online == '1'}" r:depends="exam.online">
			Choose an exam template
		</div>
		
	</jsp:body>
	
</t:popup>


