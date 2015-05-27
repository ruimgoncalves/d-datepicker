#moment = require "moment/min/moment-with-langs.min"

module.exports = class Builders
  constructor: (@lang, @moment, @customFormat) ->

  buildYearView: (date) ->
    months = []
    month = @moment(date).locale(@lang).month(0)
    for i in [1..12]
      months.push
        abbr: month.format("MMM")
        date: month.format("YYYY-MM")
      month.add 1, "months"
    months

  buildDecadeView: (date) ->
    years = []
    date = @moment(date)
    currentYear = date.year()

    # how far into the decade are we, eg 1 year for 2011
    yearsIntoDecade = currentYear % 10

    # subract the number of years into the decade, and 1 more so for 2011 we want to start from 2009
    year = date.subtract(yearsIntoDecade + 1, "years")

    for i in [0..11]
      yearInDecade = i > 0 and i < 11
      years.push
        year: year.year()
        inDecade: yearInDecade
      year.add 1, "years"
    years

  buildMonthView: (date) ->

    date = @moment(date)
    datesFromPrevMonth = addExtraDaysFromPrevMonth.bind(@)(date.clone())
    datesInCurrentMonth = getDaysInCurrentMonth.bind(@)(date.clone())
    datesFromNextMonth = addExtraDaysFromNextMonth.bind(@)(date.clone())
    allDates = datesFromPrevMonth.concat(datesInCurrentMonth, datesFromNextMonth)
    weeks = []
    weeks.push allDates.splice(0, 7)  while allDates.length > 0
    weeks

# split all dates up
getDaysInCurrentMonth = (currentDate) ->
  dates = []

  # initially set date to first day of month
  date = currentDate.date(1)
  nrDaysInMonth = currentDate.daysInMonth()
  i = 1
  today = new Date

  while i <= nrDaysInMonth
    dates.push getDateObj(date, @customFormat, true, date.isSame(today, "day"))
    date.add 1, "days"
    i++
  dates

addExtraDaysFromPrevMonth = (currentDate) ->
  dates = []
  firstDateOfMonth = currentDate.clone().date(1)
  firstDayOfMonth = firstDateOfMonth.day()
  i = 0

  while i < firstDayOfMonth
    prevDay = firstDateOfMonth.subtract(1, "days")
    dates.unshift getDateObj(prevDay, @customFormat, false, false)
    i++
  dates

addExtraDaysFromNextMonth = (currentDate) ->
  dates = []
  daysInMonth = currentDate.daysInMonth()
  lastDastDayOfMonth = currentDate.date(daysInMonth)
  i = lastDastDayOfMonth.day()

  while i < 6
    nextDay = lastDastDayOfMonth.add(1,"days")
    dates.push getDateObj(nextDay, @customFormat, false, false)
    i++
  dates

getDateObj = (date, format, isCurrentMonth, isToday) ->
  date          : date.date()
  isoDate       : date.format()
  displayDate   : date.format(format)
  thisMonth     : isCurrentMonth
  isToday       : isToday