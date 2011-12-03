<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<%@ attribute name="before_rendering" fragment="true" %>
<%@ attribute name="header_middle" fragment="true" %>
<%@ attribute name="script" fragment="true" %>
<%@ attribute name="style" fragment="true" %>
<%@ attribute name="head" fragment="true" %>

<t:secured>

	<jsp:attribute name="before_rendering">
		<jsp:invoke fragment="before_rendering"/>
	</jsp:attribute>

	<jsp:attribute name="head">
		<jsp:invoke fragment="head"/>
	</jsp:attribute>	
	
	<jsp:attribute name="header_middle">
		<jsp:invoke fragment="header_middle"/>
	</jsp:attribute>	
	
	<jsp:attribute name="script">
		<jsp:invoke fragment="script"/>
	</jsp:attribute>	
	
	<jsp:attribute name="style">
		<jsp:invoke fragment="style"/>
	</jsp:attribute>	
	
	<jsp:body>
		<table width="100%" height="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td valign="top" width="1px" height="100%">
					<table id="leftpanel" width="165px" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top">
								<jsp:doBody/>
							</td>
						</tr>
					</table>
				</td>
				<td valign="top" height="100%">
					<table class="shadowbox" width="100%" height="550">
						<tr>
							<td align="right">
								<a id="toggle" href="#" style="text-decoration:none" title="Expand content panel">
									[+]
								</a>
								<script type="text/javascript">
									$(function(){
										$('#toggle').click(function(){
											var e = $(this);
											var lp = $('#leftpanel');
											if( e.data('expanded') ) {
												lp.css('display',lp.data('display'));
												e.data('expanded', false).html('[+]').attr('title','Expand content panel');
											}
											else {
												lp.data('display', lp.css('display')).css('display','none');
												e.data('expanded', true).html('[-]').attr('title','Compress content panel');
											}
											return false;
										});
									});
								</script>
							</td>
						</tr>
						<tr>
							<td id="content" height="100%" valign="top">&nbsp;</td> 
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</jsp:body>

</t:secured>

