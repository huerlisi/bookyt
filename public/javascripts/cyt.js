// Autofocus element having attribute data-autofocus
function addAutofocusBehaviour() {
  $('*[data-autofocus=true]').first().focus();
};

// Add datepicker
function addDatePickerBehaviour() {
  $('*[date-picker=true]').each(function(){
    $(this).datepicker({ dateFormat: 'dd.mm.yy' });
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
    var href = element.attr('href');
    element.addClass('linkified_container')

    container.delegate('*', 'click', {href: href}, function(event) {
      // Don't override original link behaviour
      if ($(event.target).parents('a').length == 0) {
        document.location.href = href;
      };
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
