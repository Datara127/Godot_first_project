extends KinematicBody2D

const EnemyDeathEffect = preload("res://Scenes/Effects/DeathEffect.tscn")
enum {
	IDLE,
	WANDER,
	CHASE
}
export var ACCELERATION = 300
export var MAX_SPEED = 80
export var FRICTION = 200
var state = IDLE
var knockback = Vector2.LEFT
var velocity = Vector2.ZERO

onready var stats = $EntityStats
onready var playerDetectedZone = $PlayerDetection
onready var enmySprite = $SmallShadow
onready var batSprite = $SmallShadow
onready var hurtBox = $HurtBox
onready var softCollision = $SoftCollision


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)

	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			
		WANDER:
			pass
			
		CHASE:
			var player = playerDetectedZone.player
			if player != null:
				var dir = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(dir * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
				batSprite.flip_h = velocity.x < 0
	
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)


func seek_player():
	if playerDetectedZone.can_see_player():
		state = CHASE


func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 120
	hurtBox.create_hit_effect()


func _on_EntityStats_no_health():
	queue_free()
	var enemyAnimDeath = EnemyDeathEffect.instance()
	get_parent().add_child(enemyAnimDeath)
	enemyAnimDeath.global_position = global_position
