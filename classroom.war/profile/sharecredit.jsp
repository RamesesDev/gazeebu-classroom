<script>
	$put(
		"sharecredit", 
		new function() 
		{
			var creditsvc = ProxyService.lookup("CreditService");
			var self = this;
			this._controller;
			this.credits;
			this.handler;
			this.creditto = {};

			this.onload = function() {
				this.creditto.from = this.credits.objid;
				this.creditto.amount = 0;
			}

			this.share = function() {
				if(this.creditto.amount > this.credits.availablecredits) {
				   alert("Insufficient Credits.");
				} else {
				   creditsvc.shareCredits({from:this.creditto.from, to:this.creditto.to, amount:this.creditto.amount});
				}

				if(this.handler)
				   this.handler();

				return "_close";
			}
			
			this.lookup = function() {
				return new PopupOpener('student_search', {handler:function( stud ){
					if( stud ) {
						self.creditto.to = stud.objid;
						self.creditto.toname = stud.firstname + ' ' + (stud.middlename? stud.middlename + ' ' : '') + stud.lastname;
						self._controller.refresh();
					}
				}}, {width:450,height:400});
			}

		}	
	);
</script>

<table class="page-form-table" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td class="right caption text-top padding-top">Available Credits: &nbsp&nbsp</td>
		<td class="text-top padding-top">
			<label r:context="sharecredit">#{credits.availablecredits}</label>
		</td>
	</tr>
	<tr>
		<td class="right caption text-top padding-top"> To: &nbsp&nbsp</td>
		<td class="text-top padding-top">
			<input type="text" class="text" r:context="sharecredit" r:name="creditto.toname" readonly="readonly"/>
			<button r:context="sharecredit" r:name="lookup">Search</button>
		</td>
	</tr>
	<tr>
		<td class="right caption text-top padding-top">Amount: &nbsp&nbsp</td>
		<td class="text-top padding-top">
			<input type="text" class="text" r:context="sharecredit" r:name="creditto.amount" r:datatype="decimal"/>
		</td>
	</tr>
	<tr>
		<td class="text-top padding-top"></td>
		<td class="text-top padding-top">
			<input type="button" r:context="sharecredit" r:name="share" value="Share"/>
		</td>
	</tr>
</table>
