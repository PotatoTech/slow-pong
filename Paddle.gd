extends KinematicBody2D

var score : int = 0
var misses : int = 0

var speed : int = 1000
var texture : Texture = preload("res://sprites/paddle.png")
var texture_alt : Texture = preload("res://sprites/paddle_alt.png")

var vel : Vector2 = Vector2()
var is_slow : bool = false
var is_special_on_cooldown : bool = false

onready var sprite : Sprite = $Sprite
onready var special_duration : Timer = $SpecialDuration
onready var special_cooldown : Timer = $SpecialCooldown

func _physics_process(delta):
	if misses >= 11:
		print("Game over")
		get_tree().reload_current_scene()
	if score >= 11:
		print("Victory")
		get_tree().reload_current_scene()
	
	vel.y = 0
	var x_pos = self.transform.origin.x
	
	if Input.is_action_pressed("move_up"):
		vel.y -= speed
	if Input.is_action_pressed("move_down"):
		vel.y += speed
	if is_slow:
		vel.y /= 2
	
	move_and_collide(vel * delta)
	self.transform.origin.x = x_pos
	
	if not is_slow and not is_special_on_cooldown and Input.is_action_just_pressed("special"):
		is_slow = true
		sprite.texture = texture_alt
		special_duration.start()

func _on_SpecialDuration_timeout():
	is_slow = false
	sprite.texture = texture
	
	is_special_on_cooldown = true
	special_cooldown.start()

func _on_SpecialCooldown_timeout():
	is_special_on_cooldown = false
