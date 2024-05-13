extends Node2D

var implements = [Interface.Damageable]
var default_attack = Attack.new()

@export var speed = 100
var player = null
var body_to_attack = null

func _ready():
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.animation = "idle"

func _process(delta):
	if(player != null):
		var direction = global_position.direction_to(player.global_position);
		var velocity = direction * speed
		$AnimatedSprite2D.flip_h = true if velocity.x > 0 else false
		position += velocity * delta
	
	if body_to_attack != null:
		if "implements" in body_to_attack:
			for interface in body_to_attack.implements:
				if interface == Interface.Damageable:
					body_to_attack.take_damage(default_attack)
	

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
	body_to_attack = body
	
func _on_attack_area_body_exited(body):
	$StateChart.send_event("attack_zone_exited")
	body_to_attack = null


func take_damage(attack:Attack):
	pass
