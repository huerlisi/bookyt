$(document).ready(function() {
    loadOverviewTooltips();
    loadIconTooltips();
});

function loadOverviewTooltips() {
    if($('ul#overview').length){
        $('ul#overview li a[title]').each(function() {
            $(this).tooltip();
        });
    }
}

function loadIconTooltips() {
    var icons = $('a.icon-tooltip[title]');
    if(icons.length) {
        icons.each(function() {
            $(this).tooltip({
                tipClass: 'icon-tooltip-popup',
                effect: 'fade',
                fadeOutSpeed: 100
            });
        });
    }
}
