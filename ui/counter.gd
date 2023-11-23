extends Control


# this refers to the timer node with the variable name timer
@onready var timer: Timer = $Timer

# this refers to the label node with the variable name set to timer_passed
# not to be confused with timePassed
@onready var timer_passed: Label = $CenterContainer/HFlowContainer/timer

# timePassed is the current amount of seconds passed
var timePassed = 0
# minutesPassed is the current amount of minutes passed
var minutesPassed = 0

# hoursPassed is the current amount of hours passed
var hoursPassed = 0

# episode start is an variable to check if the episode is still running or not
# if the start episode button has been pressed and the stop episode button has
# not been pressed then this will always be true if not this will be false
var episodeStarted = false

# only emits when the startEpisode button is pressed
func _on_start_episode_pressed() -> void:
	
	# starts the timer
	timer.start()
	
	# sets the episodeStarted state to true
	episodeStarted = true
	
# only emits when the stopEpisode button is pressed
func _on_stop_episode_pressed() -> void:
	
	# stops the timer from running
	timer.stop()
	
	# sets the seconds passed to 0
	timePassed = 0
	
	# sets the minutes passed to 0	
	minutesPassed = 0
	
	# set the episodeStarted state to false
	episodeStarted = false
	
func _on_timer_timeout() -> void:
	
	# checks if the time passed (seconds) is 59 then sets minutes passed to +1
	# if its not 59 it will pass
	if timePassed == 59:
		timePassed = 0
		minutesPassed += 1
	
	if minutesPassed == 59:
		minutesPassed = 0
		timePassed = 0
		hoursPassed += 1
		
	# increments the time passed (seconds) by 1
	timePassed += 1
	
	# set the display text to the minutes and seconds passed
	# example 1:2:58 - 2 being the minutes and 58 being the seconds 1 being hours passed
	if hoursPassed != 0:
		timer_passed.set_text(str(hoursPassed)+":"+str(minutesPassed)+ ":" + str(timePassed))
		
	# example 2:58 - 2 being the minutes passed and 58 being the seconds
	elif hoursPassed == 0:
		timer_passed.set_text(str(minutesPassed)+ ":" + str(timePassed))
		
	
	# if the episodeStarted is still true then we repeate the timer again
	# the default value of the timer is set to be 1 second so this will run every second
	if episodeStarted == true:
		timer.start()
