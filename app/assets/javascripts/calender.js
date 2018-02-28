ready = function() {
  setTimeout(function(){
    var timeslotCalendar = TimeslotCalendar.init($('#timeslot-cal'), "#{@current_user.try(:id)}");
    $('#clear').click(function() {
      timeslotCalendar.clear();
    })
  }, 500)

  $('#availability_form').submit(function () {
    var data = $("#timeslot-cal").fullCalendar('clientEvents');
    data = _.map(data, function (d) {
      return {
        week_day: d.start.isoWeekday(),
        hour_from: d.start.format('HH:mm:ss'),
        hour_to: d.end.format('HH:mm:ss')
      };
    });

    var input = $("<input>").attr({"type":"hidden", "name":"calander_events"}).val(JSON.stringify(data));
    $(this).append(input);
  });

};

$(document).on('turbolinks:load', ready);