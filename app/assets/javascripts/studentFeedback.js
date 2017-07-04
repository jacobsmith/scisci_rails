$(document).on("click", "[data-behavior~=toggle-note-feedback]", function(e) {
  e.preventDefault();
  var link = e.target;
  $(link).parents('.note').children("[data-behavior~=note-feedback]").toggle();
});

$(document).on("click", "[data-behavior~=toggle-source-feedback]", function(e) {
  e.preventDefault();
  console.log(e)

  var link = e.target;
  $(link).parents(".source-overview").children("[data-behavior~=source-feedback]").toggle();
});
