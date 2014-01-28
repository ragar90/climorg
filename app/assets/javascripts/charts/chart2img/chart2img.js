function getImgData(chartContainer) {
  var svg = chartContainer.innerHTML;
  var doc = chartContainer.ownerDocument;
  var canvas = doc.createElement('canvas');
  canvas.setAttribute('width', 720);
  canvas.setAttribute('height', 580);
  
  
  canvas.setAttribute(
      'style',
      'position: absolute; ' +
      'top: ' + (-chartContainer.offsetHeight * 2) + 'px;' +
      'left: ' + (-chartContainer.offsetWidth * 2) + 'px;');
  doc.body.appendChild(canvas);
  canvg(canvas, svg);
  var imgData = canvas.toDataURL("image/png");
  canvas.parentNode.removeChild(canvas);
  return imgData;
}
      
function saveAsImg(chartContainer) {
  var imgData = getImgData(chartContainer);
  var a = document.createElement('a');
  a.href = imgData.replace("image/png", "image/octet-stream");
  a.download = "chart.png";
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