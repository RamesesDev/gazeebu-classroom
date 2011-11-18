<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:index redirect_session="true">
	<style>
		form.signup input,
		form.singup button {
			font-size: 15px;
			padding: 8px 3px;
			margin: 2px 0px;
			border: solid 1px #999;
		}
		
		.btn { 
			margin-top: 5px;
			display: inline-block; 
			background: rgb(54,160,205) url('img/header-bg.png') repeat-x left center;
			border:1px solid #777; 
		}
		.btn button {
			background: none;
			color: #fff;
			border: none;
			border-top: solid 1px #bbb;
			border-left: solid 1px #bbb;
			display: inline-block;
			padding: 8px 40px; margin: 0;
		}
	</style>
	<script>
		$(function(){
			$('form.signup input').each(function(i,e){ new InputHintDecorator(e); });
		});
	</script>
	<table width="100%">
		<tr>
			<td valign="top">
				<div id="description" style="font-family:georgia;font-size:1.8em;color:black">
					Gazeebu classroom connects teachers  and students
				</div>
				<div>
					<ul>
						<li id="features">Manage assignments, exams, grades, attendance and more
						<li id="features">Post announcements and events
						<li id="features">No setups. No hassles. Its free.
					</ul>
				</div>
			</td>
			<td valign="top" align="left" id="regcontainer">
				<h3>New User?</h3>
				<form class="signup" method="post" action="signup.jsp">
                    <input type="text" class="text" size="40" name="firstname"
                           r:hint="First name"/>
					<br/>
                    <input type="text" class="text" size="40" name="middlename"
                           r:hint="Middle name"/>
					<br/>
                    <input type="text" class="text" size="40" name="lastname"
                           r:hint="Last name"/>
					<br/>
					<span class="btn">
						<button>Sign up</button>
					</span>
				</form>
			</td>
		</tr>
		<tr>
		   <td style="text-align:right;vertical-align:middle" colspan="2">
		      Check us out at: 
		      <div style="float:right;padding-right:5px;padding-left:5px;">
		      <a href="http://www.facebook.com/Gazeebu">
		         <img src="img/facebook.png"/>
		      </a>
		      </div>
		      <div style="float:right;padding-right:5px;padding-left:5px;">
		      <a href="http://www.twitter.com/Gazeebu">
		         <img src="img/twitter.png"/>
		      </a>
		      </div>
		   </td>
		</tr>
	</table>
</t:index>
