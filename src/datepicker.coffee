moment = require "moment/min/moment-with-locales.min"
ViewHelpers = require("./viewHelpers").ViewHelpers
Builders = require "./builders"

module.exports = class Datepicker extends ViewHelpers
  view: __dirname + "/../views"
  name: 'd-datepicker'


  init: (model) ->
    @lang = model.get("lang")
    #global.moment = moment
    @customFormat = model.get("format") || "L"
    @builders = new Builders(@lang, moment, @customFormat)
    if @lang?
      currentDate = moment().locale(@lang)
    @gotoMonthView currentDate

  create: (model, dom) ->
    self = @
    dom.on "click", (e) =>
      model.set "show", true if @parent.contains(e.target)
    dom.on "mousedown", (e) =>
      model.set "show", false unless @parent.contains(e.target)
    @parseDate()
    model.on "change", "active", (val, old, pass)->
      return if pass.inner
      self.parseDate()

  gotoMonthView: (date) ->
    @setCurrentDate date
    @monthView date

  monthView: (date) ->
    return unless date
    date = moment(date)
    weeks = @builders.buildMonthView(date)
    @model.set "weeks", weeks
    @model.set "view", "month"

  gotoYearView: (date) ->
    date = moment(date, "YYYY")
    @setCurrentDate date, "YYYY"
    @yearView date

  yearView: (date) ->
    months = @builders.buildYearView(date)
    @model.set "months", months
    @model.set "view", "year"

  nextYear: ->
    # get current month
    currentDate = moment(@getCurrentDate())

    # calculate previous year from date
    nextYearDate = currentDate.add(1, "years")
    @gotoYearView nextYearDate

  prevYear: ->
    # get current month
    currentDate = moment(@getCurrentDate())

    # calculate previous year from date
    prevYearDate = currentDate.subtract(1, "years")
    @gotoYearView prevYearDate

  gotoDecadeView: (date) ->
    date = moment(date)
    @setCurrentDate date
    @decadeView date

  decadeView: (date) ->
    years = @builders.buildDecadeView(date)
    @model.set "years", years
    @model.set "view", "decade"

  prevDecade: ->
    currentDate = moment(@getCurrentDate())
    prevDecadeDate = currentDate.subtract(10, "years")
    @gotoDecadeView prevDecadeDate

  nextDecade: ->
    currentDate = moment(@getCurrentDate())
    nextDecadeDate = currentDate.add(10, "years")
    @gotoDecadeView nextDecadeDate

  select: (selectedDate) ->
    date = moment(selectedDate.isoDate)
    selectedMonth = date.month()
    currentDate = moment(@getCurrentDate())
    currentMonth = currentDate.month()
    @gotoMonthView date  if selectedMonth isnt currentMonth
    @model.set "active", selectedDate.displayDate
    @model.set "show", false

  prevMonth: ->
    # get current month
    currentDate = moment(@getCurrentDate())

    # calculate previous month from date
    prevMonthDate = currentDate.subtract(1, "months")
    @gotoMonthView prevMonthDate

  nextMonth: ->
    # get current month
    currentDate = moment(@getCurrentDate())

    # calculate previous month from date
    nextMonthDate = currentDate.add(1, "months")
    @gotoMonthView nextMonthDate

  setCurrentDate: (currentDate) ->
    @model.set "currentDate", currentDate

  getCurrentDate: ->
    @model.get "currentDate"

  keyDown : (ev)->
    if ev.keyCode in [13, 9]
      date = moment @model.get("value")
      if date.isValid()
        @model.pass('inner': true).set("active", date.format("L"))
      if ev.keyCode is 9 # tab
        @model.set "show", false
      # try pedirct date

  parseDate : ()->
    active = @model.get "active"
    debugger
    if !active
      @model.set "value", null
    else
      parsed = moment(active, [
        "DD", "DD-MM", "DD-MM-YYYY", "DD-MM-YY", "YYYY-MM-DD"
      ])
      if parsed.isValid()
        @model.set "value", parsed.format()
      else
        @model.set "value", null
