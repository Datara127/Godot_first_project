extends KinematicBody2D

onready var anim_sprite = $AnimatedSprite


func _ready():
	anim_sprite.play("Idle")


func _play_animation(delta):
	pass
	
	
func die():
	anim_sprite.play("die")
