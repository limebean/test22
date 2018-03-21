ready = function() {
  setTimeout(function(){
    $('#teacher_profile_date_of_birth').datepicker({
        format: 'dd/mm/yyyy', "autoclose": true
    });

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
  }, 10);

  var form = $("#new_teacher_profile");
form.validate({
    errorPlacement: function errorPlacement(error, element) { element.before(error); }
});

$('#birth_date').datepicker({
    format: 'dd/mm/yyyy', "autoclose": true,
    endDate: '-13y',
});
$('#parent_profile_child_date_of_birth').datepicker({
  todayHighlight: true,
  format: 'dd/mm/yyyy', "autoclose": true,
});
date = new Date();
$('#parent_profile_child_date_of_birth').datepicker('setDate', date);
$('#parent_profile_start_of_care').datepicker({
  format: 'dd/mm/yyyy', "autoclose": true,
});
$('#parent_profile_end_of_care').datepicker({
  format: 'dd/mm/yyyy', "autoclose": true,
});
$('#enroll_start_date').datepicker({
    format: 'dd/mm/yyyy', "autoclose": true,
    endDate: '-13y',
});
$('#enroll_start_date1').datepicker({
    format: 'dd/mm/yyyy', "autoclose": true,
    endDate: '-13y',
});

form.children("div").steps({
    headerTag: "h3",
    bodyTag: "section",
    transitionEffect: "slideLeft",
    onStepChanging: function (event, currentIndex, newIndex)
    {
        form.validate().settings.ignore = ":disabled,:hidden";
        return form.valid();
    },
    onFinishing: function (event, currentIndex)
    {
        form.validate().settings.ignore = ":disabled";
        return form.valid();
    },
    onFinished: function (event, currentIndex)
    {
      form.submit();
    }
});

var stripeResponseHandler;

    jQuery(function($) {
      $('.make_payment').submit(function(event) {
        var $form;
        $form = $(this);
        $form.find('button').prop('disabled', true);
        Stripe.card.createToken($form, stripeResponseHandler);
        return false;
      });
    });

    stripeResponseHandler = function(status, response) {
      var $form, token;
      $form = $('.make_payment');
      if (response.error) {
        $form.find('.payment-errors').text(response.error.message);
        $form.find('button').prop('disabled', false);
      } else {
        token = response.id;
        $form.append($('<input type="hidden" name="stripeToken" />').val(token));
        $form.get(0).submit();
      }
    };
};

$(document).on('turbolinks:load', ready);
