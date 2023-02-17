extends Spatial

onready var main = get_tree().current_scene
var Enemy = load('res://3D Space Shooter Assets/Blender Imports/enemy.tscn')
func spawn():
	var enemy = Enemy.instance()
	main.add_child(enemy)
	enemy.transform.origin = transform.origin + Vector3(rand_range(-12,12),rand_range(-3,10),0)


func _on_Timer_timeout():
	spawn()
