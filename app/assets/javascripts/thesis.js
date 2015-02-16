$('#edit_project_1').on('ajax:success', function(e, data, status, xhr) {
  $('#project_thesis')[0].value = data.thesis;
  $('#read_only_thesis')[0].innerHTML = data.thesis;
  
  //TODO: get the toast/flash message to show appropriately
});
