$(document).ready(function() {
    loadOverviewTooltips();
});

function loadOverviewTooltips() {
    if($('ul#overview').length){
        $('ul#overview li a[title]').each(function() {
            $(this).tooltip();
        });
    }
}
