if( typeof( mff ) == 'undefined' )var mff;

mff.behaviours.modalbox = function( context ){
	$( "a.fancybox", context ).fancybox( {
		autoDimensions: false,
		width: 600,
		height: 'auto',
		overlayColor: '#333',
		showNavArrows: false,
		type: 'ajax'
	} );
};
