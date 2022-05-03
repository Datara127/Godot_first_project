extends KinematicBody2D

onready var anim_sprite = $AnimatedSprite
onready var timer_death = $Timer
var hp = 4
var slime_speed = 50
var is_alife = true


func _ready():
	anim_sprite.play("Idle")


func _physics_process(delta):
	if is_alife:
		var move_direction = Vector2()
		
		move_direction.x += slime_speed
		
		move_and_slide(move_direction)
		


func taking_damage_from_a_player(damage: int):
	hp -= damage
	if hp <= 0:
		is_alife = false
		die()
	

	
func die():
	anim_sprite.play("die")
	$CollisionShape2D.set_deferred("disabled", true)
	timer_death.set_wait_time(3.0)
	timer_death.start()


func _on_Timer_timeout():
	queue_free()
