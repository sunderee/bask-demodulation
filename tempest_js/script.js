
function drawImage(char){
  canvas = document.getElementById('canvas');
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  ctx = canvas.getContext('2d');

  ctx.clearRect(0, 0, canvas.width, canvas.height);
  id = ctx.getImageData(0, 0, 1, 1);

  imageData( char);
}

function init(){
drawImage("a")
}

function playFREQ(freq) {

  width=canvas.width;
  height=canvas.height;
  fps=60;
  lines=freq/fps;
  lineH=height/lines;
  
  for(let i=0; i<lines; i++)
  {
    ctx.fillStyle = "rgba(255, 255, 255, "+i%2+")";
    ctx.fillRect(0, i*lineH, canvas.width, lineH);
  }
}

function text2Binary(string) {
    return string.split('').map(function (char) {
        return char.charCodeAt(0).toString(2);
    }).join(' ');
}

var i = 0;                  //  set your counter to 1
var time;
function amModulate(char) {  


  ctx.clearRect(0, 0, canvas.width, canvas.height);
  console.log(i)
  playFREQ(char[i]==="1"?440:0);

  time=setTimeout(()=>{
    i++;
    if(i<char.length){
      amModulate(char);
    }
    else{
      ctx.clearRect(0, 0, canvas.width, canvas.height);
    }
  },17)
}

function imageData(char) {  
  for(let i=0; i<char.length; i++)
  {
    ctx.fillStyle = "rgba(255, 255, 255, "+char[i]+")";
    ctx.fillRect(0, i*(1080/8), canvas.width, (1080/8));
  }
}


function text2Binary(string) {
    return string.split('').map(function (char) {
        return char.charCodeAt(0).toString(2);
    }).join(' ');
}

document.onkeypress = function (e) {
    e = e || window.event;
    clearTimeout(time);
    i = 0;
    console.log(text2Binary(e.key));
    amModulate(text2Binary(e.key));
};