extends StaticBody3D

@onready var hit = $Hit
var Dead = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if  Dead == true:
		translate (Vector3.DOWN * delta * 10)

func _on_area_3d_body_entered(body):
	hit.play()

	Dead = true
func _on_hit_finished():
	queue_free()
