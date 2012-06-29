<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>


<t:popup>

	<jsp:attribute name="head">	
		<link href="${pageContext.request.contextPath}/js/ext/richtext/richtext.css" rel="stylesheet"></link>
		<script src="${pageContext.request.contextPath}/js/ext/richtext/richtext.js"></script>
	
		<script type="text/javascript">
			$put(
				"post_message", 
				new function() 
				{
					this.message;
					this.handler;
					
					this.post = function() {
						if( this.handler ) this.handler( this.message );
						return '_close';
					}
				}
			);
		</script>
		
		<style>			
			.txt-post-message textarea {
				display: block;
				width: 360px; height: 140px;
			}
		</style>
 	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<button r:context="post_message" r:name="post">Post</button>
		<button r:context="post_message" r:name="_close">Cancel</button>
	</jsp:attribute>

	<jsp:body>
		<div class="txt-post-message">
			<textarea r:context="post_message" r:name="message" r:hint="${not empty param.hint ? param.hint : 'Post message'}"></textarea>
		</div>
	</jsp:body>
	
</t:popup>


	