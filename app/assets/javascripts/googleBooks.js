function googleBooks() {
  // clear bookshelf if anything already exists
  $('#bookshelf').empty();

  var title = $('#source_title').val();
  var maxResults = "10";

  var googleBooksUrl = 'https://www.googleapis.com/books/v1/volumes?q=' + title + '&maxResults=' + maxResults

  var result = $.getJSON(googleBooksUrl).done(function(response) {
    var books = result.responseJSON.items;
    var bookshelf = $("#bookshelf");

    // make books global to page so information can be accessed later
    window.books = books;
   
    for (var i = 0; i < books.length; i++) {
      var bookInfo = books[i].volumeInfo;
      var authors = "";
      for (var j = 0; j < bookInfo.authors.length; j++) {
        if ( bookInfo.authors[j] != undefined ) {
          authors += bookInfo.authors[j];
        };
      };
     
      // append each result into #bookshelf
      bookshelf.append('<div class="book_entry small-3 columns" id="book_entry#' + i + '">' + 
        div( bookInfo.title, 'book_entry-title' ) +
        div(authors, 'book_entry-authors') +
        a("#", "Add Book Information", "addBook(" +  i + "); return false;", "book_entry-addBook") +
        '<img src="' + books[i].volumeInfo.imageLinks.smallThumbnail + '" /> </div>');
    };
  });
}

function addBook(bookEntryId) {
  var book = books[bookEntryId];
  var bookInfo = book.volumeInfo;

  $('#source_title').val( bookInfo.title );
  $('#source_year_of_publication').val( bookInfo.publishedDate.slice(0,4) );
  $('#source_publisher').val( bookInfo.publisher );
}


function div(arg, elementClass, id) {
  var id = id || "";
  var elementClass = elementClass || "";
  var wrappedArg =  '<div class="' + elementClass + '" id="' + id + '">' + arg + '</div>';
  return wrappedArg;
}

function a(target, text, onclick, elementClass) {
  target = target || "#";
  text = text || "Click Here";
  onclick = onclick || "";

  var wrappedA = '<a class="' + elementClass + '" + href="' + target +
    '" onclick="' + onclick + '">' + text + '</a>';
  return wrappedA;
}
/** Volume Info
      authors (Array)
      description (String)
      imageLinks
        smallThumbnail (url)
        thumbnail (url)
      title (String)
      publisher (String)
      publishedDate (yyyy-mm-dd)
      canonicalVolumeLink (String)
**/
