$(document).ready(function() {
  $('[id^=select-form]').change(function(){
    var work_id = $(this).data('work-id');
    var status = $(this).find('option:selected').val();
    $('input[name="work_id"]').val(work_id);
    $('input[name="watch_status"]').val(status);
    $('#status-update' + $(this).attr("id").slice(-1)).submit();
  });
});