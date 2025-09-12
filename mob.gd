extends CharacterBody3D

@export var base_min_speed = 8
@export var base_max_speed = 10
@export var speed_increase_per_point = 1

signal squashed

func squash():
	squashed.emit()
	queue_free()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func initialize(start_position, player_position, current_score = 0):
	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y(randf_range(-PI / 4, PI / 4))
	
	var bonus_speed = current_score * speed_increase_per_point
	var min_speed = bonus_speed + base_min_speed
	var max_speed = (bonus_speed * 2) + base_max_speed
	
	var random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	$AnimationPlayer.speed_scale = random_speed / min_speed


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()
