d-datepicker
=====

Datepicker component for Derby.

<p align="center"><img src="https://raw.githubusercontent.com/icaliman/d-datepicker/gh-pages/images/datepicker-inline.png" alt="Screenshot of datepicker component"/></p>

Features:
* Datepicker tied to a standard form input field.
* Inline datepicker.
* Localized datepicker.


Please note that this project is inspired by [Bootstrap-datepicker](https://github.com/eternicode/bootstrap-datepicker), and makes use of a css-file from that project.

Format
=====

Dates set by datepicker will be in the format `YYYY-MM-DD` (2014-04-16).

TODO
=====

1. Use personalized formats for dates.

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

      <!-- localized datepicker -->
      <datepicker active="{{post.date}}" inline lang="fr"></datepicker>
      
Retrieve data
--------

    var pickedDate = model.get('post.date');
