chrome.browserAction.onClicked.addListener(function(tab) {
  // No tabs or host permissions needed!
  // console.log('Turning ' + tab.url + ' red!');
  console.log("heyyy");
  chrome.tabs.executeScript(tab.id, {
    file: "on-page.js"
  });
    // code: "window.getSelection().toString();"
  // }, function(selection) {
  //   console.log(selection);
  //   // document.getElementById("output").value = selection[0];
  // });
});
