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
//= require accounting
//= require accounting-jquery
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
    item.addClass('delete');
    // Drop input fields to prevent browser validation problems
    item.find(":input").not("[name$='[_destroy]'], [name$='[id]']").remove();

    // TODO: should be callbacks
    updatePositions($(this).parents('.nested-form-container'));
    updateLineItems();

    // Don't follow link
    event.preventDefault();
  });
}

// Currency helpers
function currencyRound(value) {
  if (isNaN(value)) {
    return 0.0;
  };

  rounded = Math.round(value * 20) / 20;

  return rounded.toFixed(2);
}

// Line Item calculation
function updateLineItemPrice(lineItem) {
  var list = lineItem.parent();
  var reference_code = lineItem.find(":input[name$='[reference_code]']").val();
  if (reference_code) {
    var included_items = list.find(":input[name$='[code]'][value='" + reference_code + "']").parents('.line_item, .saldo_line_item');
    if (included_items.length == 0) {
      // Should match using ~= but acts_as_taggable_adds_colons between tags
      var included_items = list.find(":input[name$='[include_in_saldo_list]'][value*='" + reference_code + "']").parents('.line_item, .saldo_line_item');
    };

    var price_input = lineItem.find(":input[name$='[price]']");
    price_input.val(calculateTotalAmount(included_items));
  }
}

function updateAllLineItemPrices() {
  $('.line_item, .saldo_line_item').each(function() {
    updateLineItemPrice($(this));
  });
}

function calculateLineItemTotalAmount(lineItem) {
  var times_input = lineItem.find(":input[name$='[times]']");
  var times = accounting.parse(times_input.val());
  if (isNaN(times)) {
    times = 1;
  };

  var quantity_input = lineItem.find(":input[name$='[quantity]']");
  var price_input = lineItem.find(":input[name$='[price]']");
  var price = accounting.parse(price_input.val());

  // For 'saldo_of' items, we don't take accounts into account
  if (quantity_input.val() == "saldo_of") {
    return currencyRound(price);
  };

  var direct_account_id = $('#line_items').data('direct-account-id');
  var direct_account_factor = $('#line_items').data('direct-account-factor');

  var factor = 0;
  if (lineItem.find(":input[name$='[credit_account_id]']").val() == direct_account_id) {
    factor = 1;
  };
  if (lineItem.find(":input[name$='[debit_account_id]']").val() == direct_account_id) {
    factor = -1;
  };

  if (quantity_input.val() == '%') {
    times = times / 100;
  };

  return currencyRound(times * price * factor * direct_account_factor);
}

function updateLineItemTotalAmount(lineItem) {
  var total_amount_input = lineItem.find(".total_amount");
  var total_amount = accounting.formatNumber(calculateLineItemTotalAmount(lineItem));

  // Update Element
  total_amount_input.text(total_amount);
}

function calculateTotalAmount(lineItems) {
  var total_amount = 0;
  $(lineItems).each(function() {
    total_amount += accounting.parse($(this).find(".total_amount").text());
  });

  return currencyRound(total_amount);
}

function updateTotalAmount() {
  // Update Element
  var total_amount = 0;
  $("#line_items").filter(".saldo_line_iten, .line_item").each(function() {
    var line_item = $(this);
    if (line_item.find(":input[name$='[quantity]']").val() != 'saldo_of') {
      total_amount += accounting.parse(line_item.find(".total_amount").text());
    };
  });
  
  $(".line_item_total .total_amount").text(accounting.formatNumber(currencyRound(total_amount)));
}

function updateLineItems() {
  if ($('#line_items').length > 0) {
    $('.line_item, .saldo_line_item').each(function() {
      updateLineItemPrice($(this));
      updateLineItemTotalAmount($(this));
    });

    updateTotalAmount();
  };
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
    updateLineItems();
  }
}

function addCalculateTotalAmountBehaviour() {
  $("#line_items").find(":input[name$='[times]'], :input[name$='[price]']").live('keyup', handleLineItemChange);
}

// Sorting
function updatePositions(collection) {
  var items = collection.find('.nested-form-item').not('.delete');
  items.each(function(index, element) {
    $(this).find("input[id$='_position']").val(index + 1)
  });
}

// Override generic version in cyt.js
function addSortableBehaviour() {
  $(".sortable").sortable({
    placeholder: "ui-state-highlight",
    forcePlaceholderSize: true,
    stop:        function(event, ui) {
      updatePositions($(this));
    }
  });
  $(".sortable").disableSelection();

  $('.nested-form-container').each(function() {
    updatePositions($(this));
  });
}

function initAccounting() {
  // accounting.js
  // Settings object that controls default parameters for library methods:
  accounting.settings = {
          currency: {
                  symbol : "",   // default currency symbol is '$'
                  format: "%v", // controls output: %s = symbol, %v = value/number (can be object: see below)
                  decimal : ".",  // decimal point separator
                  thousand: "'",  // thousands separator
                  precision : 2   // decimal places
          },
          number: {
                  precision : 2,  // default precision on numbers is 0
                  thousand: "'",
                  decimal : "."
          }
  }
}

// Initialize behaviours
function initializeBehaviours() {
  // Init settings
  initAccounting();

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

  updateLineItems();

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
