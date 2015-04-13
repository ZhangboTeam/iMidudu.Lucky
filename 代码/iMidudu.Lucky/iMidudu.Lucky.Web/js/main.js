//配置页面加载模块参数
require.config({
	//配置Javascript文件映射路径
	paths: {
		modernizr		:"modernizr.custom",
		jquery			:["http://cdn.bootcss.com/jquery/2.1.3/jquery.min","jquery.min"], //默认加载CDN库，如果没有，就加载本地库
		jay				:"jay"
	},
	shim: {
		//模块依赖关系 demo
		//'swiperscrollbar': {deps:['swiper']},
		//'swiper': {deps: ['jquery']},
		//'jay'  : {deps: ['swiper','swiperscrollbar']}
		'jay'  : {deps: ['jquery']}
	}
});

//配置页面加载模块
require(['modernizr'],function(modernizr) {
	!Modernizr.rgba?window.location="np.html":'';
});

require(
	[
		'jay'		
	], 
	function (jquery,jay){
		$(function() {
			//jayfunction();
		});
	}
);


