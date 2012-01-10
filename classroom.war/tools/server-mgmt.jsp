<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/ui-components" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="common" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ page import="com.rameses.web.support.*" %>

<html>
	<head>
		<script src="${pageContext.servletContext.contextPath}/js/lib/jquery-all.js"></script>
		<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-ext-lib.js"></script>
		<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-ui.js"></script>
		<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-proxy.js"></script>
		<script>
			$put(
				'server-mgmt',
				{
					modname: '',
					reload: function() {
						ProxyService.lookup("ScriptMgmtService").redeploy(this.modname);
					},
					reloadAll: function() {
						ProxyService.lookup("ScriptMgmtService").redeployAll();
					}
				}
			);
		</script>
	</head>
	<body>
		<h1>Reload Script</h1>
		<input type="text" r:name="modname" r:context="server-mgmt" />
		<button r:context="server-mgmt" r:name="reload">Reload</button>
		<button r:context="server-mgmt" r:name="reloadAll">Reload All</button>
	</body>
</html>