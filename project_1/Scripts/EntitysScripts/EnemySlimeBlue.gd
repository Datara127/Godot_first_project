extends KinematicBody2D

onready var anim_sprite = $AnimatedSprite
onready var timer_death = $Timer
onready var stats = $EntityStats
onready var hurtBox = $HurtBox
onready var collisionHitBox = $HItBox/CollisionHitBox



func _ready():
	anim_sprite.play("Idle")


func _physics_process(delta):
	pass


func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	print(stats.health)
	hurtBox.create_hit_effect()


func _on_EntityStats_no_health():
	anim_sprite.play("die")
	$CollisionShape2D.set_deferred("disabled", true)
	collisionHitBox.set_deferred("disabled", true)
	timer_death.set_wait_time(3.0)
	timer_death.start()
	


func _on_Timer_timeout():
	queue_free()
