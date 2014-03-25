;(function() {

var NoteList = function(elem) {
  this.$container = elem;

  this.initLayout();
}
NoteList.prototype = {
  initLayout: function() {
    this.$container.isotope({
      resizable: true
    });
  }
}

$(document).ready(function() {
  $('[data-notelist]').each(function() {
    var notelist = new NoteList($(this));
  });
});

})();