extends KinematicBody



const MaxSpeed= 30
const Acceleration = 0.75
var InputVector =Vector3()
var Velo = Vector3()
var cooldown = 0
const COOLDOWN = 8
onready var guns = [$Gun1,$Gun2]
onready var main = get_tree().current_scene
var Bullet = load("res://Bullet.tscn")
func _physics_process(delta):
	InputVector.x= Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	InputVector.y= Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down") 
	InputVector= InputVector.normalized()
	Velo.x=move_toward(Velo.x,InputVector.x *MaxSpeed,Acceleration)
	Velo.y=move_toward(Velo.y,InputVector.y *MaxSpeed,Acceleration)
	rotation_degrees.z=Velo.x * -2
	rotation_degrees.x=Velo.y / 2
	rotation_degrees.y=Velo.x / 2
	move_and_slide(Velo)
	transform.origin.x= clamp(transform.origin.x,-12,12)
	transform.origin.y= clamp(transform.origin.y,-3,10)
	
	if Input.is_action_pressed("ui_accept") and cooldown <= 0:
		cooldown = COOLDOWN * delta
		for i in guns:
			var bullet = Bullet.instance()
			main.add_child(bullet)
			bullet.transform = i.global_transform
			bullet.velo = bullet.transform.basis.z * -600
			
	if cooldown > 0:
		cooldown -= delta
