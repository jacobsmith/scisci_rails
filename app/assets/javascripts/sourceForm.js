;$(function() {

var sourceEditForm = function(elem) {
  // $container is the form element
  this.$container = elem;
  if (this.$container.length === 0) return;

  // The ui object holds form controls
  this.ui = {
    $sourceTypes:  this.$container.find('[data-sourcetype]'),
    $submitButton: this.$container.find('.submit'),
  }
  // The fieldsets object holds the fieldsets for the three source types
  this.fieldsets = {
    all:      this.$container.find('[data-fieldset]'),
    book:     this.$container.find('[data-fieldset="book"]'),
    magazine: this.$container.find('[data-fieldset="magazine"]'),
    web:      this.$container.find('[data-fieldset="web"]'),
  }

  this.events();
  this.initForm();
}
sourceEditForm.prototype = {
  events: function() {
    var self = this;

    // Setting the source type
    this.ui.$sourceTypes.click(function() {
      self.setSourceType($(this).data('sourcetype'));
      return false;
    });
  },

  initForm: function() {
    // Set source type if it exists
    if (this.$container.attr('data-sourcetype') !== '') {
      this.setSourceType(this.$container.attr('data-sourcetype'));
    }

    this.$container.trigger('sourceEditForm.ready');
    console.log("Form initialized.");
  },

  setSourceType: function(type) {
    console.log("Source type is now " + type);

    // Flag the selected button as selected
    this.ui.$sourceTypes
      .removeClass('is-active')
      .filter('[data-sourcetype="'+type+'"]')
        .addClass('is-active');

    // Update value of source type field
    $('#source_source_type').val(type);
    this.$container.attr('data-sourcetype', type);

    // Show hidden form elements
    this.ui.$submitButton.show(0);
    $('.comments').show();
    $('.authors_div').show();
    $('.addAuthor').show();
    
    // Show the proper fieldset
    this.fieldsets['all'].hide();
    this.fieldsets[type].show();
  }
}

var form = new sourceEditForm($('.edit_source'));
  
});