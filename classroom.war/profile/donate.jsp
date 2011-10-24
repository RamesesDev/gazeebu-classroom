<script>
	$put(
		"donate", 
		new function() 
		{
			var creditsvc = ProxyService.lookup("CreditService");
			var self = this;
			this._controller;
			this.credits;
			this.handler;
			this.donation = {};

			this.types = [
				{code:"SS", name:"School Supplies"},
				{code:"TXT", name:"Text Messages"}
			];
			 
			this.onload = function() {
				this.donation.from = this.credits.objid;
				this.donation.amount = 0;
			}
			 
			this.donate = function() {
				if(this.donation.amount > this.credits.availablecredits) {
				   alert("Insufficient Credits.");
				} else {
				   creditsvc.donate({from:this.donation.from, to:this.donation.to, amount:this.donation.amount, type:this.donation.type});
				}

				if(this.handler)
				   this.handler();

				return "_close";
			}
			
			this.lookup = function() {
				return new PopupOpener('student_search', {handler:function( stud ){
					if( stud ) {
						self.donation.to = stud.objid;
						self.donation.toname = stud.firstname + ' ' + (stud.middlename? stud.middlename + ' ' : '') + stud.lastname;
						self._controller.refresh();
					}
				}}, {width:450,height:400});
			}
		}
	);
</script>

<table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td class="right caption text-top">Available Credits: &nbsp&nbsp</td>
		<td class="text-top">
			<label r:context="donate">#{credits.availablecredits}</label>
		</td>
	</tr>
	<tr>
		<td class="right caption text-top padding-top"> To: &nbsp&nbsp</td>
		<td class="text-top padding-top">
			<input type="text" class="text" r:context="donate" r:name="donation.toname" readonly="readonly"/>
			<button r:context="donate" r:name="lookup">Search</button>
		</td>
	</tr>
	<tr>
		<td class="right caption text-top padding-top"> Type: &nbsp&nbsp</td>
		<td class="text-top padding-top">
			<select r:context="donate" r:items="types" r:name="donation.type" r:itemKey="code" r:itemLabel="name"/>
		</td>
	</tr>
	<tr>
		<td class="right caption text-top padding-top">Amount: &nbsp&nbsp</td>
		<td class="text-top padding-top">
			<input type="text" class="text" r:context="donate" r:name="donation.amount" r:datatype="decimal"/>
		</td>
	</tr>
	<tr>
		<td class="text-top padding-top"></td>
		<td class="text-top padding-top">
			<input type="button" r:context="donate" r:name="donate" value="Donate"/>
		</td>
	</tr>
</table>
