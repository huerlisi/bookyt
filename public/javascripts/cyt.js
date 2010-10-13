// Autofocus element having attribute data-autofocus
function addAutofocusBehaviour() {
  $('*[data-autofocus=true]').first().focus();
};

function addDatePickerBehaviour() {
  $('*[date-picker=true]').each(function(){
    $(this).datepicker({ dateFormat: 'dd.mm.yy' });
  });
}

// Linkify containers having attribute data-href-container
function addLinkifyContainersBehaviour() {
  var elements = $('*[data-href-container]');
  elements.each(function(element) {
    var container = element.up(element.readAttribute('data-href-container'));
    container.style.cursor = "pointer";
    container.writeAttribute('data-href', element.readAttribute('href'));
  });
  
  $(document.body).observe("click", function(event) {
    var link = event.findElement("a");
    if (link) {
      return true;
    };
    
    var element = event.element();
    var container = element.up("[data-href]");
    if (container) {
      var href = container.readAttribute('data-href');
      document.location.href = href;

      event.stop();
      return false;
    }
  });
};

// Javascript Highlighter
// Fixed version of comment in
// http://stackoverflow.com/questions/1650389/prototype-js-highlight-words-dom-traversing-correctly-and-efficiently
// TODO: Check with Simon Hürlimann if this function is still in use and rewrite it for jQuery.
//Element.addMethods({
//  highlight: function(element, term, className) {
//    function innerHighlight(element, term, className) {
//      className = className || 'highlight';
//      term = (term || '').toUpperCase();
//
//      var skip = 0;
//      if ($(element).nodeType == 3) {
//        var pos = element.data.toUpperCase().indexOf(term);
//        if (pos >= 0) {
//          var middlebit = element.splitText(pos),
//              endbit = middlebit.splitText(term.length),
//              middleclone = middlebit.cloneNode(true),
//              spannode = document.createElement('span');
//
//          spannode.className = className;
//          spannode.appendChild(middleclone);
//          middlebit.parentNode.replaceChild(spannode, middlebit);
//          skip = 1;
//        }
//      }
//      else if (element.nodeType == 1 && element.childNodes && !/(script|style)/i.test(element.tagName)) {
//        for (var i = 0; i < element.childNodes.length; ++i)
//          i += innerHighlight(element.childNodes[i], term, className);
//      }
//      return skip;
//    }
//    innerHighlight(element, term, className);
//    return element;
//  },
//  removeHighlight: function(element, term, className) {
//    className = className || 'highlight';
//    $(element).select("span."+className).each(function(e) {
//      e.parentNode.replaceChild(e.firstChild, e);
//    });
//    return element;
//  }
//});

// Loads functions after DOM is ready
$(document).ready(function() {
    addAutofocusBehaviour();
    addDatePickerBehaviour();
    addLinkifyContainersBehaviour();
});
