extends KinematicBody2D


var knockback = Vector2.LEFT
onready var stats = $Stats

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)


func _on_HurtBox_area_entered(area):
	stats.hearth -= 1
	if stats.hearth <= 0:
		queue_free()
	knockback = area.knockback_vector * 120
