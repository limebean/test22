TimeslotCalendar = (function() {
  "use strict"

  var api = {};

  var calendar = null;

  /**
   * $container is the jQuery element object which the calendar will be rendered in
   */
  api.init = function($container) {
    calendar = $container.fullCalendar({
      header: {
        // left:   'prev,next today',
        left:   '',
        center: '',
        right: ''
      },
      date: moment(),
      defaultView: 'agendaWeek',
      slotLabelFormat:"HH:mm",
      firstDay: 1,
      timeFormat: 'HH:mm',
      minTime: "00:00:00",
      maxTime: "24:00:00",
      slotDuration: "00:60:00",
      allDaySlot: false,

      selectable: true,
      selectHelper: true,

      eventOverlap: false,
      slotEventOverlap: false,

      editable: true,
      columnFormat: {
        week: 'ddd'
      },
      dayNamesShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      select: selectFn,
      events: eventsFn
    });
    return this;
  };

  api.clear = function () {
    calendar.fullCalendar('removeEvents', function () {
      return true;
    });
  }

  // api.save = function() {
  //     // Send getData() to server and save in database there
  // }

  api.getData =  function getData() {
    var data = calendar.fullCalendar('clientEvents');
    data = _.map(data, function (d) {
      return {
        week_day: d.start.isoWeekday(),
        hour_from: d.start.format('HH:mm:ss'),
        hour_to: d.end.format('HH:mm:ss')
      };
    });
    return data;
  }

  return api;

  function selectFn(start, end, ev) {
    var overlapping = false;
    var arr = calendar.fullCalendar('clientEvents');
    var i;
    for (i in arr) {
      if (!(arr[i].start.toDate() >= end.toDate() || arr[i].end.toDate() <= start.toDate())) {
        overlapping = true;
        break;
      }
    }

    if (end.isAfter(start, 'day') || overlapping || !end.isAfter(start.clone().add(1, 'hour').subtract(1, 'second'))) {
      calendar.fullCalendar('unselect');
      return;
    }

    var eventData = {
      start: start,
      end: end
    };
    calendar.fullCalendar('renderEvent', eventData, true);
    calendar.fullCalendar('unselect');

    //RS.set(this.props.storePrefix + '.timeslotPrefs', getData());
  }

  function eventsFn(start, end, timezone, cb) {
    // Get current data from server, NOTE: getTimeslots doesn't exist
    $.get("/teachers/get_availability", function(response) {
      cb(
        _.map(response, function(e) {

          if(e.day_of_week == 0)
          {
            e.day_of_week = e.day_of_week + 7
          }
          var weekday = moment().day(e.day_of_week);
          weekday = weekday.format('YYYY-MM-DD');
          return {
            title: 'Available',
            start: weekday + ' ' +  e.start_hour,
            end: weekday + ' ' + e.end_hour,
          }
        })
      );
    });
  }
}());