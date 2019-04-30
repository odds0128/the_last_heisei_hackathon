$(function(){
    var gnavi=$('#topmenu');
    var sidenavi=$('.menuLink');
	//現在のウィンドウサイズを取得
    var w = $(window).width();
    var ttlobj=$('#home h2,.sideContents h2');
    var txtobj=ttlobj.next();
    //グロ—バルメニュー
    function navact(){
        $('#menu_btn').click(function(){
            if(gnavi.css('display')=='none'){
                $(this).addClass('btnOn');
                gnavi.slideDown();                
            }else{
                $(this).removeClass('btnOn');
                gnavi.slideUp();                
            }            
        });               
    };
    navact();
    //サイドメニュー
    function fotact(){
        $('#side_btn').click(function(){
            if(sidenavi.css('display')=='none'){
                $(this).addClass('btnOn');
                sidenavi.slideDown();                
            }else{
                $(this).removeClass('btnOn');
                sidenavi.slideUp();                
            }            
        });               
    };
    fotact();
    //アコーディオン
    function accordion(){
        var thisttl=$(this);
        var thistxt=$(this).next(txtobj);
            if(thistxt.css('display')=='none'){
                thisttl.addClass('menuon').css('margin-bottom',"0px");
                thistxt.slideDown();
                return false;
            }else{
                thistxt.slideUp(function(){
                thisttl.removeClass('menuon').css('margin-bottom',"0px");
                });
                 return false;
            }
    };
    var timer = false;
    $(window).resize(function() {
        var nowwidth='';
        if (timer !== false) {
            clearTimeout(timer);
        }
        timer = setTimeout(function() {
            console.log('resized');
            nowwidth=$(window).width();
            if(nowwidth>600){
                txtobj.show();
                ttlobj.css('margin-bottom',"0px");
                ttlobj.unbind();
                return false;
            }else{
                txtobj.hide();
                ttlobj.css('margin-bottom',"0px");
                ttlobj.unbind();
                ttlobj.bind('click',accordion);
                return false;
            }
        }, 7000);
    });
    //スマホ用  
    if(w<600){
        ttlobj.bind('click',accordion);
        //ページ内リンク
        var p = location.hash;
        var q =  $(p).offset().top;
        var hashId = p.indexOf("#");
        if(0 == hashId){
            $('html,body').animate({ scrollTop: q }, 'slow');
            return false;
        };
    }else{
        ttlobj.unbind();
        return false;
    }
    //アコーディオンend

});
