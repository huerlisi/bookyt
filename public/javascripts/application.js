$(document).ready(function() {
  loadOverviewTooltips();
  loadIconTooltips();
});

function loadOverviewTooltips() {
  $('ul#overview li a[title]').tooltip();
};

function loadIconTooltips() {
  $('a.icon-tooltip[title]').tooltip({
    tipClass: 'icon-tooltip-popup',
    effect: 'fade',
    fadeOutSpeed: 100
  });
};
