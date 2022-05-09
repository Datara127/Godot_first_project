extends KinematicBody2D


enum State { ATTACK, MOVE, ROLL}

onready var animSprite = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")
onready var swordHitBox = $HitBoxPivot/SwordHItBox
onready var hurtBox = $HurtBox
onready var time = $Node2D

var state = State.MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var ACCELERATION = 500
var MAX_SPEED = 80
var FRICTION = 500
var stats = EntityStats

func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free")
	animTree.active = true
	swordHitBox.knockback_vector = roll_vector


func _physics_process(delta):
	match state:
		State.MOVE:
			move_state(delta)

		State.ATTACK:
			attack_state()
			
		State.ROLL:
			roll_state(delta)
	

func move_state(delta):
	var move_direction = Vector2()
	move_direction.x = Input.get_action_strength("Move_right") - Input.get_action_strength("Move_left")
	move_direction.y = Input.get_action_strength("Move_down") - Input.get_action_strength("Move_up")
	move_direction = move_direction.normalized()
	swordHitBox.knockback_vector = roll_vector
	
	if Input.is_action_just_pressed("hit_player"):
		state = State.ATTACK
	if Input.is_action_just_pressed("roll_space"):
		time.starte(2)
		state = State.ROLL
	
	if state == State.MOVE:
		if move_direction != Vector2.ZERO:
			roll_vector = move_direction
			roll_vector = move_direction
			animTree.set("parameters/Idle/blend_position", move_direction)
			animTree.set("parameters/Run/blend_position", move_direction)
			animTree.set("parameters/Attack/blend_position", move_direction)
			animTree.set("parameters/Roll/blend_position", move_direction)
			animState.travel("Run")
			velocity = velocity.move_toward(move_direction * MAX_SPEED, ACCELERATION * delta)
		else:
			animState.travel("Idle")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()


func move():
	velocity = move_and_slide(velocity)


func attack_state():
	animState.travel("Attack")
	

func roll_state(delta):
	velocity = roll_vector * MAX_SPEED * 1.25
	animState.travel("Roll")
	move()


func animation_attack_finish():
	state = State.MOVE

func animation_roll_finish():
	state = State.MOVE


func _on_HurtBox_area_entered(area):
	stats.health -= 1
	hurtBox.start_invincibility(1.5)
	hurtBox.create_hit_effect()
	
