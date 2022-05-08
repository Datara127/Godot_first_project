extends Area2D


const HitEffect = preload("res://Scenes/Effects/HitEffect.tscn")
onready var timer = $Timer
var invincible = false setget set_invincible
signal invincibility_started
signal invincibility_ended


func set_invincible(value):
	invincible = value
	if invincible == true:
		print(invincible)
		emit_signal("invincibility_started")
	else:
		print(invincible)
		emit_signal("invincibility_ended")


func start_invincibility(duration):
	self.invincible = true
	timer.set_wait_time(duration)
	timer.start()


func create_hit_effect():
	var effectHit = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effectHit)
	effectHit.global_position = global_position


func _on_Timer_timeout():
	self.invincible = false


func _on_HurtBox_invincibility_ended():
	set_deferred("monitorable", true)


func _on_HurtBox_invincibility_started():
	set_deferred("Monitorable", false)
