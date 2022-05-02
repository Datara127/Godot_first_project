extends KinematicBody2D


signal hp_changed
var speed = 100
onready var animSprite = $AnimationPlayer
var hp := 3


func _ready():
	call_deferred("change_hp", 0)


func _physics_process(delta):
	var move_direction = Vector2()
	if Input.is_action_pressed("Move_left"):
		move_direction.x -= speed
		animSprite.play("move_left")
	if Input.is_action_pressed("Move_right"):
		move_direction.x += speed
		animSprite.play("move_right")
	if Input.is_action_pressed("Move_up"):
		move_direction.y -= speed
	if Input.is_action_pressed("Move_down"):
		move_direction.y += speed
	if !Input.is_action_pressed("Move_left") and !Input.is_action_pressed("Move_right") and !Input.is_action_pressed("Move_up") and !Input.is_action_pressed("Move_down"):
		animSprite.play("idle")
		
	move_and_slide(move_direction, Vector2(0, 1))
	
	
func enemy_contact(enemy: Node2D):
	hit_enemy(enemy)


func hit_enemy(enemy: Node2D):
	if enemy.has_method("die"):
		enemy.die()


func take_damage():
	change_hp(-1)
	

func change_hp(diff: int):
	hp += diff
	emit_signal("hp_changed", hp)	
