extends Node2D

var Ball = preload("res://Ball.tscn")

func _ready():
	randomize()

func _physics_process(delta):
	pass

func _on_SummonBall_timeout():
	var ball = Ball.instance()
	ball.transform.origin.x = 1024
	ball.transform.origin.y = randf() * 500 + 50
	self.add_child(ball)
