console.log('loaded')

$(document).on("click", "[data-behavior~=collapsable-expand-details]", function(e) {
  var element = $(e.target);

  parent = element.closest(".collapsable-container");
  controls = parent.children("[data-behavior~=collapsable-controls]")

  parent.children("[data-behavior~=collapsable-details]").show();
  parent.children("[data-behavior~=collapsable-summary]").hide();

  controls.children("[data-behavior~=hide]").show();
  controls.children("[data-behavior~=expand]").hide();
});

$(document).on("click", "[data-behavior~=collapsable-hide-details]", function(e) {
  var element = $(e.target);

  parent = element.closest(".collapsable-container");
  controls = parent.children("[data-behavior~=collapsable-controls]")

  parent.children("[data-behavior~=collapsable-details]").hide();
  parent.children("[data-behavior~=collapsable-summary]").show();

  controls.children("[data-behavior~=hide]").hide();
  controls.children("[data-behavior~=expand]").show();
});
