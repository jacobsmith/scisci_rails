// https://github.com/daneden/animate.css

function reanimate(element) {
  var elm = element;
  var newone = elm.cloneNode(true);
  elm.parentNode.replaceChild(newone, elm);
}
