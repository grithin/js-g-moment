`global= (typeof(global) != 'undefined' && global)  || (typeof(window) != 'undefined' && window) || this`
_ = global.lodash || global._ || require('lodash')
moment = global.moment || require('moment')

moment.DATE = 'YYYY-MM-DD'
moment.DATETIME = 'YYYY-MM-DD HH:mm:ss'
moment::to_date = ()->
	@format(moment.DATE)
moment::to_datetime = ()->
	@format(moment.DATETIME)

g_time = new ()->
	@date = ()-> moment.utc().to_date()
	@datetime = ()-> moment.utc().to_datetime()

	@numbers =
		'zero' : 0,
		'one' : 1,
		'two' : 2,
		'three' : 3,
		'four' : 4,
		'five' : 5,
		'six' : 6,
		'seven' : 7,
		'eight' : 8,
		'nine' : 9,
		'ten' : 10,
		'eleven' : 11,
		'twelve' : 12,
		'thirteen' : 13,
		'fourteen' : 14,
		'fifteen' : 15,
		'sixteen' : 16,
		'seventeen' : 17,
		'eighteen' : 18,
		'nineteen' : 19,
		'twenty' : 20,
		'thirty' : 30,
		'forty' : 40,
		'fifty' : 50,
		'sixty' : 60,
		'seventy' : 70,
		'eighty' : 80,
		'ninety' : 90,
		'hundred' : 100,
		'thousend' : 1000,
		'million' : 1000000

	@units =
		'millisecond' : 1,
		'ms' : 1,
		'second' : 1000,
		'sec' : 1000,
		's' : 1000,
		'minute' : 60000,
		'min' : 60000,
		'm' : 60000,
		'hour' : 3600000,
		'hr' : 3600000,
		'h' : 3600000,
		'day' : 86400000,
		'd' : 86400000,
		'week' : 604800000,
		'w' : 604800000,
		'month' : 2592000000,
		'quarter' : 7776000000,
		'year' : 31536000000,
		'y' : 31536000000,
		'decade' : 315360000000

	# pluralise
	for k, unit of @units
		if k.length > 1
			@units[k+'s'] = unit

	# "one minute ago"
	# "-1 minute", '+1 minute'
	@relative = (time, now)->
		if now
			now = @guess(now).time
		else
			now = moment()

		# not a string, pass to moment
		if typeof(time) != typeof('')
			return moment(time)

		time = _.trim(time).toLowerCase()

		multiplier = 1
		if ['-','+'].indexOf(time[0]) != -1 # starts with "+" or "-"
			if time[0] == '-'
				multiplier = -1
			time = _.trim(time.substr(1))
		else if time[-3..] == 'ago' # ends with "ago"
			multiplier = -1
			time = _.trim(time[...-3])
		else # not expected input, pass to moment
			return moment(time)

		# replace textual numbers
		time = @replace_text_number(time)

		time = time.replace(/(\s+and\s+)|(\s+&\s+)|\s+,\s+/, ',') # converge splitters
		parts = time.split(',')

		offset = 0
		for part in parts
			subparts = part.split(/\s+/)
			unit = subparts.pop()
			amount = parseFloat(subparts.join(''))
			if @units[unit]
				offset += multiplier * @units[unit] * amount
			else
				throw new Error('Unit not found in '+time)

		return moment(parseInt(now.format('x')) + offset)

	@unix = (date)->
		if date
			return parseInt(moment.utc(date).local().format('X'))
		else
			return parseInt(moment().format('X'))

	###
	Ex
	if @isDst(date)
		p 'it is dst time'
	###
	@isDst = (date)->
		date = date || new Date()
		return date.getTimezoneOffset() < @stdTimezoneOffset(date)

	@stdTimezoneOffset = (date)->
		date = date || new Date()
		jan = new Date(date.getFullYear(), 0, 1)
		jul = new Date(date.getFullYear(), 6, 1)
		return Math.max(jan.getTimezoneOffset(), jul.getTimezoneOffset()); # dst always back one hour in compaarison

	@start_of_day = (date)->
		moment(moment(date).format('YYYY-MM-DD')+' 00:00:00')
	# get the clock for some Date by offset in seconds from day start
	@date_by_clock = (seconds, date)->
		moment.unix(parseInt(@start_of_day(date).format('X')) + parseInt(seconds)).format('YYYY-MM-DD HH:mm:ss')

	# get a string representing the clock for today and turn it into a Date
	@seconds_of_today = (clock)->
		match = clock.match(/^\s*([0-9]{1,2})(:([0-9]{1,2}))\s*(am|pm)\s*$/i)
		if match
			hours = parseInt match[1]
			minutes = parseInt match[3]
			if match[4].toLowerCase() == 'pm'
				if hours != 12
					hours += 12
			else
				if hours == 12
					hours = 0
			return hours * 3600 + minutes * 60
		return false

	@unix = ()->
		parseInt(moment().format('X'))
	@replace_text_number = (string)->
		# replace textual numbers
		for textual, number of @numbers
			string = string.replace(textual, number)
		return string

	# guess the time from a string
	@from_guess = (string)->
		try
			guess = @guess(string)
			if guess
				return guess.time
		catch e

		return false
	# make a guess about the time.
	#@NOTE	Should not be used to determine if it is a time
	@guess = (string)->
		if string == 'now' || !string || string == ''
			return time: moment(), type: 'now'
		if parseInt(string)+'' == string #unix time
			return time: moment.unix(parseInt(string)), type:'unix'
		if string instanceof Date || string instanceof moment
			return time: moment(string), type: 'Date'
		if string.match(/^[0-9]{4}\-[0-9]{2}\-[0-9]{2}( [0-9]{2}:[0-9]{2}:[0-9]{2})?$/)
			return time: moment(string), type: 'date'
		seconds = @seconds_of_today(string)
		if seconds != false
			return time: @date_by_clock(seconds), type: 'clock'
		string = @replace_text_number(string)
		if string.match(/^\s*([-+])\s*[\-0-9]/) || string.match(/ago\s*$/i)
			return time: @relative(string), type: 'relative'

	@





_.bindSelf(g_time)


factory = ()-> g_time
if typeof define == 'function' && define.amd
	define([], factory)
else if typeof exports == 'object'
	module.exports = factory()
else
	this.returnExports = factory()
	if !this.Time
		this.Time = this.returnExports