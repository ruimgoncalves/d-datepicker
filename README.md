d-datepicker
=====

Datepicker component for derby.js.

!["Screenshot of datepicker component"](https://raw.githubusercontent.com/NAndreasson/derby-datepicker/gh-pages/images/datepicker.png "Datepicker screenshot")

Please note that this project is inspired by [Bootstrap-datepicker](https://github.com/eternicode/bootstrap-datepicker), and makes use of a css-file from that project.

Format
=====
Dates set by datepicker will be in the format `YYYY-MM-DD` (2014-04-16). 


Example usage
=====

First of make sure to install d-datepicker through npm `npm install d-datepicker`.


Including
--------
    
    app.use(require('d-datepicker'));
        
In template
-------
   
    <Body:>
      <!-- datepicker tied to a standard form input field -->
      <datepicker active="{{post.date}}"></datepicker>

      <!-- inline datepicker -->
      <datepicker active="{{post.date}}" inline></datepicker>
      
Retrieve data
--------

    var pickedDate = model.get('post.date');
