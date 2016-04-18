//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require turbolinks
//= require_tree .

ready = function(){
  $("#user_birthday").datepicker({
    format: 'dd/mm/yyyy'
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
