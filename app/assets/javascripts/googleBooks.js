function googleBooks() {
  var title = $('#source_title').val();
  var maxResults = "10";

  var googleBooksUrl = 'https://www.googleapis.com/books/v1/volumes?q=' + title + '&maxResults=' + maxResults

  var result = $.getJSON(googleBooksUrl).done(function(response) {
    var books = result.responseJSON.items;
    for (var i = 0; i < books.length; i++) {
      var bookshelf = $("#bookshelf");
      bookshelf.append('<div class="book_entry">Title: ' + books[i].volumeInfo.title + '\n <img src="' + books[i].volumeInfo.imageLinks.smallThumbnail + '" /> </div>');
    };
  });
}
