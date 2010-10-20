$(document).ready(function() {
  addOverviewTooltipBehaviour();
  addIconTooltipBehaviour();
});

function addOverviewTooltipBehaviour() {
  $('ul#overview li a[title]').tooltip();
};

function addIconTooltipBehaviour() {
  $('a.icon-tooltip[title]').tooltip({
    tipClass: 'icon-tooltip-popup',
    effect: 'fade',
    fadeOutSpeed: 100
  });
};
