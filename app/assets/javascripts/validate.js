ready = function() {
  $("#new_parent").validate({
    rules: {
    "user[name]": {required: true},
    "user[last_name]": {required: true},
    "user[email]": {required: true, email: true, remote: "/parents/check_email_availability"},
    "user[password]": {required: true, minlength: 6},
    },
    messages: {
      "user[email]": {required: "Email already exists. "}
    },
    onkeyup: false,
    submitHandler: function(form) {
      disable_and_submit('#new_parent', form, "false", locale);
    }
  });



};
$(document).on('turbolinks:load', ready);
