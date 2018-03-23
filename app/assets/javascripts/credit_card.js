ready = function() {
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