ready = function() {
  $("#apartment").css('display', 'none');
  $("#house").css('display', 'none');
  $('#teacher_profile_apartment').on('click', function () {
    if (this.checked) {
      $("#apartment").css('display', 'block');
    }
    else{
      $("#apartment").css('display', 'none');
    }

  });

  $('#teacher_profile_house').on('click', function () {
    if (this.checked) {
      $("#house").css('display', 'block');
    }
    else{
      $("#house").css('display', 'none');
    }

  });
};

$(document).on('turbolinks:load', ready);
