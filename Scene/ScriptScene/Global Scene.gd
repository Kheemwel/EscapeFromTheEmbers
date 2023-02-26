extends Node2D

var from_level

onready var player_interface = $UI
onready var healthbar = $UI/ProgressBar
onready var debuff = $UI/Debuff
onready var player_health = $"/root/GlobalScript".player_health
onready var burn_damage = $"/root/GlobalScript".burn_damage

func _ready():
# warning-ignore:return_value_discarded
	for i in range(player_interface.get_child_count()):
		player_interface.get_child(i).hide()
	GlobalScript.connect("burn_player", self, "_onBurnPlayer")
# warning-ignore:return_value_discarded
	GlobalScript.connect("inflict_burn", self, "_onInflictBurn")
	GlobalScript.connect("detect", self, "test")

func _process(_delta):
	if $"/root/GlobalScript".is_player_burned == true and player_health > 0:
		debuff.show()
	else:
		debuff.hide()
	
	if player_health == 0:
		get_tree().change_scene("res://Scene/Game Over.tscn")
		$"/root/GlobalScript".damagetimer.stop()
		$"/root/GlobalScript".burntimer.stop()
		$"/root/GlobalScript".is_player_burning = false
		$"/root/GlobalScript".is_player_burned = false
		healthbar.hide()
		healthbar.value = 100
		debuff.hide()
		player_health = 100

func _onBurnPlayer():
	firedamage()

func _onInflictBurn():
	firedamage()

func firedamage():
	if player_health > 0:
		player_health -= burn_damage
		healthbar.value = player_health
		print("Health: " + String(player_health))
		return true

