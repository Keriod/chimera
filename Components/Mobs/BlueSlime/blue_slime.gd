extends Node2D

@export var speed = 100

func _ready():
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.animation = "idle"

func _process(delta):
	var velocity = Vector2.ZERO

func _on_area_2d_area_entered(area):
	$StateChart.send_event("player_spotted")


func _on_idle_state_entered():
	$AnimatedSprite2D.animation = "idle"

func _on_move_state_entered():
	$AnimatedSprite2D.animation = "move"


func _on_attack_state_entered():
	$AnimatedSprite2D.animation = "attack"


func _on_die_state_entered():
	$AnimatedSprite2D.animation = "die"


func _on_hurt_state_entered():
	$AnimatedSprite2D.animation = "hurt"
