extends Node2D


onready var timer = $Timer


func _ready():
	pass


func starte(d):
	timer.start(d)

func _on_Timer_timeout():
	print('sad')
