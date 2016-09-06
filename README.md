# Grithin's Time

Additions to moment.js, and a `Time` utility

## Use
```coffee
Time = require('g_time')
Time.relative('-1 day') #< moment object, 1 day ago
Time.relative('-1 day', '-2 days') #< moment object, 3 days ago
Time.relative('+1 day') #< moment object, 1 day in the future
Time.relative('1 day ago') #< moment object, 1 day ago

# Current time as UTC date YYYY-MM-DD
Time.date()
# Current time as UTC datetime YYYY-MM-DD HH:II:SS
Time.datetime()


moment().to_date() #YYYY-MM-DD
moment().to_datetime() #YYYY-MM-DD HH:II:SS

Time.from_guess(mystery_input) # returns false or a moment instance
```