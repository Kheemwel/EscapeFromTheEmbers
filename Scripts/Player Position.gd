extends YSort

onready var tilemap = $"Damaging Object"
onready var smallfires = preload("res://Scene/ObjectScenes/SmallFire.tscn")
onready var bigfires = preload("res://Scene/ObjectScenes/BigFire.tscn")

func _ready():
	if GlobalScene.from_level != null:
		get_node("Player").set_position(get_node(GlobalScene.from_level + " Position").position)
	
	if tilemap != null:
		for cellpos in tilemap.get_used_cells():
			var cell = tilemap.get_cellv(cellpos)
			if cell == 0:
				var small_fire_object = smallfires.instance()
				small_fire_object.position = tilemap.map_to_world(cellpos) * tilemap.scale
				add_child(small_fire_object)
				tilemap.set_cellv(cellpos, -1)
			
		for cellpos in tilemap.get_used_cells():
			var cell = tilemap.get_cellv(cellpos)
			if cell == 1:
				var big_fire_object = bigfires.instance()
				big_fire_object.position = tilemap.map_to_world(cellpos) * tilemap.scale
				add_child(big_fire_object)
				tilemap.set_cellv(cellpos, -1)

