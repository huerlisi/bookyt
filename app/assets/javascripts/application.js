// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery-ui
//= require twitter/bootstrap
//= require_tree .

// Application specific behaviour
function addAlternateTableBehaviour() {
  $("table.list tr:odd").addClass("odd");
}

// Dirty Form
function makeEditForm(form) {
  var buttons = form.find("fieldset.buttons");
  buttons.animate({opacity: 1}, 1000);
}

function addDirtyForm() {
  $(".form-view form").dirty_form()
    .dirty(function(event, data){
      makeEditForm($(this));
    })

  $(".form-view").focusin(function() {makeEditForm($(this))});
}

function addNestedFormBehaviour() {
  $(".delete-nested-form-item").live("click", function(event) {
    var item = $(this).parents('.nested-form-item');
    // Hide item
    item.hide();
    // Mark as ready to delete
    item.find("input[name$='[_destroy]']").val("1");
    // Drop input fields to prevent browser validation problems
    item.find(":input").not("[name$='[_destroy]'], [name$='[id]']").remove();

    var line_items = $(this).parents('.line_items');
    updateTotalAmount(line_items);

    // Don't follow link
    event.preventDefault();
  });
}

// Line Item caluclation
function calculateLineItemTotalAmount(lineItem) {
  var times_input = lineItem.find(":input[name$='[times]']");
  var times = parseFloat(times_input.val());
  var quantity_input = lineItem.find(":input[name$='[quantity]']");
  var price_input = lineItem.find(":input[name$='[price]']");
  var price = parseFloat(price_input.val());

  if (quantity_input.val() == '%') {
    times = times / 100;
  };

  var value = times * price;
  if (isNaN(value)) {
    return 0.0;
  } else {
    return value;
  }
}

function updateLineItemTotalAmount(lineItem) {
  var total_amount_input = lineItem.find(".total_amount");
  var total_amount = CommaFormatted(calculateLineItemTotalAmount(lineItem).toFixed(2));

  // Update Element
  total_amount_input.text(total_amount);
}

function calculateTotalAmount(lineItems) {
  var total_amount = 0;
  $(line_items).find('.line_item').each(function() {
    total_amount += calculateLineItemTotalAmount($(this));
  });

  return total_amount
}

function updateTotalAmount(lineItems) {
  // Update Element
  $(".line_item_total .total_amount").text(CommaFormatted(calculateTotalAmount(lineItems).toFixed(2)));
}

// Recalculate after every key stroke
function handleLineItemChange(event) {
  // If character is <return>
  if(event.keyCode == 13) {
    // ...trigger form action
    $(event.currentTarget).submit();
  } else if(event.keyCode == 32) {
    // ...trigger form action
    $(event.currentTarget).submit();
  } else {
    var line_item = $(this).parents('.line_item');
    updateLineItemTotalAmount(line_item);

    var line_items = $(this).parents('.line_items');
    updateTotalAmount(line_items);
  }
}

function addCalculateTotalAmountBehaviour() {
  $("#line_items").find(":input[name$='[times]'], :input[name$='[price]']").live('keyup', handleLineItemChange);
}

/*
* This function is copy pasted from: http://www.web-source.net/web_development/currency_formatting.htm
 */
function CommaFormatted(amount) {
	var delimiter = "'"; // replace comma if desired
	var a = amount.split('.',2)
	var d = a[1];
	var i = parseInt(a[0]);
	if(isNaN(i)) { return ''; }
	var minus = '';
	if(i < 0) { minus = '-'; }
	i = Math.abs(i);
	var n = new String(i);
	var a = [];
	while(n.length > 3)
	{
		var nn = n.substr(n.length-3);
		a.unshift(nn);
		n = n.substr(0,n.length-3);
	}
	if(n.length > 0) { a.unshift(n); }
	n = a.join(delimiter);
	if(d.length < 1) { amount = n; }
	else { amount = n + '.' + d; }
	amount = minus + amount;
	return amount;
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
  addNestedFormBehaviour();

  addCalculateTotalAmountBehaviour();

  // twitter bootstrap
  $(function () {
    $('.tabs').tabs();
    $(".alert-message").alert();
    $("*[rel=popover]").popover({
      offset: 10
    });
  })
}

// Loads functions after DOM is ready
$(document).ready(initializeBehaviours);
