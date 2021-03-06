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
//= require jquery.pjax
//= require highcharts
//= require addtohomescreen
//= require_tree .
//= require bootstrap

// Cosntants
pcMinWidth = 881;
spMaxWidth = pcMinWidth - 1;
splMinWidth = spMaxWidth;
splMinWidth = 401;
spsMaxWidth = splMinWidth - 1;
pcShowPadding = 50;

function isPC() {
  return (parseInt($(window).width()) > spMaxWidth);
}

function isSP() {
  return (($(window).width()) <= spMaxWidth);
}

function isSPL() {
  return (splMinWidth <= ($(window).width())) && (($(window).width()) <= splMaxWidth);
}

function isSPS() {
  return (($(window).width()) <= spsMaxWidth);
}

$(document).on("click", "a", function(e) {
  if ($(this).attr('target') == '_blank') return;
  // Do nothing if another ajax is hooked
  if ($(this).hasClass('ajax')) return;
  if ($(this).hasClass('ajax-in-pc') && isPC())  return;
  if ($(this).hasClass('ajax-in-sp') && isSP()) return;

  // Do nothing in page link
  if ($(this).attr("href").match(/^#/)) return;

  e.preventDefault();
  $.pjax({
    url: $(this).attr("href"),
    container: "#pjax-container",
    fragment: "#pjax-container",
    timeout: 1000
  });
});

$(function(){
  if (window.navigator.standalone) {
    $("#browsing-nav-in-ios-app").show();
  }
});
