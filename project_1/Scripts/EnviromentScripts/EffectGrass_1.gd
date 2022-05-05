extends Node2D


onready var animSprite = $AnimatedSprite


func _ready():
	animSprite.play("AnimationGrass")


func _on_AnimatedSprite_animation_finished():
	queue_free()
