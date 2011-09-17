if( typeof( mff ) == 'undefined' )var mff;

mff.behaviours.form_effects = function( context ){ mff.form_effects.init( context ); };

mff.form_effects = {
	init : function( context ){
		// Add selected classes to selected items' labels
		$( 'form input[type="radio"]', context ).change( function( event ){
			$( event.currentTarget ).parent( 'label' ).addClass( 'selected' ).siblings().removeClass( 'selected' );
		} );

		$( 'form input[type="checkbox"]', context ).live( 'change', function( event ){
			if( $( event.currentTarget ).is( ':checked' ) ){
				$( event.currentTarget ).parent( 'label' ).addClass( 'selected' );
			} else {
				$( event.currentTarget ).parent( 'label' ).removeClass( 'selected' );
			}
		} );
	}
};
