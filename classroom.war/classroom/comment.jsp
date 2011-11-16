<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:popup>

    <jsp:attribute name="style">
        .message {
            font-size:11px;font-family:arial;padding:6px;
        }
        .news_action {
            font-size:11px;
        }
    </jsp:attribute>

	<jsp:attribute name="script">
		$put(
			"comment",
			new function() {
				this.saveHandler;
				this.message;
				this.thread;
				this._caller;
				
				this.send = function() {
					this.saveHandler(this.message);
					return "_close";
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="comment" r:name="send" value="Submit" />
	</jsp:attribute>
	
    <jsp:body>
		<label r:context="comment"><b>In response to: </b>#{_caller.selectedMessage.firstname} #{_caller.selectedMessage.lastname}</label>
		<br>
		<label r:context="comment"><b>Thread: </b>#{_caller.selectedMessage.message}</label>
		<br>	
		<textarea r:context="comment" r:name="message" r:required="true" r:caption="Message" style="width:100%;height:50%;"></textarea> 
    </jsp:body>
</t:popup>
