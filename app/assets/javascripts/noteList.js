;(function() {

var NoteList = function(elem) {
  this.$container = elem;
  this.$notes     = this.$container.find('.note-list__item');

  this.initLayout();
  if ($('[data-tagbrowser]').length > 0) {
    this.initTagging();
  }
}
NoteList.prototype = {
  initLayout: function() {
    this.$container.isotope({
      resizable: true
    });
  },
  initTagging: function() {
    this.$notes.each(function() {
      var tags = $(this).find('.tag a')
        .map(function() {
          return this.innerHTML;
        })
        .get()
        .join(' ');
      this.setAttribute('data-tags', tags);
    });

    this.events();
  },
  events: function() {
    var self = this;

    $(window).on('noteList.filter', function(event, data) {
      var args = Array.prototype.slice.apply(arguments);
      var tags = args.slice(1).join(' ');
      self.$container.isotope({
        filter: '[data-tags~="'+tags+'"]'
      });
    });
  },
}

$(document).ready(function() {
  $('[data-notelist]').each(function() {
    var notelist = new NoteList($(this));
  });
});

})();