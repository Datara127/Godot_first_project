extends KinematicBody2D


signal hp_changed
var speed = 100
onready var animSprite = $AnimationPlayer
var hp := 15
enum State { ATTACK, MOVE}
enum Direct{ right, left, down, up}
var state = State.MOVE
var dir = Direct.left


func _ready():
	call_deferred("change_hp", 0)


func _physics_process(delta):
	var move_direction = Vector2()
	if Input.is_action_pressed("Move_left"):
		move_direction.x -= speed
		dir = Direct.left
	if Input.is_action_pressed("Move_right"):
		move_direction.x += speed
		dir = Direct.right
	if Input.is_action_pressed("Move_up"):
		move_direction.y -= speed
		dir = Direct.up
	if Input.is_action_pressed("Move_down"):
		move_direction.y += speed
		dir = Direct.down
	if Input.is_action_just_pressed("hit_player") and !Input.is_action_pressed("Move_down") and !Input.is_action_pressed("Move_up"):
		state = State.ATTACK

	move_and_slide(move_direction, Vector2(0, 1))
	animation_player(move_direction)

func animation_player(move_direction):
	if state == State.MOVE:
		if move_direction.x == 0 and move_direction.y == 0:
			animSprite.play("idle")
		if move_direction.x > 0:
			animSprite.play("move_right")
		if move_direction.x < 0:
			animSprite.play("move_left")
	elif state == State.ATTACK:
		if dir == Direct.left:
			animSprite.play("hit_left")
		elif dir == Direct.right:
			animSprite.play("hit_right")
	


func sword_hit(enemy: Node2D):
	if enemy.is_in_group("Enemy"):
		hit_enemy_blue_slime(enemy)


func animation_attack_finish():
	state = State.MOVE

	
func enemy_contact(enemy: Node2D):
	if enemy.is_in_group("Enemy"):
		take_damage(-2)
		hit_enemy_blue_slime(enemy)


func hit_enemy_blue_slime(enemy: Node2D):
	if enemy.has_method("die"):
		enemy.die()


func take_damage(damage: int):
	change_hp(damage)
	

func change_hp(diff: int):
	print(hp)
	hp += diff
	emit_signal("hp_changed", hp)	
