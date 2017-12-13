// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
  $.rails.allowAction = function(link) {
    if (!link.attr('data-confirm')) {
      return true;
    }
    $.rails.showConfirmDialog(link);
    return false;
  };
  $.rails.confirmed = function(link) {
    link.removeAttr('data-confirm');
    return link.trigger('click.rails');
  };
  return $.rails.showConfirmDialog = function(link) {
    var html, message;
    message = link.attr('data-confirm');
    html = `<div class="modal fade" id="confirmationDialog">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <a class="close" data-dismiss="modal">×</a>
                    <h4>
                      <i class="glyphicon glyphicon-trash"></i>
                      ${message}
                    </h4>
                  </div>
                  <div class="modal-footer">
                    <a data-dismiss="modal" class="btn">Cancel</a>
                    <a data-dismiss="modal" class="btn btn-danger confirm">Ok</a>
                  </div>
                </div>
              </div>
            </div>`;
    $(html).modal('show');
    return $('#confirmationDialog .confirm').on('click', function() {
      return $.rails.confirmed(link);
    });
  };
});
