$("[data-behavior~=toggle-note-feedback]").on("click", function(e) {
  e.preventDefault();
  console.log(e)

  var link = e.target;
  $(link).parents('.note').children("[data-behavior~=note-feedback]").toggle();
});
