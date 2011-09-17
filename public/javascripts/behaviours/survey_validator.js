if( typeof( mff ) == 'undefined' )var mff;

mff.behaviours.survey_validator = function(){ mff.survey_validator.init(); };


mff.survey_validator = {

	init: function(){
		// Add title attr for tooltips to every field with validation
		for( var i in this.data ){
			if ( this.data.hasOwnProperty( i ) ){
				//$( '[name="'+$.escape(i)+'"]' )
				$( '[name="'+$.escape(i)+'"]' )
					.parents('fieldset')
					.attr( 'title', this.data[i].message )
				;
			}
		}

		$( 'fieldset.validate input' ).blur( function( event ){
			mff.survey_validator.validate_field( event.currentTarget );
		} );
	},

	validate_field: function( field ){ // this is supposed to be called by mff.question_slides.change_question as well
		for( var i in this.data ){
			if ( this.data.hasOwnProperty( i ) ){
				var input_element = $( '[name='+$.escape(i)+']', field );
				if( !input_element.length ) continue;
	
				if( this.data[i].required ){
					if( !this.validators.required( field, input_element, this.data[i] ) ) return false;
				}
			}
		}
		return true;
	},

	validators : {
		required : function( field, input_element, data ){
			try{
				if( input_element.fieldValue().length ){
					field.removeClass( 'field_with_errors' );
					return true;
				} else throw 'Empty';
			}catch( e ){
				field
					.addClass( 'field_with_errors' )
					.tooltip( {
						position      : 'bottom center',
						offset        : [ -64, 0 ],
						effect        : 'slide',
						slideInSpeed  : 400,
						slideOutSpeed : 400,
						tipClass      : 'tooltip error',
						events : {
							def : 'error, change'
						}
					} )
				;
				field.error(); // Fire the error event to display the tooltip
				return false;
			}
		}
	},

	data : {
		'survey[adjusted_gross_income]' : {
			message  : 'You must select a value before continuing.',
			required : true
		},
		'survey[loan_option_id]' : {
			message  : 'You must select a value before continuing.',
			required : true
		}
	}

};
