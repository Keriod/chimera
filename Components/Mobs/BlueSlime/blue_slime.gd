extends Node2D

@export var speed = 100
var player = null

func _ready():
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.animation = "idle"

func _process(delta):
	if(player != null):
		var direction = global_position.direction_to(player.global_position);
		var velocity = direction * speed
		$AnimatedSprite2D.flip_h = true if velocity.x > 0 else false
		
		position += velocity * delta
	

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

func _on_area_2d_body_entered(body):
	$StateChart.send_event("player_spotted")
	player = body

func _on_area_2d_body_exited(body):
	$StateChart.send_event("player_lost")
	player = null

func _on_attack_area_body_entered(body):
	$StateChart.send_event("attack_zone_entered")
	


func _on_attack_area_body_exited(body):
	$StateChart.send_event("attack_zone_exited")
