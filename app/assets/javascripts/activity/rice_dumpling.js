
window.onload = function() {
  $('.btn').click(function(){
    $(this).parent('.startPage').addClass('hidden').siblings('.gamepage').removeClass('hidden');
  })


  var ballH = Math.random()*10+25;
  var ballW = ballH*1.6;
  var ball = {
      width: ballW,
      height: ballH,
      x: document.body.clientWidth/2-ballW,
      y: document.body.clientHeight/2,
      r: Math.random() * 80 + 30,
      vx: 0,
      vy: 0
  };

  var ballSrc = $('.gamepage .ball').attr('src');
  var bjSrc = $('.gamepage .bj').attr('src');
  var dirtSrc = $('.gamepage .dirt').attr('src');

  var ballImg = new Image();
  ballImg.src = ballSrc;

  var bj = new Image();
  bj.src = bjSrc;

  var flag = 1;
  var dirt = new Image();
  dirt.src = dirtSrc;

  var dirtPos = [];
  var clearedDirts = {};

  var dirts = {};
  var finalDirts = {};

  var hazes = [];

  var startX, startY, endX, endY, moveX, moveY;

  var timer;

  var lastnum ,sumnum;

  var canvas = document.getElementById('canvas');
  canvas.width = document.body.clientWidth;
  canvas.height = document.body.clientHeight;
  if (canvas.getContext('2d')) {
      var context = canvas.getContext('2d');
  } else {
      alert('当前浏览器不支持canvas，请更换浏览器再试！')
  }

  bgm.play();

  //bac color
  context.beginPath();
  context.fillStyle = '#f07b6a';
  context.fillRect(0, 0, canvas.width, canvas.height);

  //bac image
  context.drawImage(bj, 0, 0, canvas.width, canvas.height);

  //雾霾
  drawDirts(context);

  //橡皮擦
  drawBall(context, ball.x, ball.y);

  $('.line').css({'left':ball.x+ball.width,'top':ball.y+ball.width});

  var lineTimer = setInterval(function(){
    $('.line').animate({height:"50px"},500,function(){
      $('.line').animate({height:"0"});
    });
  },1000)


  function startEvent() {
      event.preventDefault();
      var touch = event.touches[0];
      startX = touch.pageX;
      startY = touch.pageY;
      bgm.pause();

      $('.line').css({'display':'none'});
      clearInterval(lineTimer);
  }

  function moveEvent() {
      event.preventDefault();
      var touch = event.touches[0];
      endX = touch.pageX;
      endY = touch.pageY;
      moveX = endX - startX;
      moveY = endY - startY;

      $('.line').css({'display':'none'});
      clearInterval(lineTimer);
  }
  
  function endEvent() {
      if (moveX || moveY) {
          d.play();
          ball.vx = - moveX;
          ball.vy = - moveY;
          timer = setInterval(function() {
              updateBall(context, canvas.width, canvas.height);
              render(context);
          }, 10);
      }
  }

  canvas.addEventListener("touchstart", startEvent, false);

  canvas.addEventListener("touchmove", moveEvent, false);

  canvas.addEventListener("touchend", endEvent, false);

  function aDirt(cxt){
      var dirtW = Math.random() * 20+10;
      var adirt = {
          x: 10 + Math.random() * canvas.width,
          y: 10 + Math.random() * canvas.height,
          width: dirtW,
          height: dirtW 
      }
      dirts[adirt.x + adirt.width/2] = adirt;
  }

  
  function drawDirts(cxt){
      for(var i = 0;i<Math.random()*50+100;i++){
          aDirt(cxt);
      }
      var keys = Object.keys(dirts);
      for (var i = 0;i<keys.length;i++) {
          var aDirtPos = {
              x: dirts[keys[i]].x + dirts[keys[i]].width / 2,
              y: dirts[keys[i]].y + dirts[keys[i]].height / 2
          };
          dirtPos.push(aDirtPos);
          cxt.drawImage(dirt, dirts[keys[i]].x, dirts[keys[i]].y, dirts[keys[i]].width, dirts[keys[i]].height);
      }
  }


  //球 橡皮擦
  function drawBall(cxt, x, y) {
      cxt.drawImage(ballImg, x, y, ballW, ballH);
      dirtPos.forEach(function(item, index) {
        isInRect(item,x,y);
      });
  }


  //剩余雾霾数
  function result(){
      var finalsKeys = Object.keys(finalDirts);

      finalsKeys.forEach(function(item, idx){
          delete dirts[item];
      });
  }


  //统计擦掉的雾霾数
  function isInRect(pos,ballX,ballY) {
      var x = pos.x,
        y = pos.y;
      
      if (x > ballX-3 && x < ballX + ball.width+3 && y > ballY-3 && y < ballY + ball.height+3) {  
          clearedDirts[pos.x] = pos.x;
          finalDirts[pos.x] = dirtPos.filter(function(item, index){
              return item.x == pos.x;
          });
          result();
      }
  }


  function updateDirt(cxt){
      var keys = Object.keys(dirts);
      for(var i = 0;i<keys.length;i++){
          cxt.drawImage(dirt, dirts[keys[i]].x, dirts[keys[i]].y, dirts[keys[i]].width, dirts[keys[i]].height);
      }
  }

  function redrawDirts(cxt){
    dirts = {};
    for(var i = 0;i<Math.random()*50+100;i++){
      aDirt(cxt);
    }
    var keys = Object.keys(dirts);
    for (var i = 0;i<keys.length;i++) {
      var aDirtPos = {
        x: dirts[keys[i]].x + dirts[keys[i]].width / 2,
        y: dirts[keys[i]].y + dirts[keys[i]].height / 2
      };
      dirtPos.push(aDirtPos);
      cxt.drawImage(dirt, dirts[keys[i]].x, dirts[keys[i]].y, dirts[keys[i]].width, dirts[keys[i]].height);
    }
  }


  //更新球速和坐标
  function updateBall(cxt, canvasWidth, canvasHeight) {

      ball.x += ball.vx;
      ball.y += ball.vy;

      if (ball.x - ball.r <= 0) {
          ball.vx = -ball.vx * 0.75;
          ball.x = ball.r;
          d.play();
      }

      if (ball.x + ball.r >= canvasWidth) {
          ball.vx = -ball.vx * 0.75;
          ball.x = canvasWidth - ball.r;
          d.play();
      }

      if (ball.y - ball.r <= 0) {
          ball.vy = -ball.vy * 0.75;
          ball.y = ball.r;
          d.play();
      }

      if (ball.y + ball.r >= canvasHeight) {
          ball.vy = -ball.vy * 0.75;
          ball.y = canvasHeight - ball.r;
          d.play();
      }

      canvas.removeEventListener('touchstart', startEvent, false);
      canvas.removeEventListener('touchmove', moveEvent, false);
      canvas.removeEventListener('touchend', endEvent, false);

      if (Math.abs(ball.vx) < 3) {
          clearInterval(timer);
          if($('.clearedDirts').text()!=''){
         
            if($('.clearedDirts').attr('data-sumnum')){
              lastnum = $('.clearedDirts').attr('data-sumnum');
            }else{
              lastnum = $('.clearedDirts').text();
            }
            sumnum = Object.keys(clearedDirts).length;
            $('.clearedDirts').attr('data-sumnum',sumnum);
            $('.clearedDirts').text(sumnum-lastnum);

          }else{
            $('.clearedDirts').text(Object.keys(clearedDirts).length);
          }

          var width = document.documentElement.clientWidth;
          var height = $('.gamepage').height();
          $('.sharePage').removeClass('hidden');
          $('.sharePage,.share_bac,.share_con,.share_to_bac').css({'width':width,'height':height});
      }
  }

  


  $('.restart').click(function(){
    $('.sharePage').addClass('hidden');
    context.clearRect(0, 0, canvas.width, canvas.height);
    bgm.play();

    //bac color
    context.beginPath();
    context.fillStyle = '#f07b6a';
    context.fillRect(0, 0, canvas.width, canvas.height);

    //bac image
    context.drawImage(bj, 0, 0, canvas.width, canvas.height);

    //雾霾
    redrawDirts(context);


    //橡皮擦
    drawBall(context, ball.x, ball.y);

    canvas.addEventListener("touchstart", startEvent, false);

    canvas.addEventListener("touchmove", moveEvent, false);

    canvas.addEventListener("touchend", endEvent, false);

  });

  $('.share_to').click(function(){
    $('.share_title').css({'display':'block'});
    $('.share_to_bac').removeClass('hidden');
  })


  function render(cxt){
      cxt.clearRect(0, 0, canvas.width, canvas.height);
      //将canvas整体填充背景
      context.beginPath();
      context.fillStyle = '#f07b6a';
      context.fillRect(0, 0, canvas.width, canvas.height);
      context.drawImage(bj, 0, 0, canvas.width, canvas.height);

      //drawDirts(cxt);
      updateDirt(cxt);
      drawBall(cxt, ball.x, ball.y);  
  }

  var imageUrl = $("#data").data('imageUrl');
  var musicUrl = $("#data").data('musicUrl');
  var linkUrl = $("#data").data('linkUrl');
  wx.onMenuShareTimeline({
    title: '大元宵大战雾霾怪！',
    link: linkUrl,
    imgUrl: imageUrl,
    success: function () { },
    cancel: function () { }
  });

  wx.onMenuShareAppMessage({
    title: '大元宵大战雾霾怪！',
    desc: '我用卡拉丁大元宵击败了'+$('.clearedDirts').text()+'只雾霾怪，快来挑战我吧',
    link: linkUrl,
    imgUrl: imageUrl,
    type: 'music', // 分享类型,music、video或link，不填默认为link
    dataUrl: musicUrl, // 如果type是music或video，则要提供数据链接，默认为空
    success: function () { },
    cancel: function () { }
  });

}