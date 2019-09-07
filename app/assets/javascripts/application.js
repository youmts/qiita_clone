// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require select2
//= require c3
//= require d3
//= require_tree .

$(document).on('turbolinks:load', function() {
  $('.js-tags-select').select2({
    width: '100%',
    allowClear: true,
    tags: true,
    placeholder: "プログラミング技術に関連するタグをスペース区切りで入力",
  });

  if($('.js-tags-chart').length) {
    c3.generate({
      bindto: '.js-tags-chart',
      size: {
        height: 200,
        width: 200,
      },
      data: {
        columns: gon.tags_count,
        type: 'pie',
      },
    });
  }
});
