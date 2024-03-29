extends Node2D

@onready var choice_button_scn=preload("res://widgets/ChoiceButton/ChoiceButton.tscn")

var choice_buttons:Array[Button]=[]
var is_dialogue_done=false

#func _ready():
	#add_choice("This is choice1")
	#add_choice("This is choice2")
	
func clear_dialogue_box():
	$VBoxContainer/Label.text=""
	for choice in choice_buttons:
		$VBoxContainer.remove_child(choice)
	choice_buttons=[]
	
func add_text(text:String):
	$VBoxContainer/Label.text=text
	
func add_choice(choice_text:String):
	var button_obj:ChoiceButton=choice_button_scn.instantiate()
	button_obj.choice_index=choice_buttons.size()
	button_obj.text=choice_text
	choice_buttons.push_back(button_obj)
	button_obj.choice_selected.connect(_on_choice_selected)
	$VBoxContainer.add_child(button_obj)
	
func _on_choice_selected(choice_index:int):
	#print(choice_index)
	if(!is_dialogue_done):
		($"../EzDialogue" as EzDialogue).next(choice_index)
		#is_dialogue_done=true
	else:
		is_dialogue_done=false
		($VBoxContainer/Label as Label).visible=false
		clear_dialogue_box()



