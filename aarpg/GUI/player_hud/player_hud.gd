extends CanvasLayer


var hearts : Array[HeartGUI] = []


func _ready():
	# Fill Array with the hearts
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append(child)
			child.visible = false # Disable hearts
	pass 


## Update Hearts based on Max HP
func update_hp(_hp : int, _max_hp : int) -> void:
	update_max_hp(_max_hp)
	for i in _max_hp:
		update_heart(i, _hp)
		pass
	pass


func update_heart(_index : int, _hp : int) -> void:
	var _value : int = clampi(_hp - _index * 2, 0, 2)
	hearts[_index].value = _value
	pass


## Turn Hearts on or off based on Max HP
func update_max_hp(_max_hp : int) -> void:
	var _heart_count : int = roundi(_max_hp * 0.5)
	for i in hearts.size():
		# Make hearts visible if its inside Max HP
		if i < _heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
	pass
