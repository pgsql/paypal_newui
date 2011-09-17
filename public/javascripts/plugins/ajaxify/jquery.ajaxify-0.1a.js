/**
 * jQuery AJAXify
 *
 * AJAX-'ifies' any <form> or <a> using the specified method of the form.
 *
 * Also sends the value of the button clicked, and the x/y if using <input type="image"/>
 *
 * @package jquery-ajaxify
 * @author Dom Hastings
 */
(function($) {
  /**
   * jQuery.ajaxify
   *
   * The main wrapper method for the Ajaxify object.
   *
   * This adds the event handlers to the required elements.
   *
   * It can accept an options object which may contain the following keys:
   *   'append': A query string to append to the URL (can help to treat AJAX requests differently, default is: ajax=1)
   *   'update': A jQuery selector of an element to update with the result
   *   Also accepts any of the jQuery AjaxOptions keys (http://docs.jquery.com/Ajax/jQuery.ajax#options)
   *
   * @param options object See above
   * @return object The jQuery object
   * @author Dom Hastings
   */
  $.fn.ajaxify = function(options) {
    $.extend( Ajaxify.options, options || {} );

    // loop through all the matched elements
    for (var i = 0; i < this.length; i++) {
      // if we're dealing with a link
      if (this[i].tagName.toLowerCase() == 'a') {
        // just bind to the click event
        $(this[i]).bind('click', function(event) {
          // process the event
          Ajaxify.process(event, this);
        });

      // if it's a form
      } else if (this[i].tagName.toLowerCase() == 'form') {
        // find the possible submission methods
        $(this[i]).find('button[type=submit], input[type=submit], input[type=image]').each(function(i, e) {
          // and attach click handlers to each
          $(e).click(function(event) {
            $(this).before('<input type="hidden" name="' + $(this).attr('name') + '" value="' + $(this).val() + '"/>');

            // if it's an imagae, also capture the x/y co-ordinates
            if ($(this).attr('type') == 'image') {
              $(this).before('<input type="hidden" name="' + $(this).attr('name') + '_y" value="' + (event.pageY - $(this).offset().top) + '"/>');
              $(this).before('<input type="hidden" name="' + $(this).attr('name') + '_x" value="' + (event.pageX - $(this).offset().left) + '"/>');
            }
          });
        });

        // bind to the submit event
        $(this[i]).bind('submit', function(event) {
          // process the event
          Ajaxify.process(event, this);
        });
      }
    }

    // return the jQuery object for chaining
    return this;
  }
})(jQuery);


/**
 * Ajaxify
 *
 * The main logic object.
 *
 * @package jquery.ajaxify
 * @author Dom Hastings
 */
var Ajaxify = {
  /**
   * options
   *
   * @var object See above for a description
   */
  options: {
    'append': 'ajax=1',
    'async': true,
    'contentType': null,
    'dataType': 'html',
    'type': null,
    'update': null,
    'url': null
  },

  /**
   * serializeForm
   *
   * Returns the form's elements for a POST/GET request
   *
   * @param node object The form node to retrieve elements from
   * @return string The request body
   * @author Dom Hastings
   */
  serializeForm: function(node) {
    // initialize the string
    r = '';

    // loop through all the elements (except submits)
    $(node).find('input[type!=submit][type!=button][type!=image], textarea, select').each(function(i, e) {
      // if it's a radio or checkbox
      if ($(e).attr('type') == 'checkbox' || $(e).attr('type') == 'radio') {
        // see if it's been checked
        if ($(e).attr('checked')) {
          // and append the name and value to the string if so
          r += escape($(e).attr('name')) + '=' + escape($(e).val()) + '&';
        }

      // if it's not a radio or checkbox
      } else {
        // and append the name and value to the string
        r += escape($(e).attr('name')) + '=' + escape($(e).val()) + '&';
      }
    });

    return r;
  },

  /**
   * process
   *
   * The main function called by the jQuery function
   *
   * @param e object The jQuery event object
   * @param node object The node being processed
   * @return string The request body
   * @author Dom Hastings
   */
  process: function(e, node) {
    // initialize the options object
    var options = {};

    // extend the object with the default options
    $.extend(options, this.options);

    // if we're working on a form
    if (node.tagName.toLowerCase() == 'form') {
      // set the url to the action attribute or the options url if specified on init
      options.url = (options.url) ? this.appendToURL(options.url) : this.appendToURL($(node).attr('action'));
      // set the type to the method attribute or the options type
      options.type = (options.type) ? options.type : $(node).attr('method').toUpperCase();
      // set the content type
      options.contentType = (options.contentType) ? options.contentType : $(node).attr('enctype') || 'application/x-www-form-urlencoded';
      // get the form data
      options.data = this.serializeForm(node);

    // if we're working on a link
    } else if (node.tagName.toLowerCase() == 'a') {
      // set the url to the href attribute or the options url if specified
      options.url = (options.url) ? this.appendToURL(options.url) : this.appendToURL($(node).attr('href'));
      // set the type to GET or the options type
      options.type = (options.type) ? options.type : 'GET';
      // set the content type
      options.contentType = (options.contentType) ? options.contentType : 'application/x-www-form-urlencoded';

    // if it's not a form or a link leave it alone!
    } else {
      return;
    }

    // stop the default event
    e.preventDefault();

    // update the element specified in options, or the parent element if not
    options.update = (options.update) ? options.update : $(node).parent();

    // set up the success callback
    if( !options.success ) options.success = function(data, textStatus) {
      $(options.update).html(data);
    }

    // set up the error callback
    options.error = function(XMLHttpRequest, textStatus, errorThrown) {
      alert('Error processing data via AJAX:\n' + errorThrown + ' (' + textStatus + ')');
    }

    // run the request
    $.ajax(options);
  },

  /**
   * appendToURL
   *
   * Appends the specified query string to the URL being requested
   *
   * @param url string The URL being requested
   * @return string The URL with the query string appended if specified
   * @author Dom Hastings
   */
  appendToURL: function(url) {
    // if the options specify a URL append
    if (this.options.append) {
      // if there's a # in the url, strip it off first
      if (url.indexOf('#') != -1) {
        url = url.substr(0, url.indexOf('#'));
      }

      // add it correctly (using & if ? already appears in the URL)
      url += (url.indexOf('?') == -1 ? '?' + this.options.append : '&' + this.options.append)
    }

    return url;
  }
}
