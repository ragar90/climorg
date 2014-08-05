function getImgData(chartContainer) {
  var chartArea = chartContainer.getElementsByTagName('div')[1];
  var svg = chartArea.innerHTML;
  var doc = chartContainer.ownerDocument;
  var canvas = doc.createElement('canvas');
  canvas.setAttribute('width', chartArea.offsetWidth);
  canvas.setAttribute('height', chartArea.offsetHeight);
  
  
  canvas.setAttribute(
      'style',
      'position: absolute; ' +
      'top: ' + (-chartArea.offsetHeight * 2) + 'px;' +
      'left: ' + (-chartArea.offsetWidth * 2) + 'px;');
  doc.body.appendChild(canvas);
  canvg(canvas, svg);
  var imgData = canvas.toDataURL();
  canvas.parentNode.removeChild(canvas);
  return imgData;
}
      
function saveAsImg(chartContainer) {
  var imgData = getImgData(chartContainer);
  var a = document.createElement('a');
  a.href = imgData;
  a.download = "chart.png";
  console.log(a)
  a.click();
}

function toImg(chartContainer, imgContainer) { 
  var doc = chartContainer.ownerDocument;
  var img = doc.createElement('img');
  img.src = getImgData(chartContainer);
  
  while (imgContainer.firstChild) {
    imgContainer.removeChild(imgContainer.firstChild);
  }
  imgContainer.appendChild(img);
}