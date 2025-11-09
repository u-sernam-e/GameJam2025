extends Control

var text_1 : Array = [" So you’re the new hire, eh? Welcome to Dungeon Inspectors Inc.", 
"Your task will be to guide new adventurers through dungeons… and make me more money as well, I need it.", 
"I recently went into debt after buying some shoddy potions from a witch… never trust someone on a broom!",  
"Anyways, you will explore and inspect the different aspects of dungeons to see what makes them tick.", 
"You will then chart a path for adventurers who pay for our service so they don’t die on their journey.", 
"Many people like the idea of adventure but few actually want to put their life on the line,", 
"so that’s where we come in to provide them with a service to adventure with ease.", 
"Good luck on your first client!",
"Hello, I’m brand new to the adventuring lifestyle,", 
"so I’m gonna need some guidance in how to properly explore this dungeon, thanks!", 
]

var text_2 = ["Great job, you’re a natural! I still need a lot more money though, I need to pay for my horse insurance.", 
"I’m gonna give you a client who wants to go to a more demanding dungeon than the last,", 
"but they are willing to pay way more, so get going!
", 
"Hey there, you’re the inspector, huh?", 
"Well can you make this quick?", 
"I need to get to a meeting with my friend and really don’t need to waste any time exploring this place,", 
"so hopefully you can speed up that process a bit.", 
"I’m ok with a bit of exploring, but if you lead me to my death I’ll sue you!
"]

var text_3 = ["Great job again! You really have been a great employee… but I’m still gonna need some more money.", 
"I actually paid everything off; I just need more because capitalism.", 
"This next dungeon is the hardest yet, have fun!",
"Good day to you, inspector.", 
"I’m gonna need to speed through this dungeon because I need to continue running away from a meeting with my old friend,", 
"I really don’t want to talk to him. What’s that? You saw him? Eh, must’ve been someone else.", 
"Anyways I hope you can balance giving me the proper dungeon-crawling experience whilst also keeping me safe.
"]

var text_4 = [" I’m impressed, that was quite a hard dungeon! Well… for this next client I have a very special request. Listen,", 
"our next client is an ex-employee of this company, and let’s just say we didn’t leave on the best terms.", 
"I’d prefer if my secret business practices remained… secret. So do me a favor and…", 
"eliminate the problem… alright?", 
"I’ll give you a bonus! Now get out there!
", "Hey there, thanks so much for doing this! I’ve been on the road for 2 years and really want to get back to my kids.", 
"My village is only a few days away and I want to make sure I stay safe on this tail end of my journey.", 
"I can’t wait to get home!
"]

var text_5 = ["Thank you… lets never speak of this again. Just sign this non-disclosure agreement real quick…", 
"You have been a wonderful employee. Unfortunately due to the coin economy the company is forced to do some layoffs, so you are fired.", 
"I will take a pay increase though, as I deserve it and need to pay for my 2nd castle.
"]

var text_alt = ["You really don’t like listening to orders, do you? You are fired. Goodbye. I can find someone better.
"]

@onready var textbox = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/RichTextLabel
@onready var text_container = $TextureRect
@onready var boss = $Boss
@onready var adventurer = $Adventurer
@export var scene : int
@export var char_switch : int = 1

var index : int = 0
var max_string : int = 1
var is_tween : bool = true
var num : int = 0 

func _ready():
	hide_box()
	advance_text()

func hide_box():
	textbox.text = ""
	text_container.hide()

func show_box():
	text_container.show()

func tween_text(next_text):
	if index == 0:
		boss.visible = true
		adventurer.visible = false
	if index == char_switch:
		boss.visible = false
		adventurer.visible = true
	
	var tween = create_tween()
	
	show_box()
	tween.tween_property(textbox, "text", next_text, 3).set_ease(Tween.EASE_IN)
	textbox.text = ""
	await get_tree().create_timer(3).timeout
	is_tween = false
	

func advance_text():
	var next_text : String
	is_tween = true
	if index >= max_string:
		index = 0
		hide_box()
		set_level()
		return
	if scene == 1:
		max_string = text_1.size()
		next_text = text_1[index]
		num = 1
	if scene == 2:
		max_string = text_2.size()
		next_text = text_2[index]
		num = 2
	if scene == 3:
		max_string =  text_3.size()
		next_text = text_3[index]
		num = 3
	if scene == 4:
		max_string =  text_4.size()
		next_text = text_4[index]
		num = 4
	if scene == 5:
		max_string =  text_5.size() 
		next_text = text_5[index]
	if scene == 6:
		max_string =  text_alt.size() 
		next_text = text_alt[index]
	tween_text(next_text)
	

func _input(event):
	if event.is_action_pressed("ui_accept") && is_tween == false: 
		index += 1
		advance_text()

func set_level():
	var scene = "level_" + str(num)
	var path = "res://Scenes/FinalLevels/" + scene + ".tscn"
	get_tree().change_scene_to_file(path)
	pass
