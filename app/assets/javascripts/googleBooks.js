;(function() {

var GoogleBooksLookup = function(elem) {
  this.$container = elem;
  if (this.$container.length === 0) return;

  this.ui = {
    $lookupButton:     this.$container.find('[data-googlebooks-lookup]'),
    $closeButton:      this.$container.find('[data-googlebooks-close]'),
    $searchField:      this.$container.find('[data-googlebooks-searchfield]'),
    $statusIndicator:  this.$container.find('[data-googlebooks-status]')
  }

  this.$resultsList = this.$container.find('[data-googlebooks-results]');

  this.events();
}

GoogleBooksLookup.prototype = {
  events: function() {
    var self = this;

    self.ui.$lookupButton.click(function(event) {
      self.lookupBook();
    });
    self.ui.$searchField.keypress(function(event) {
      if (event.which === 13) {
        self.lookupBook();
        return false;
      }
    });
  },

  lookupBook: function() {
    var self = this,
        searchTerm = this.ui.$searchField.val(),
        $resultsList = this.$resultsList;

    // Placeholder: don't bother searching if the field is empty
    if (searchTerm.length === 0) return;

    // Build a query for the get request
    var queryUrl = 'https://www.googleapis.com/books/v1/volumes',
        queryParams = {
          q: searchTerm,
          maxResults: 10
        };

    $resultsList
      .empty()
      .removeClass('has-results');
    self.ui.$statusIndicator.text('Looking for books...').slideDown(250);

    // Make the request
    var request = $.getJSON(queryUrl, queryParams);

    // When the request is done...
    request.done(function(data) {
      if (data.totalItems === 0) {
        self.ui.$statusIndicator.text("Sorry, we couldn't find any books with that title. Double-check the spelling and try again.").show(0);
      }
      else {
        self.ui.$statusIndicator.text("We found " + data.totalItems + " books. Here are the first " + data.items.length + ". ").show(0);
        // Empty the list of results to make room for new ones
        $resultsList
          .empty()
          .addClass('has-results');
        // Iterate through the returned items
        $.each(data.items, function(index, book) {
          var title     = book.volumeInfo.title,
              year      = book.volumeInfo.publishedDate || '',
              publisher = book.volumeInfo.publisher || '',
              medium    = book.volumeInfo.printType || 'BOOK',
              image     = book.volumeInfo.imageLinks.smallThumbnail || '',
              authors   = book.volumeInfo.authors || [];
          year    = year.substr(0, 4);
          authors = authors.join(', ');

          var html = [
            '<li class="googlebooks__results__item">',
              '<img class="image" src="'+image+'">',
              '<p class="title">'+title+'</p>',
              '<p class="info">'+authors+' ('+year+')</p>',
            '</li>'
          ].join('\n');

          var $resultItem = $(html)
            .click(function() {
              $('#source_title').val(title);
              $('#source_year_of_publication').val(year);
              $('#source_publisher').val(publisher);
              $('#source_medium').val(medium);
              $('#source_image_url').val(image);
            });
          $resultsList.append($resultItem);
        });
      }
    });

    // If the request fails...
    request.fail(function() {
      self.ui.$statusIndicator.text('There was a problem getting the list of books. Try searching again.').show(0);
    });
  }
}

$(document).ready(function() {
  var googleBooksLookup = new GoogleBooksLookup($('[data-googlebooks]'));
});

})();