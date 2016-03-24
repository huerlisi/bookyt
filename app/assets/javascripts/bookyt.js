// Application specific behaviour
function addAlternateTableBehaviour() {
  $("table.list tr:odd").addClass("odd");
}

function addNestedFormBehaviour() {
  $('body').on('click', '.delete-nested-form-item', function(event) {
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
  var quantity = lineItem.find(":input[name$='[quantity]']").val();
  var after_saldo_line_item = lineItem.prev().hasClass('saldo_line_item');
  var is_saldo_line_item = lineItem.hasClass('saldo_line_item');
  var is_relative_item = (quantity == '%' || quantity == 'saldo_of');
  var no_previous_saldo_line_item = (lineItem.prevAll().find('.saldo_line_item').size() === 0);

  if (is_relative_item && (after_saldo_line_item || is_saldo_line_item || no_previous_saldo_line_item)) {
    var included_items;
    if (reference_code == '') {
      included_items = lineItem.prevAll('.line_item');
    } else {
      // Should match using ~= but acts_as_taggable_adds_colons between tags
      included_items = list.find(":input[name$='[code]'][value='" + reference_code + "']").parents('.line_item, .saldo_line_item');
      if (included_items.length == 0) {
        // Should match using ~= but acts_as_taggable_adds_colons between tags
        included_items = list.find(":input[name$='[include_in_saldo_list]'][value*='" + reference_code + "']").parents('.line_item, .saldo_line_item');
      }
    }
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
  if (lineItem.find(":input[name$='[debit_account_id]']").val() == direct_account_id) {
    factor = 1;
  };
  if (lineItem.find(":input[name$='[credit_account_id]']").val() == direct_account_id) {
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

function updateLineItems() {
  if ($('#line_items').length > 0) {
    $('.line_item, .saldo_line_item').each(function() {
      updateLineItemPrice($(this));
      updateLineItemTotalAmount($(this));
    });
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
  $("#line_items").find(":input[name$='[times]'], :input[name$='[quantity]'], :input[name$='[price]'], input[name$='[reference_code]']").on('keyup', handleLineItemChange);
  $("#line_items").bind("sortstop", handleLineItemChange);
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

  $('.sortable').each(function() {
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
  addIconTooltipBehaviour();
  addModalBehaviour();

  // application
  addAlternateTableBehaviour();
  addNestedFormBehaviour();

  addCalculateTotalAmountBehaviour();

  updateLineItems();

  // twitter bootstrap
  $(function () {
    $('.tabs').tabs();
    $(".alert").alert();
    $("*[rel=popover]").popover({
      offset: 10
    });
    $('.small-tooltip').tooltip({
      placement: 'right'
    });
  })

  // select2
  $('.select2').select2({
      allowClear: true
  });
  $('.select2-tags').each(function(index, element) {
    var tags = $(element).data('tags') || '';

    $(element).select2({
      tags: tags,
      tokenSeparators: [","]
    })
  })

  // best_in_place
  $(".best_in_place").best_in_place();
}

// Loads functions after DOM is ready
$(document).ready(initializeBehaviours);
