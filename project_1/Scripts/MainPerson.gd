extends KinematicBody2D


signal hp_changed
enum State { ATTACK, MOVE}
onready var animSprite = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")
var speed = 100
var hp = 5
var state = State.MOVE
var sword_damage = 2
var velocity = Vector2.ZERO
var ACCELERATION = 500
var MAX_SPEED = 80
var FRICTION = 500

func _ready():
	call_deferred("change_hp", 0)


func _physics_process(delta):
	var move_direction = Vector2()
	move_direction.x = Input.get_action_strength("Move_right") - Input.get_action_strength("Move_left")
	move_direction.y = Input.get_action_strength("Move_down") - Input.get_action_strength("Move_up")
	move_direction = move_direction.normalized()
	
#	if Input.is_action_just_pressed("hit_player"):
#		state = State.ATTACK
	
	if state == State.MOVE:
		if move_direction != Vector2.ZERO:
			animTree.set("parameters/Idle/blend_position", move_direction)
			animTree.set("parameters/Run/blend_position", move_direction)
			animState.travel("Run")
			velocity = velocity.move_toward(move_direction * MAX_SPEED, ACCELERATION * delta)
		else:
			animState.travel("Idle")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	elif state == State.ATTACK:
		animSprite.play("hit_left")
	
	velocity = move_and_slide(velocity)


func sword_hit(enemy: Node2D):
	if enemy.is_in_group("Enemy"):
		hit_enemy_blue_slime(enemy)


func animation_attack_finish():
	state = State.MOVE

	
func enemy_contact(enemy: Node2D):
	if enemy.is_in_group("Enemy"):
		if enemy.is_in_group("slime"):
			take_damage(-1)
			hit_enemy_blue_slime(enemy)


func hit_enemy_blue_slime(enemy: Node2D):
	if enemy.has_method("taking_damage_from_a_player"):
		enemy.taking_damage_from_a_player(sword_damage)


func take_damage(damage: int):
	change_hp(damage)
	

func change_hp(diff: int):
	print(hp)
	hp += diff
	emit_signal("hp_changed", hp)	
