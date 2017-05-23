$(function() {
    $('input.datepicker').data({behaviour: "datepicker"}).datepicker();
});

$('.datepicker').datepicker({
    format: 'yyyy/mm/dd',
    autoclose: true,
    startDate: '+1d'
});
