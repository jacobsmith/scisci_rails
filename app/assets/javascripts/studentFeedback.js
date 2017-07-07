$(document).on("click", "[data-behavior~=toggle-note-feedback]", function(e) {
  e.preventDefault();
  var link = e.target;
  $(link).parents('.note').children("[data-behavior~=note-feedback]").toggle();
});

$(document).on("click", "[data-behavior~=toggle-source-feedback]", function(e) {
  e.preventDefault();

  var link = e.target;
  $(link).parents(".source-overview").children("[data-behavior~=source-feedback]").toggle();
});

$(document).on("click", "[data-behavior~=toggle-project-feedback]", function(e) {
  e.preventDefault();
  console.log(e)

  var link = e.target;
  $(link).parents(".project-overview").children("[data-behavior~=project-feedback]").toggle();
});

// $(document).on("click", "[data-behavior~=expand-feedback]", function(e) {
//   element = $(e.target);
//   container = element.parents(".feedback_container");
//
//   // show detailed feedback
//   container.children("[data-behavior~=show-feedback-detail]").show();
//   container.children("[data-behavior~=show-feedback-summary]").hide();
//   container.children('.feedback_toggle').children('[data-behavior~=collapse-feedback]').show()
//   container.children('.feedback_toggle').children('[data-behavior~=expand-feedback]').hide()
// });
//
// $(document).on("click", "[data-behavior~=collapse-feedback]", function(e) {
//   element = $(e.target);
//   container = element.parents(".feedback_container");
//
//   // show detailed feedback
//   container.children("[data-behavior~=show-feedback-detail]").hide();
//   container.children("[data-behavior~=show-feedback-summary]").show();
//   container.children('.feedback_toggle').children('[data-behavior~=collapse-feedback]').hide()
//   container.children('.feedback_toggle').children('[data-behavior~=expand-feedback]').show()
// });
