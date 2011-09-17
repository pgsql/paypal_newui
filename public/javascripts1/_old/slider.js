var j = jQuery.noConflict();

j(document).ready(function(){
  var currentPosition = 0;
  var slideWidth = 560;
  var slides = j('.slide');
  var numberOfSlides = slides.length;

  // Remove scrollbar in JS
  j('#slidesContainer').css('overflow', 'hidden');

  // Wrap all .slides with #slideInner div
  slides
    .wrapAll('<div id="slideInner"></div>')
    // Float left to display horizontally, readjust .slides width
	.css({
      'float' : 'left',
      'width' : slideWidth
    });

  // Set #slideInner width equal to total width of all slides
  j('#slideInner').css('width', slideWidth * numberOfSlides);

  
  //readonly input step 2 if value in step 1 is 0
  j('#adjusted_income').change(function(){
    if (j('#adjusted_income').val() == 0) {
       j('#after_adjusted').val(0);
       j('#tax_credit').val(0);
       j('#after_adjusted').attr('readonly',true);
    }
    else {
      j('#after_adjusted').change(function() {
      j('#tax_credit').val(parseInt(j('#after_adjusted').val()) + parseInt(j('#adjusted_income').val()));
      });
    }
  });

  j('#submit_button').click(function(){
    error_message = 'Ups, You are missing something ! \n';
    is_error = false ;
    if(currentPosition == 10 ){
     
      if (j('#adjusted_income').val() == '') {
        error_message += ' Please fill the required field on step 1 \n ';
        is_error = true;
      };
      if (j('#after_adjusted').val().length == 0) {
        error_message += 'Please fill the required field on step 2 \n ';
        is_error = true;
      };
      if (j('#contribute').val().length == 0) {
        error_message += 'Please fill the required field on step 4 \n ';
        is_error = true;
      };
      if (j('#exchild').val().length == 0) {
        error_message += 'Please fill the required field on step 5 \n ';
        is_error = true;
      };
      if (j('#monthly').val().length == 0) {
        error_message += 'Please fill the required field on step 6 \n ';
        is_error = true;
      };
      if (j('#vacation').val().length == 0) {
        error_message += 'Please fill the required field on step 7 \n ';
        is_error = true;
      };
      if (j('#childcollege').val().length == 0) {
        error_message += 'Please fill the required field on step 8 \n ';
        is_error = true;
      };
      if (j('#savecollege').val().length == 0) {
        error_message += 'Please fill the required field on step 9 \n ';
        is_error = true;
      };
      if (j('#paycollege').val().length == 0) {
        error_message += 'Please fill the required field on step 10 \n ';
        is_error = true;
      };
      if (j('#option').val().length == 0) {
        error_message += 'Please choose the option on step 11 \n ';
        is_error = true;
      };
      if(is_error == true){
        alert(error_message);return false;
      };
      }
      else{
        return false;
      }
    });

  // Insert controls in the DOM
  j('#slideshow')
    .prepend('<span class="control" id="leftControl">Clicking moves left</span>')
    .append('<span class="control" id="rightControl">Clicking moves right</span>');

  // Hide left arrow control on first load
  manageControls(currentPosition);

  // Create event listeners for .controls clicks
  j('.control')
    .bind('click', function(){
    // Determine new position
	currentPosition = (j(this).attr('id')=='rightControl') ? currentPosition+1 : currentPosition-1;
   
	// Hide / show controls
    manageControls(currentPosition);
    // Move slideInner using margin-left
    j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
  });


  //event tab key step no 1
  j('#adjusted_income').keyup(function(event) {
  if (event.keyCode == '9') {
     currentPosition = (j(this).attr('id')=='adjusted_income') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event tab key step no 2
  j('#after_adjusted').keyup(function(event) {
  if (event.keyCode == '9') {
     currentPosition = (j(this).attr('id')=='after_adjusted') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event tab key step no 3
  j('#tax_credit').keyup(function(event) {
  if (event.keyCode == '9') {
     currentPosition = (j(this).attr('id')=='tax_credit') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event tab key step no 4
  j('#contribute').keyup(function(event) {
  if (event.keyCode == '9') {
     currentPosition = (j(this).attr('id')=='contribute') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event tab key step no 5
  j('#exchild').keyup(function(event) {
  if (event.keyCode == '9') {
     currentPosition = (j(this).attr('id')=='exchild') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event tab key step no 6
  j('#monthly').keyup(function(event) {
  if (event.keyCode == '9') {
     currentPosition = (j(this).attr('id')=='monthly') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event tab key step no 7
  j('#vacation').keyup(function(event) {
  if (event.keyCode == '9') {
     currentPosition = (j(this).attr('id')=='vacation') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event tab key step no 8
  j('#childcollege').keyup(function(event) {
  if (event.keyCode == '9') {
     currentPosition = (j(this).attr('id')=='childcollege') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event tab key step no 9
  j('#savecollege').keyup(function(event) {
  if (event.keyCode == '9') {
     currentPosition = (j(this).attr('id')=='savecollege') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event tab key step no 10
  j('#paycollege').keyup(function(event) {
  if (event.keyCode == '9') {
     currentPosition = (j(this).attr('id')=='paycollege') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });
  
  //event enter key step no 1
  j('#adjusted_income').keyup(function(event) {
  if (event.keyCode == '13') {
     
     currentPosition = (j(this).attr('id')=='adjusted_income') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event enter key step no 2
  j('#after_adjusted').keyup(function(event) {
  if (event.keyCode == '13') {
     currentPosition = (j(this).attr('id')=='after_adjusted') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event enter key step no 3
  j('#tax_credit').keyup(function(event) {
  if (event.keyCode == '13') {
     currentPosition = (j(this).attr('id')=='tax_credit') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event enter key step no 4
  j('#contribute').keyup(function(event) {
  if (event.keyCode == '13') {
     currentPosition = (j(this).attr('id')=='contribute') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event enter key step no 5
  j('#exchild').keyup(function(event) {
  if (event.keyCode == '13') {
     currentPosition = (j(this).attr('id')=='exchild') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event enter key step no 6
  j('#monthly').keyup(function(event) {
  if (event.keyCode == '13') {
     currentPosition = (j(this).attr('id')=='monthly') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event enter key step no 7
  j('#vacation').keyup(function(event) {
  if (event.keyCode == '13') {
     currentPosition = (j(this).attr('id')=='vacation') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event enter key step no 8
  j('#childcollege').keyup(function(event) {
  if (event.keyCode == '13') {
     currentPosition = (j(this).attr('id')=='childcollege') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event enter key step no 9
  j('#savecollege').keyup(function(event) {
  if (event.keyCode == '13') {
     currentPosition = (j(this).attr('id')=='savecollege') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  //event enter key step no 10
  j('#paycollege').keyup(function(event) {
  if (event.keyCode == '13') {
     currentPosition = (j(this).attr('id')=='paycollege') ? currentPosition+1 : currentPosition-1;
     manageControls(currentPosition);
     j('#slideInner').animate({
      'marginLeft' : slideWidth*(-currentPosition)
    });
   }
  });

  // manageControls: Hides and Shows controls depending on currentPosition
  function manageControls(position){
    // Hide left arrow if position is first slide
	if(position==0){ j('#leftControl').hide() } else{ j('#leftControl').show() }
	// Hide right arrow if position is last slide
    if(position==numberOfSlides-1){ j('#rightControl').hide() } else{ j('#rightControl').show() }
  }
  //calculation process
});
