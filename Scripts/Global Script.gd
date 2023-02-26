extends Node

# warning-ignore:unused_signal
signal burn_player()
# warning-ignore:unused_signal
signal inflict_burn()
signal detect()

var player_health = 100
var player_air = 100
var burn_damage = 1
var suffocation_damage = 1
var is_player_burning = false
var is_player_burned = false

var firedamage_delay = 0.5
var burning_damage_delay = 1
var inflict_burn_countdown = 3
var burn_debuff_duration = 5

onready var damagetimer = Timer.new()
onready var burntimer = Timer.new()
onready var inflictburncountdown = Timer.new()

func _ready():
	damagetimer.connect("timeout", self, "_on_DamageTimer_timeout")
	burntimer.connect("timeout", self, "_on_BurnTimer_timeout")
	inflictburncountdown.connect("timeout", self, "_on_InflictBurnCountdown_timeout")
	add_child(damagetimer)
	add_child(burntimer)
	add_child(inflictburncountdown)

func _on_Fire_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("burn_player")
		damagetimer.start(firedamage_delay)
		if is_player_burned == false:
			inflictburncountdown.start(1)

func _on_Fire_body_exited(_body):
	if damagetimer.is_stopped() == false:
		damagetimer.stop()
		inflictburncountdown.stop()
		burn_debuff_duration = 5
		burntimer.start(burning_damage_delay)
		is_player_burned = true

func _on_DamageTimer_timeout():
	emit_signal("burn_player")
	is_player_burning = true
	if is_player_burned == true:
		emit_signal("inflict_burn")


func _on_BurnTimer_timeout():
	emit_signal("inflict_burn")
	is_player_burned = true
	is_player_burning = true
	if damagetimer.is_stopped():
		burn_debuff_duration -= burning_damage_delay
	if burn_debuff_duration == 0:
		burn_debuff_duration = 5
		burntimer.stop()
		is_player_burned = false
		is_player_burning = false

func _on_InflictBurnCountdown_timeout():
	inflict_burn_countdown -= 1
	if inflict_burn_countdown == 0:
		inflict_burn_countdown = 3
		inflictburncountdown.stop()
		is_player_burned = true


