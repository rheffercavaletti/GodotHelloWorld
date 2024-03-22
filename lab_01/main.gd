extends Node2D

#why? packedscene? 
@export var Spirit: PackedScene


var label_title
func _ready():
	label_title = get_node("Label_Title")

func now():
	return Time.get_ticks_msec()

# Called every frame. 'delta' is the elapsed time since the previous frame.
const cooldown_msec = 50
var spirit_added_msec: int = 0
var spirits_count: int = 1
var phase: int = 0
var phase_last_tick: int = 0
func _process(delta):
	if mouse_button_down and now() - spirit_added_msec >= cooldown_msec:
		var new_spirit = Spirit.instantiate()
		new_spirit.position = get_viewport().get_mouse_position()
		add_child(new_spirit)
		spirit_added_msec = now()
		spirits_count += 1
		get_node("Label_Spirits_Count").text = str(spirits_count)
	
	if phase == 0 and spirits_count > 5: 
		phase = 1
		get_node("Label_Spirits_Count").visible = true
	
	elif phase == 1: 
		if eraser_title(): phase += 1
	elif phase == 2: 
		if write_title("SUN"): phase += 1
	elif phase == 3: 
		if eraser_title(): phase += 1
	elif phase == 4: 
		if write_title("sunk"): phase += 1
	elif phase == 5: 
		if eraser_title(): phase += 1
	elif phase == 6: 
		if write_title("Sunken. . ."): phase += 1
	elif phase == 7: 
		if eraser_title(): phase += 1
	elif phase == 8: 
		if write_title("S  u  n  k  e  n          "): phase += 1
	elif phase == 9: 
		if eraser_title(100): phase += 1
	elif phase == 10: 
		if write_title("Hello World", 250): phase += 1
	elif phase == 11: 
		if eraser_title(100): phase += 1
	elif phase == 12: 
		if write_title("Heffer's World", 100): phase = 1
		
func eraser_title(tick=500):
	if now() - phase_last_tick > tick:
		label_title.text = label_title.text.substr(0, label_title.text.length() -2)
		phase_last_tick = now()
	return label_title.text.length() < 2

func write_title(text, tick=500):
	if now() - phase_last_tick > tick:
		label_title.text = text.substr(0, label_title.text.length() +1)
		phase_last_tick = now()
	return label_title.text.length() == text.length()
		

var mouse_button_down: bool = false
func _input(event):
	if not event is InputEventMouseButton: return
	if event.button_index != 1: return
	mouse_button_down = event.is_pressed()
