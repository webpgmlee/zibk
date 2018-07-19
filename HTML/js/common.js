// JavaScript Document

$(function () {

    $(".tab_content").hide();
    $(".tab_content:first").show();

    $("ul.tabs li").click(function () {
        $("ul.tabs li").removeClass("active");
        //$(this).addClass("active").css({"color": "darkred","font-weight": "bolder"});
        $(this).addClass("active");
        $(".tab_content").hide()
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn(0)
    });
	
	// 모달창 띄우기
	$('.btn-example').click(function(){
        var $href = $(this).attr('href');
        layer_popup($href);
    });
	
	// 배경이미지 롤링
	$('.backgroundTransition').backgroundTransition({
		backgrounds:[
			{ src: 'img/mnd001.jpg' },
			{ src: 'img/mnd002.jpg' },
			{ src: 'img/mnd003.jpg' },
			{ src: 'img/mnd004.jpg' }
		],
	  transitionDelay: 3,
	  animationSpeed: 800
	});	
});

function layer_popup(el){

	var $el = $(el);        //레이어의 id를 $el 변수에 저장
	var isDim = $el.prev().hasClass('dimBg');   //dimmed 레이어를 감지하기 위한 boolean 변수
	isDim ? $el.parent('.dim-layer').fadeIn() : $el.fadein();
	
	var $elWidth = $el.outerWidth(),
		$elHeight = $el.outerHeight(),
		docWidth = $(document).width(),
		docHeight = $(document).height();

	// 화면의 중앙에 레이어를 띄운다.
	if ($elHeight < docHeight || $elWidth < docWidth) {
		$el.css({
			marginTop: -$elHeight /2,
			marginLeft: -$elWidth/2
		})
	} else {
		$el.css({top: 0, left: 0});
	}

	$el.find('a.btn-layerClose, .closeBtn').click(function(){
		isDim ? $el.parent('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
		return false;
	});

	$('.dim-layer .dimBg').click(function(){
		$('.dim-layer').fadeOut();
		return false;
	});

};

function popUp(url, width, height){
 x = (screen.availWidth - width) / 2;
 y = (screen.availHeight - height) / 2;
 window.open(''+url+'', 'pop','width='+width+', height='+height+', left='+x+', top='+y);
}

/*
 * Simple jQuery plugin to synchronously load and then transition (fade-in/out) a list of images as full screen background-images on a web page.
 * Author: Matt Richards, http://github.com/mattyrichards
 * Licensed under the MIT license
 */
;(function( $, window, document, undefined ){

    var BackgroundTransition = function( elem, options ){
        this.elem = elem;
        this.$elem = $(elem);
        this.options = options;
        self = this;
    };

    BackgroundTransition.prototype = {
        defaults: {
            classNameBottomImage: "image-bottom",
            classNameTopImage: "image-top",
            idNameDownloadImage: "image-download",
            backgrounds: [],
            imageKey: 1,
            transitionDelay: 10,
            animationSpeed: 1000
        },

        init: function() {
            this.config = $.extend({}, this.defaults, this.options);
            if (this.config.backgrounds.length >= 2) {
                this.prepareMarkup();
                this.loadNext();
                return this;
            } else {
                console.warn('BackgroundTransition requires at least 2 background images.')
                return false;
            }
        },

        prepareMarkup: function() {
            var imageBottom = $("<div/>").addClass(this.config.classNameBottomImage + ' initial').css('background-image', 'url(' + this.config.backgrounds[0].src + ')');
            var imageTop = $("<div/>").addClass(this.config.classNameTopImage).css('display', 'none');
            $(this.elem)
                .prepend(imageBottom, imageTop)
                .css('background-image', 'none');
        },

        loadNext: function() {
            if (this.config.imageKey == this.config.backgrounds.length){
                this.config.imageKey = 0;
            }
            var deferred = $.Deferred();
            $('<img/>').attr('id', this.config.idNameDownloadImage).load(function() {
                deferred.resolve();
            }).attr('src', this.config.backgrounds[this.config.imageKey].src).prependTo('body .backgroundTransition');
            deferred.done(function() {
                setTimeout(self.replaceImage, (self.config.transitionDelay * 1000));
            });
        },

        replaceImage: function() {
            var nextSrc = $('#' + self.config.idNameDownloadImage);
            $('#' + self.config.idNameDownloadImage).remove();
            $('.' + self.config.classNameTopImage).css('background-image', 'url(' + nextSrc.attr('src') + ')');
            $('.' + self.config.classNameTopImage).fadeIn(self.config.animationSpeed, 'swing', function() {
               $('.' + self.config.classNameBottomImage).css('background-image', 'url(' + nextSrc.attr('src') + ')');
               $(this).hide();
               self.config.imageKey++;
               self.loadNext();
            });
        }
    }

    BackgroundTransition.defaults = BackgroundTransition.prototype.defaults;

    $.fn.backgroundTransition = function(options) {
        return this.each(function() {
            new BackgroundTransition(this, options).init();
        });
    };

})( jQuery, window , document );