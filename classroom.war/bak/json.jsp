<%if(  request.getParameter("id").equals("1")) { %>
{
	firstname: "Rex",
	lastname: "Escario",
	items : [
		{phone: "23199811"}
	]
}
<% } %>


<%if( ! request.getParameter("id").equals("1")) { %>
{
	firstname: "Romel",
	lastname: "Lauron",
	items : [
		{phone: "23199822"},
		{phone: "23199823"}
	]
}
<% } %>
