if( typeof( mff ) == 'undefined' )var mff;

mff.behaviours.help = function( context ){ mff.help.init( context ); };

mff.help = {

	init : function( context ){
		$( '#new_survey_form a.help' ).attr( 'title', this.data[1] );
		$( '[title]' ).not( 'fieldset[title]' ).tooltip( this.tooltip_config );
	},

	apply_help : function( element, index ){
		if( this.data[index] ){
			element.attr( 'title', this.data[index] );
			element.removeClass( 'disabled' );
			element.tooltip( this.tooltip_config );
		}else{
			element.addClass( 'disabled' );
		}
	},

	data : {
		1 : "Gross income is commonly defined as the amount of a company's or a person's income before all deductions" +
			 "or any taxpayer’s income, except that which is specifically excluded by the Internal Revenue Code, " +
			 "before taking deductions or taxes into account."
	},

	tooltip_config : {
		position      : 'bottom center',
		offset        : [ 40, 0 ],
		effect        : 'slide',
		direction     : 'down',
		slideInSpeed  : 400,
		slideOutSpeed : 400
	}

};
