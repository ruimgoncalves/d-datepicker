Datepicker = require './lib/datepicker'

module.exports = (app) ->
  app.component Datepicker
  app.component DatepickerExample

class DatepickerExample
  view: __dirname + '/example'
  name: 'd-datepicker-example'
