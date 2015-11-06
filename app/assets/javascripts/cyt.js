// Combobox
function addComboboxBehaviour() {
  $("select.combobox").select2({
    allowClear: true,
    width: 'resolve'
  });
}

// Autofocus element having attribute data-autofocus
function addAutofocusBehaviour() {
  $('*[data-autofocus=true]')
    .filter(function() {return $(this).parents('.form-view').length < 1})
    .first().focus();
};

// Add datepicker
function addDatePickerBehaviour() {
  $('.date-picker').each(function(){
    $(this).datepicker({
      format: 'dd.mm.yyyy',
      orientation: "auto",
      autoclose: true,
      clearBtn: true,
      keyboardNavigation: false
    });
  });
};

//
function addSortableBehaviour() {
  $(".sortable").sortable({
    placeholder: 'ui-state-highlight'
  });
  $(".sortable").disableSelection();
};


// Linkify containers having attribute data-href-container
function addLinkifyContainersBehaviour() {
  var elements = $('*[data-href-container]');
  elements.each(function() {
    var element = $(this);
    var container = element.closest(element.data('href-container'));
    container.css('cursor', "pointer");
    container.addClass('linkified_container')
    var href = element.attr('href');
    element.addClass('linkified_element')

    container.delegate('*', 'click', {href: href}, function(event) {
      // Don't override original link behaviour
      if (event.target.nodeName == 'A' || $(event.target).parents('a').length > 0) {
        return;
      } else if ($(event.target).hasClass('best_in_place')) {
        return;
      };

      document.location.href = href;
    });
  });
};

// Autogrow
function addAutogrowBehaviour() {
  $(".autogrow").elastic();
};

// Add tooltips for overview
function addTooltipBehaviour() {
  $(".tooltip-title[title]").each(function() {
    if ( $(this).attr('title') != '' ) {
      $(this).tooltip({
        position: 'top center',
        predelay: 500,
        effect: 'fade'
      });
    }
  });
};

// Add tooltips for overview
function addOverviewTooltipBehaviour() {
  $('.overview-list li a[title]').tooltip({
    position: 'center right',
    predelay: 500,
    effect: 'fade'
  });
};

// Add icon action tooltips
function addIconTooltipBehaviour() {
  $('a.icon-tooltip[title]').tooltip({
    tipClass: 'icon-tooltip-popup',
    effect: 'fade',
    fadeOutSpeed: 100
  });
};

// Modal dialog support
function setupSubmitButtons() {
  $("body").on('click', '.modal-footer .submit-button', function() {
    var form = $(this).parents('.modal').find('.modal-body form');
    form.submit();
  });
}

// Cancel button support
function setupCancelButtons() {
  // Key handler
  $(document).keydown(function(e) {
    var cancel_button = $('.cancel-button:visible')
    // No action if no visible cancel button present
    if (cancel_button.length == 0) {
      return;
    }

    if (e.which == 27) {
      cancel_button.click();
    }
  })
}

function addModalBehaviour() {
  setupSubmitButtons();
  setupCancelButtons();
}
