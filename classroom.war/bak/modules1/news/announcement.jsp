<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>	
    $put("announcement", 
        new function() {
			this.scope = "class";
			this.entity = {};
			this.send = function() {
				var svc = ProxyService.lookup("ClassService");
				this.entity.msgtype = "announcement";
				if( this.scope == "class" ) {
					this.entity.classid = "${param['classid']}";
				}
				svc.publishNews( this.entity );
				return "_close";
			}
        }
    );    
</script>
<t:popup>
	<jsp:attribute name="leftactions">
		<input type="button" context="announcement" name="send" value="Publish">
	</jsp:attribute>
	
	<jsp:body>
		<div>Message</div>
		<div>
			<textarea context="announcement" name="entity.message" style="width:100%;height:200px;"></textarea>
		</div>
		<div>
			Announce to <br>
			<input type="radio" name="scope" value="class" context="announcement"/>This class only<br>
			<input type="radio" name="scope" value="all" context="announcement"/>All classes<br>			
		</div>
	</jsp:body>
	
</t:popup>

