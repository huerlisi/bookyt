// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Autofocus element having attribute data-autofocus
document.observe("dom:loaded", function() {
  elements = $$("*[data-autofocus]");
  elements.first().activate();
});

