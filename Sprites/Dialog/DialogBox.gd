extends CanvasLayer

export(String, FILE, "*.json") var DialogFile
var dialogues = []
var current_dialogues_ID = 0
var is_dialogue_active = false

func _ready():
	$NinePatchRect.visible = false

func play():
#	if is_dialogue_active:
#		return
	
	dialogues = load_dialogues()
	
	is_dialogue_active = true
	$NinePatchRect.visible = true
	next_line()

func _input(event):
	if is_dialogue_active:
		return

	if event.is_action_pressed("game_interaction"):
		next_line()

func next_line():
	if current_dialogues_ID >= len(dialogues):
		current_dialogues_ID = 0
		is_dialogue_active = false
		$NinePatchRect.visible = false
		return

	$NinePatchRect/Name.text = dialogues[current_dialogues_ID]['name']
	$NinePatchRect/DialogText.text = dialogues[current_dialogues_ID]['text']
	current_dialogues_ID += 1
	
func load_dialogues():
	var Files = File.new()
	if Files.file_exists(DialogFile):
		Files.open(DialogFile, Files.READ)
		return parse_json(Files.get_as_text())

