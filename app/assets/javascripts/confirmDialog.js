;(function() {

var ConfirmDialog = function(elem) {
  this.$container = elem;
  if (this.$container.length === 0) return;

  this.message = this.$container.attr('data-confirm');
  this.action  = this.$container.attr('href');
  this.method  = this.$container.attr('data-method');

  this.events();
}

ConfirmDialog.prototype = {
  events: function() {
    var self = this;
    this.$container.click(function() {
      self.create();
      return false;
    });
  },

  create: function() {
    var html = [
      '<div class="confirm-dialog">',
        '<p class="confirm-dialog__message">'+this.message+'</p>',
        '<a href="'+this.action+'" data-method="'+this.method+'" class="small warning button">Yes, delete</a>',
        '<a data-close class="small secondary button">No, cancel</a>',
      '</div>'
    ].join('\n');

    $(html)
      .appendTo('body')
      .find('[data-close]')
        .click(function() {
          $(this).closest('.confirm-dialog').remove();
        });
  }
}

$(document).ready(function() {
  $('[data-confirm]').each(function() {
    var confirmDialog = new ConfirmDialog($(this));
  });
});

})();
