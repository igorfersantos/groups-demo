extends Node2D

func _ready():
	$CanvasLayer/HBoxContainer/Button.pressed.connect(group1_pressed)
	$CanvasLayer/HBoxContainer/Button2.pressed.connect(group2_pressed)
	$CanvasLayer/HBoxContainer/Button3.pressed.connect(reset_colors)
	
	for option_button_index in range($%GodotImagesOptions.get_child_count()):
		var option_button = $%GodotImagesOptions.get_child(option_button_index)
		option_button.item_selected.connect(
			on_group_changed.bind(option_button_index)
		)
	
	for image_index in range($%GodotImages.get_child_count()):
		var image_group = $%GodotImages.get_child(image_index).get_groups()[0]
		if image_group == "group_1":
			$%GodotImagesOptions.get_child(image_index).selected = 1
		elif image_group == "group_2":
			$%GodotImagesOptions.get_child(image_index).selected = 2

func on_group_changed(new_group_index, image_index):
	var godot_image = $%GodotImages.get_child(image_index)
	var option_button = $%GodotImagesOptions.get_child(image_index)
	var current_group = &""
	if godot_image.get_groups().size() > 0:
		current_group = godot_image.get_groups()[0]
		
	godot_image.remove_from_group(current_group)
	
	if new_group_index > 0:
		var new_group_string = "group_%s"
		var group_string = new_group_string % [new_group_index]
		godot_image.add_to_group(group_string)
		print("Image %s changed to group \"%s\"" % [image_index, group_string])
	else:
		print("Image %s do not participate in any groups" % [image_index])
	
func group1_pressed():
	var sprites_group1 = get_tree().get_nodes_in_group("group_1") as Array[Sprite2D]
	
	for sprite in sprites_group1:
		sprite.modulate = Color(Color.RED)

func group2_pressed():
	var sprites_group2 = get_tree().get_nodes_in_group("group_2") as Array[Sprite2D]
	
	for sprite in sprites_group2:
		sprite.modulate = Color(Color.BLUE)

func reset_colors():
	var sprites_group1 = get_tree().get_nodes_in_group("group_1") as Array[Sprite2D]
	var sprites_grupo2 = get_tree().get_nodes_in_group("group_2") as Array[Sprite2D]
	
	for sprite in sprites_group1:
		sprite.modulate = Color(Color.WHITE)
	
	for sprite in sprites_grupo2:
		sprite.modulate = Color(Color.WHITE)
		

