moment = require "moment/min/moment-with-locales.min"

exports.ViewHelpers = class ViewHelpers

  getMonth: (currentDate) ->
    moment(currentDate).locale(@lang).format "MMMM"

  getYear: (currentDate) ->
    moment(currentDate).format "YYYY"

  getDecadeRange: (currentDate) ->
    currentYear = moment(currentDate).year()
    yearInDecade = currentYear % 10
    firstYearInDecade = currentYear - yearInDecade
    lastYearInDecade = firstYearInDecade + 9
    firstYearInDecade + " - " + lastYearInDecade

  isSame: (value, test, stopAt) ->
    return false if !value? or !test?
    activeDate = moment(value)
    activeDate.isSame test, stopAt

  weekDays: ->
    days = []
    moment.locale @lang
    for i in [0..6]
      days.push moment.weekdaysMin(i)
    days