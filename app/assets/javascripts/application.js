// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.cookie
//= require_tree .

// Cosntants
pcMinWidth = 881;
spMaxWidth = 880;

$(function(){
  var $setElem = $('.switch'),
      pcName = '/assets/pc_',
      spName = '/assets/sp_',
      replaceWidth = pcMinWidth;
  
  $setElem.each(function(){
    var $this = $(this);
    function imgSize(){
      var windowWidth = parseInt($(window).width());
      if(windowWidth >= replaceWidth) {
      	$this.attr('src',$this.attr('src').replace(spName,pcName)).css({visibility:'visible'});
      } else if(windowWidth < replaceWidth) {
      	$this.attr('src',$this.attr('src').replace(pcName,spName)).css({visibility:'visible'});
      }
    }
    $(window).resize(function(){imgSize();});
    imgSize();
  });
});
