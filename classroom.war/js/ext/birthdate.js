function DateModel(m, d, y, minYear) {

	this.month = m;
	this.year = y;
	this.day = d;

	this.months = [
	  {id:"1", name:"Jan"},
	  {id:"2", name:"Feb"},
	  {id:"3", name:"Mar"},
	  {id:"4", name:"Apr"},
	  {id:"5", name:"May"},
	  {id:"6", name:"Jun"},
	  {id:"7", name:"Jul"},
	  {id:"8", name:"Aug"},
	  {id:"9", name:"Sep"},
	  {id:"10", name:"Oct"},
	  {id:"11", name:"Nov"},
	  {id:"12", name:"Dec"}
	];
	
	this.years = [];
	
	minYear = minYear || 1900;
	var curDate = new Date();
	for( var i=minYear; i<= curDate.getFullYear(); ++i ) {
		this.years.push( i+'' );
	}
	
	this.days = [
	  "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", 
	  "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", 
	  "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", 
	  "31",  
	];
	
	this.getDate = function() {
		return this.year + '-' + this.month + '-' + this.day;
	}
} 

BindingUtils.handlers.birthdate = function( elem, controller, idx ) {
   var e = $(elem);
   var modelName = R.attr(e, "model");
   var model = controller.get(modelName);
   var monthSelection;
   var daySelection;
   var yearSelection;
   if(e.children().length == 0) {
      var div = $('<div></div>');
      
      /*
         MONTH STARTS here
      */
      monthSelection = $('<select class="m"></select>');
      var ms = $(monthSelection);
      for( var i=0; i<model.months.length ; i++ ) {
         $('<option value="' + model.months[i].id + '">'  + model.months[i].name + '</option>').appendTo(monthSelection);
      }
      ms.appendTo(div);
      //$get(controller.name).get(modelName).month = ms.val();//FORCE SET
      ms.change(function() {
         $get(controller.name).get(modelName).month = this.value ;
		 updateFieldValue();
      });
      /*
         MONTH ENDS here
      */
      
      //////////////////////////////////////////////////
      
      /*
         DAY STARTS here
      */
      daySelection = $('<select class="d"></select>');
      var ds = $(daySelection);
      for( var i=0 ; i<model.days.length ; i++) {
         $('<option value="' + model.days[i] + '">' + model.days[i] + '</option>').appendTo(daySelection);
      }
      ds.appendTo(div);
      //$get(controller.name).get(modelName).day = ds.val();
      ds.change(function() {
         $get(controller.name).get(modelName).day = this.value;
		 updateFieldValue();
      });
      /*
         DAY ENDS here
      */
      
      //////////////////////////////////////////////////
      
      /*
         YEAR STARTS here
      */
      yearSelection = $('<select class="y"></select>');
      var ys = $(yearSelection);
      for( var i=0 ; i<model.years.length ; i++) {
         $('<option value="' + model.years[i] +'">' + model.years[i] + '</option>').appendTo(yearSelection);
      }
      ys.appendTo(div);
      //$get(controller.name).get(modelName).year = ys.val();
      ys.change(function() {
         $get(controller.name).get(modelName).year = this.value;
		 updateFieldValue();
      });
      /*
         YEAR ENDS here
      */
      
      div.appendTo(e);
   } else {
      monthSelection = e.find('select.m');
      daySelection = e.find('select.d');
      yearSelection = e.find('select.y');
   }
   
   $('option[value="' + model.month + '"]', monthSelection).attr('selected', 'selected');
   $('option[value="' + model.day + '"]', daySelection).attr('selected', 'selected');
   $('option[value="' + model.year + '"]', yearSelection).attr('selected', 'selected');

   
   function updateFieldValue() {
		var n = R.attr(elem, 'name');
		if( n ) controller.set(n, model.getDate());
   }
}
