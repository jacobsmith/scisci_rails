function main() {
  console.log('inside main');
  var selection, range, rect = getUserSelection();
  drawBoundingBox(selection, range, rect);
}

function getUserSelection() {
  var selection = window.getSelection();      // get the selection then
  var range = selection.getRangeAt(0);        // the range at first selection group
  var rect = range.getBoundingClientRect(); // and convert this to useful data
  return selection, range, rect;
}

function drawBoundingBox(selection, range, rect) {
  // http://stackoverflow.com/questions/18302683/how-to-create-tooltip-over-text-selection-without-wrapping
  var div = document.createElement('div');   // make box
  // div.style.border = '2px solid black';      // with outline
  div.style.position = 'fixed';              // fixed positioning = easy mode
  div.style.top = rect.top + 'px';       // set coordinates
  div.style.left = rect.left + 'px';
  div.style.height = rect.height + 'px'; // and size
  div.style.width = rect.width + 'px';
  document.body.appendChild(div);            // finally append

  var form = document.createElement('form');
  form.style.position = 'fixed';
  form.style.top = rect.top - 50 + 'px';
  form.style.width = '300px';
  var input = document.createElement('input');

  div.appendChild(form);
  form.appendChild(input);
}

console.log('on-age js');
main();
