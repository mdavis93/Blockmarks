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
//= require jquery
//= require rails-ujs
//= require bootstrap
//= require_tree .
//= require_self


$(document).ready(function() {

  $(document).on('ajax:success', 'form.bookmark_form', function(event, data, status, xhr) {
    $(".log").text( "Triggered AjaxComplete Handler");
    console.log($(this) + " called ajax:success" );
  });

  $(document).on('ajax:error', 'form.bookmark_form', function(event, jqxhr, settings, thrownError){
      let html = '<h4 class="text-left">There are ' + event.detail[0].length + ' Errors:</h4><ul>';

      for (let msg in event.detail[0]) {
          html += '<li>' + event.detail[0][msg] + '</li>';
      }
      html += '</ul>';

    $("#error_explanation").html(html);
    console.log("\nError: " + event.detail[0]);
    $("#error_explanation").removeClass("bg-danger text-danger");
    $("#error_explanation").addClass("alert alert-danger");
  });
});
