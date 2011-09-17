if( typeof( mff ) == 'undefined' )var mff;

mff.behaviours.question_slides = function( context ){ mff.question_slides.init( context ); };
//$.fn.ajaxSubmit.debug = true;

mff.question_slides = {

	// Counters
	current_fieldset : 0,
	total_fieldsets  : 0,

	// jQuery element cache
	form             : null,
	pagination       : null,
	question_element : null,
	fieldsets        : null,

	init : function( context ){
		//return false;

		// Grab any forms with the .question_slides class, and return early if not found
		this.form = $( 'form.question_slides', context ).addClass( 'active' );
		if( $.browser.msie && $.browser.version < 7 ) this.form.removeClass( 'active' );
		if( !this.form.length ) return false;

		// Ajaxify the form submit event
		this.form.submit( this.on_submit );

		// Remove the .actions fieldset because we submit with ajax instead
		this.form.find( 'fieldset.actions' ).remove();

		// Cache jQuery selectors
		this.pagination = this.form.append( jQuery.tmpl( 'question_slides.pagination' ) ).find( '.pagination' ); // Add prev / next links
		this.fieldsets  = this.form.children( 'fieldset' );

		// Set page counters
		this.total_fieldsets  = this.fieldsets.length;
		this.current_fieldset = 0;

		// Add question numbers
		this.update_question_number(
			this.fieldsets.hide().first().show() // Hide all but the first fieldset
		);

		// Apply on-click behaviour to prev / next links
		this.pagination.find( 'a' ).bind( 'click', this.change_question );

		// Apply AJAX history behaviour
		this.pagination.history( this.on_ajax_history );
	},

	change_question : function( event ){
		event.stopPropagation();

		var
			form      = mff.question_slides.form,
			direction = $( event.currentTarget ).hasClass( 'ok' ) || $( event.currentTarget ).hasClass( 'next' ),
			fieldset  = $( form.find( 'fieldset:visible' ) ).first()
		;

		// Return if you can't go back any further
		if ( !direction && !fieldset.prev('fieldset').length ) return false;

		if( direction ){
			// Integrate with the survey validator
			if( mff.survey_validator && !mff.survey_validator.validate_field( fieldset ) ) return false;

			// Submit form so far if there are no further fieldsets to display
			if ( !fieldset.next('fieldset').length ){
				form.submit();
				return false;
			}

			mff.question_slides.current_fieldset++;
			fieldset.next().show().find('input[type="text"]').focus().select();
		} else {
			mff.question_slides.current_fieldset--;
			fieldset.prev().show().find('input[type="text"]').focus().select();
		}

		fieldset.hide();
		mff.question_slides.update_question_number( fieldset );
		
		// Force a re-render for IE6
		if( $.browser.msie && $.browser.version < 7 ) mff.question_slides.form.hide().show();
		
		return false;
	},

	update_question_number : function( fieldset ){
		if( !this.form.find( '.question_number' ) ) return false;

		var html = $.tmpl(
			'question_slides.question_number', {
				number : this.current_fieldset + 1,
				total  : this.total_fieldsets
			}
		);

		this.question_element = $( mff.question_slides.form ).find( '.question_number' ).replaceWith( html );

		// Integrate with mff.help
		if( mff.help ) mff.help.apply_help( this.question_element.find( '.help' ), this.current_fieldset + 1 );
	},

	// ===== EVENT HANDLERS ===== //

	on_submit : function( event ){
		var form = mff.question_slides.form;
		$.ajax( {
			url     : form.attr('action'),
			type    : 'POST',
			data    : form.formSerialize(),
			success : mff.question_slides.on_submit_success,
			error   : mff.question_slides.on_submit_error
		} );
		return false;
	},

	on_submit_success : function( data, status, xhr ){
		var fragment = $( data ).find('form');
		mff.question_slides.form.replaceWith( fragment );
		mff.apply_behaviours( fragment );
	},

	on_submit_error : function( response, success, event, element ){
		// Try to submit normally
		mff.question_slides.form.unbind( 'submit', false ).submit();

		// Otherwise display the error
		mff.question_slides.form.replaceWith( $( response.responseText ) );
	}

};


jQuery.template(
	'question_slides.question_number',

	'<h2 class="question_number">' +
		'Question ${number}<small>/</small>${total} ' +
		'<!-- <a class="icon help" href="#help">?</a> -->' +
	'</h2>'
);


jQuery.template(
	'question_slides.pagination',

	'<div class="pagination">' +
		'<a class="large_button cancel" href="#">&laquo; Previous Step</a>' +
		'<a class="large_button ok" href="#">Next Step &raquo;</a>' +
	'</div>' +
    '<br /><a href="/college_choices/">skip to net price comparison chart</a>' 
);
