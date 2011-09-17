var mff = {
	behaviours: {},

	apply_behaviours: function( context ){
		for( var i in this.behaviours ){
			if ( this.behaviours.hasOwnProperty( i ) ){
				this.behaviours[i]( context );
			}
		}
	}
};

$( document ).ready( function(){ mff.apply_behaviours( document ); } );

// This can be removed once the JS is minified and all console calls are deleted
if( !window.console ){ 
	window.console = { log:function(){}, dir:function(){} };
}
