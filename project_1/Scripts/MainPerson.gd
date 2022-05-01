extends KinematicBody2D


var speed = 100
onready var animSprite = $AnimatedSprite

func _physics_process(delta):
	var move_direction = Vector2()
	if Input.is_action_pressed("Move_left"):
		move_direction.x -= speed
		animSprite.play("Move")
		animSprite.flip_h = true
	if Input.is_action_pressed("Move_right"):
		move_direction.x += speed
		animSprite.play("Move")
		animSprite.flip_h = false
	if Input.is_action_pressed("Move_up"):
		move_direction.y -= speed
	if Input.is_action_pressed("Move_down"):
		move_direction.y += speed
	if !Input.is_action_pressed("Move_left") and !Input.is_action_pressed("Move_right") and !Input.is_action_pressed("Move_up") and !Input.is_action_pressed("Move_down"):
		animSprite.play("Idle")
		
	move_and_slide(move_direction, Vector2(0, 1))
	
	
func enemy_contact(enemy: Node2D):
	if enemy.has_method("die"):
		enemy.die()
		
	

	
