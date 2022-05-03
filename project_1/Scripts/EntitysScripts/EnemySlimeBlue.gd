extends KinematicBody2D

onready var anim_sprite = $AnimatedSprite
onready var timer_death = $Timer


func _ready():
	anim_sprite.play("Idle")


func _play_animation(delta):
	pass
	
	
func die():
	anim_sprite.play("die")
	$CollisionShape2D.set_deferred("disabled", true)
	timer_death.set_wait_time(3.0)
	timer_death.start()


func _on_Timer_timeout():
	queue_free()
