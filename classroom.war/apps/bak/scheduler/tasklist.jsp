<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<t:content title="Tasks">

	<jsp:attribute name="style">
	
	</jsp:attribute>

	
	
	<jsp:attribute name="script">
		$put("tasklist",
			new function(){
				var session ;
				var svc = ProxyService.lookup("TaskSchedulerService");
				
				this.task;
				var self = this;
				this.tasklist = [];
				
				this.listModel = {
					fetchList: function(o) {
						if(o==null) o = {}
						self.tasklist = svc.getActiveTasks(o);
						return self.tasklist;
					}
				}
				
				this.onload = function() {
					session = new Notifier( svc.getSessionId(), window.location.href );
					session.handler = function(o) {
						var z = self.tasklist.find(
							function(x) {return o.id==x.id}
						) 
						if(z) {
							z.status = o.status;
							if(!z.status || z.status == 'proceed' || z.status == 'resumed') z.status = 'active';
							if( o.currentdate ) z.currentdate = o.currentdate;
							self.listModel.refresh(false);
						}
					}
					session.connect();
				}
				
				this.suspend = function() {
					if(this.task) svc.suspend({id: this.task.id});
				}
				this.resume = function() {
					if(this.task) svc.resume({id:this.task.id});
				}
				this.resumeError = function() {
					if(this.task) svc.resumeError({id:this.task.id});
				}
				this.addTask = function() {
					var saveHandler = function(o) {
						svc.create( o );
						self.listModel.refresh(true);
					}
					return new PopupOpener("scheduler:newtask", {saveHandler: saveHandler });
				}
				var counter = 0;
				var svc1 = ProxyService.lookup("SchedulerTestService");
				this.test = function() {
					var s = svc1.fireAsync();
					Session.handlers.async = function(o) {
						window.console.log($.toJSON(o));
						if(o.requestId == s.id ) {
							if(o.started) {
								counter = 0;
								window.console.log("starting now");
							}	
							else if(o.finished) {
								alert("total records " + counter);
							}	
							else {
								counter++; 
							}	
						}	
					}
				}
			}
		);
	</jsp:attribute>

	<jsp:attribute name="actions">
		<input type="button" r:context="tasklist" r:name="addTask" value="Add Task" /> 
		<input type="button" r:context="tasklist" r:name="test" value="Test" />
	</jsp:attribute>
	
	<jsp:body>
		<table r:context="tasklist" r:model="listModel" r:varName="item" r:varStatus="stat" r:name="task" cellpadding=0" cellspacing="0" border="1">
			<thead>
				<tr>
					<td>Id</td>
					<td>Status</td>
					<td>Service</td>
					<td>Method</td>
					<td>Current Date</td>
					<td>&nbsp;</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>#{item.id}</td>
					<td>#{item.status}</td>
					<td>#{item.service}</td>
					<td>#{item.method}</td>
					<td>#{item.currentdate}</td>
					<td>
						<a r:context="tasklist" r:name="suspend" r:visibleWhen="#{item.status == 'active'}">Suspend</a>&nbsp;&nbsp;
						<a r:context="tasklist" r:name="resume" r:visibleWhen="#{item.status == 'suspended'}">Resume</a>&nbsp;&nbsp;
						<a r:context="tasklist" r:name="recover" r:visibleWhen="#{item.status == 'error'}">Recover</a>&nbsp;&nbsp;
					</td>
				</tr>
			</tbody>
		</table>
	</jsp:body>
	
</t:content>


