$('#update_thesis_form').on('ajax:success', function(e, data, status, xhr) {
  $('body')[0].innerHTML += '<div id="notice">Thesis Updated Successfully</div>';

  $('#project_thesis')[0].value = data.thesis;
  $('#read_only_thesis')[0].innerHTML = data.thesis;
});

function showThesisButtons() {
  $('#thesis-submit')[0].style.cssText = 'display: inline';
  $('#thesis-cancel')[0].style.cssText = 'display: inline';
}

function hideThesisButtons() {
  $('#thesis-submit')[0].style.cssText = 'display: none';
  $('#thesis-cancel')[0].style.cssText = 'display: none';
}
