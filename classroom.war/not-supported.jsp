<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<t:public redirect_session="false" check_useragent="false">
	<jsp:attribute name="head">
		<style>
		.browsers { margin:0; padding:0; }
		.browsers li { list-style:none; float:left; width: 100px; margin: 5px 10px; }
		.browsers div { text-align: center; }
		</style>
	</jsp:attribute>
	
	<jsp:body>
		<h1>Your browser is no longer supported.</h1>
		<p>
			Gazeebu no longer supports your browser. Please upgrade your browser
		</p>
		<ul class="browsers">
			<li>
				<a href="http://www.google.com/chrome/?hl=en">
					<div>
						<img src="${pageContext.request.contextPath}/img/browsers/chrome-80.png"/>
					</div>
					<div>Download Chrome</div>
				</a>
			</li>
			<li>
				<a href="http://www.microsoft.com/windows/internet-explorer/default.aspx">
					<div>
						<img src="${pageContext.request.contextPath}/img/browsers/ie-80.png" />
					</div>
					<div>Download Internet Explorer</div>
				</a>
			</li>
			<li>
				<a href="http://www.mozilla.com/firefox/">
					<div>
						<img src="${pageContext.request.contextPath}/img/browsers/firefox-80.png" />
					</div>
					<div>Download Firefox</div>
				</a>
			</li>
			<li>
				<a href="http://www.apple.com/safari/download/">
					<div>
						<img src="${pageContext.request.contextPath}/img/browsers/safari-80.png" />
					</div>
					<div>Download Safari</div>
				</a>
			</li>
		</ul>
	</jsp:body>
</t:public>
