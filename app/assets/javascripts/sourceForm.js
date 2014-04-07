;(function() {

var SourceForm = function(elem) {
  // $container is the form element
  this.$container = elem;
  if (this.$container.length === 0) return;

  // The ui object holds form controls
  this.ui = {
    $sourceTypes:         this.$container.find('[data-sourcetype]'),
    $submitButton:        this.$container.find('input[type="submit"]'),
    $addAuthorButton:     this.$container.find('[data-authors-add]'),
    $removeAuthorsButton: this.$container.find('[data-authors-remove]')
  }
  // The fieldsets object holds the fieldsets for the three source types
  this.fieldsets = {
    all:      this.$container.find('[data-fieldset]'),
    book:     this.$container.find('[data-fieldset="book"]'),
    magazine: this.$container.find('[data-fieldset="magazine"]'),
    web:      this.$container.find('[data-fieldset="web"]'),
  }
  this.$authorList = this.$container.find('[data-authors]');

  this.events();
  this.initForm();
}
SourceForm.prototype = {
  events: function() {
    var self = this;

    // Setting the source type
    this.ui.$sourceTypes.click(function(event) {
      self.setSourceType($(this).data('sourcetype'));
      return false;
    });

    // Adding an author fieldset
    this.ui.$addAuthorButton.click(function(event) {
      self.addAuthor();
      return false;
    });
    $(window).on('sourceForm.addAuthor', function(event, firstName, lastName) {
      self.addAuthor(firstName, lastName);
    });
    // Removing an author
    this.ui.$removeAuthorsButton.click(function(event) {
      self.removeAuthor();
      return false;
    });
    // Resetting authors
    $(window).on('sourceForm.resetAuthors', function(event) {
      self.resetAuthors();
    });
  },

  initForm: function() {
    this.ui.$submitButton.hide();
    this.ui.$removeAuthorsButton.hide();
    
    // Set source type if it exists
    if (/(book|journal|web)/.test(this.$container.attr('data-sourcetype'))) {
      this.setSourceType(this.$container.attr('data-sourcetype'));
    }
    else {
      this.fieldsets.all.hide();
    }

    this.$container.trigger('sourceEditForm.ready');
  },

  setSourceType: function(type) {
    // Flag the selected button as selected
    this.ui.$sourceTypes
      .removeClass('is-active')
      .filter('[data-sourcetype="'+type+'"]')
        .addClass('is-active');

    // Update value of source type field
    $('#source_source_type').val(type);
    this.$container.attr('data-sourcetype', type);

    // Show hidden form elements
    this.ui.$submitButton.show();
    $('.source-edit__comments').show();
    $('.authors-edit').show();
    
    // Show the proper fieldset
    this.fieldsets['all'].hide();
    this.fieldsets[type].show();
  },

  addAuthor: function(firstName, lastName) {
    firstName = firstName || "";
    lastName  = lastName  || "";

    var authorCount = this.$container.find('[data-authors-item]').length;
    authorCount++;

    // Structure of the author name form
    var html = [
      '<div class="authors-edit__item" data-authors-item>',
        '<div class="authors-edit__item__number">',
          '<label class="inline">Author #'+authorCount+'</label>',
        '</div>',
        '<div class="authors-edit__item__firstname">',
          '<input type="text" name="source[authorFirst#'+authorCount+']" placeholder="First name" value="'+firstName+'">',
        '</div>',
        '<div class="authors-edit__item__lastname">',
          '<input type="text" name="source[authorLast#'+authorCount+']" placeholder="Last name" value="'+lastName+'">',
        '</div>',
      '</div>'
    ].join('\n');
    // Append it before the add/remove buttons
    var $newAuthorItem = $(html)
      .insertBefore(this.ui.$addAuthorButton)
      .hide()
      .slideDown(200, 'swing');
    // Focus the first name field of the new item,
    // Unless this call was triggered by the page loading
    if (authorCount > 1) {
      $newAuthorItem
        .find('input')
          .eq(0)
          .focus();
    }

    if (authorCount > 1) {
      this.ui.$removeAuthorsButton.fadeIn(500, 'swing');
    }
  },

  removeAuthor: function() {
    var $authorItems = this.$container.find('[data-authors-item]');
    var authorCount = $authorItems.length;
    authorCount--;

    $authorItems.eq(-1).slideUp(150, 'swing', function() {
      this.remove();
    });

    if (authorCount === 1) {
      this.ui.$removeAuthorsButton.fadeOut(500, 'swing');
    }
  },

  resetAuthors: function() {
    var $authorItems = this.$container.find('[data-authors-item]');
    $authorItems.remove();
  }
}

$(document).ready(function() {
  $('[data-sourceform]').each(function() {
    var sourceForm = new SourceForm($(this));
  });
})
  
})();