// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// Application specific behaviour
function addAlternateTableBehaviour() {
  $("table.list tr:odd").addClass("odd");
}

// Dirty Form
function makeEditForm(form) {
  var buttons = form.find("fieldset.buttons");
  buttons.fadeIn('slow');
}

function addDirtyForm() {
  $(".form-view form").dirty_form()
    .dirty(function(event, data){
      makeEditForm($(this));
    })

  $(".form-view").focusin(function() {makeEditForm($(this))});
}

// Initialize behaviours
function initializeBehaviours() {
  // from cyt.js
  addComboboxBehaviour();
  addAutofocusBehaviour();
  addDatePickerBehaviour();
  addSortableBehaviour();
  addLinkifyContainersBehaviour();
  addOverviewTooltipBehaviour();
  addIconTooltipBehaviour();
  addTimeCheckBehaviour();

  // application
  addAlternateTableBehaviour();
  addDirtyForm();
}

// Loads functions after DOM is ready
$(document).ready(initializeBehaviours);
