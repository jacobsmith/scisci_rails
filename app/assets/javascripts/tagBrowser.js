;(function() {

var TagBrowser = function(elem) {
  this.$container = elem;
  if (elem.length === 0) return;

  this.filters = [];
  this.$tags = this.$container.find('.tag-list li');

  this.init();
  this.events();
}
TagBrowser.prototype = {
  init: function() {
    this.$tags.each(function() {
      var tagName = $(this).children().eq(0).text();
      this.setAttribute('data-tag', tagName);
    });
  },
  events: function() {
    var self = this;

    this.$tags.click(function() {
      if ($(this).hasClass('is-inactive') || self.filters.length === 0) {
        self.addFilter(this);
      }
      else {
        self.removeFilter(this);
      }
      return false;
    });
  },
  addFilter: function(elem) {
    var tagName = elem.getAttribute('data-tag');
    this.filters.push(tagName);

    if (this.filters.length === 1) {
      this.$tags.addClass('is-inactive');
    }
    $(elem).removeClass('is-inactive');

    this.$container.trigger('noteList.filter', this.filters);
  },
  removeFilter: function(elem) {
    var tagName = elem.getAttribute('data-tag');
    this.filters.splice(tagName, 1);

    $(elem).addClass('is-inactive');
    if (this.filters.length === 0) {
      this.$tags.removeClass('is-inactive');
    }

    this.$container.trigger('noteList.filter', this.filters);
  }
}

$(document).ready(function() {
  $('[data-tagbrowser]').each(function() {
    var tagbrowser = new TagBrowser($(this));
  })
})

})();