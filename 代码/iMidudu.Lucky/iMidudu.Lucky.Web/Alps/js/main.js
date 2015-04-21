//配置页面加载模块参数
document.addEventListener("touchstart", function(){}, true)

require.config({
    //配置Javascript文件映射路径
    paths: {
        modernizr: "modernizr.custom",
        jquery: ["http://cdn.bootcss.com/jquery/2.1.3/jquery.min", "jquery.min"], //默认加载CDN库，如果没有，就加载本地库
        jay: "jay"
    },
    shim: {
        //模块依赖关系 demo
        //'swiperscrollbar': {deps:['swiper']},
        //'swiper': {deps: ['jquery']},
        //'jay'  : {deps: ['swiper','swiperscrollbar']}
        'jay': {
            deps: ['jquery']
        }
    }
});

//配置页面加载模块
require(['modernizr'], function(modernizr) {
    !Modernizr.rgba ? window.location = "np.html" : '';
});

require(
    [
        'jay'
    ],
    function(jquery, jay) {
        $(function() {
            //转盘 ---start
            var deg = -67;
            var old_p_idx = 0;
            var prize = ["thanks", "bear", "thanks", "tv", "bear", "thanks", "kxt", "bear", "thanks", "kxt"];
            $(".rotate-arrow-text img").click(function() {
                var _self = $(this);
                //锁定按钮
                if (_self.hasClass("act")) {
                    return false;
                }
                _self.addClass('act');
                var new_p_idx = Math.floor(Math.random() * 10); //奖品索引
                //console.log(new_p_idx);
                deg += 1440;
                deg += (new_p_idx - old_p_idx) * 36;
                old_p_idx = new_p_idx;
                $(".arrow-img").css({
                    "-webkit-transform": "rotate(" + deg + "deg)",
                    "transform": "rotate(" + deg + "deg)"
                });

                setTimeout(function() {
                    //console.log("end");
                    //解锁按钮
                    _self.removeClass('act');
                    var url = "price-4";
                    switch (prize[new_p_idx]) {
                        case "thanks":
                            url = "price-4";
                            break;
                        case "tv":
                            url = "price-3";
                            break;
                        case "kxt":
                            url = "price-2";
                            break;
                        case "bear":
                            url = "price-1";
                            break;
                        default: break;
                    }
                    location.href = url+".html";
                }, 4000);
            });

            //转盘 ---end

            //jayfunction();
        });
    }
);
