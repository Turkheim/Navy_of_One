
extends Node3D

var trigger = false
var grip = false

@onready var animation_player = $Hand_Nails_low_L/AnimationPlayer


### Blend tree to use
#@export var hand_blend_tree : AnimationNodeBlendTree: set = set_hand_blend_tree
#
### Hand-open pose
#@export var open_pose : Animation : set = set_open_pose
#
### Hand animation tree
#var _animation_tree : AnimationTree
#
### Animation blend tree
#var _tree_root : AnimationNodeBlendTree
#
#
### Controller used for input/tracking
#var _controller : XRController3D
#
### Force grip value (< 0 for no force)
#var _force_grip := -1.0
#
### Force trigger value (< 0 for no force)
#var _force_trigger := -1.0
#
### Hand-closed pose
#@export var closed_pose : Animation : set = set_closed_pose
#
#@onready var animation_player = $Hand_low_L/AnimationPlayer
#
#@onready var animation_tree = $Hand_low_L/AnimationTree
#
#
## Called when the open pose is changed
#func set_open_pose(p_open_pose : Animation) -> void:
	#open_pose = p_open_pose
	##emit_changed()
#
#
## Called when the closed pose is changed
#func set_closed_pose(p_closed_pos : Animation) -> void:
	#closed_pose = p_closed_pos
	##emit_changed()
#
### Default hand pose
#@export var default_pose : XRToolsHandPoseSettings: set = set_default_pose
#
### Name of the Grip action in the OpenXR Action Map.
#@export var grip_action : String = "grip"
#
### Name of the Trigger action in the OpenXR Action Map.
#@export var trigger_action : String = "trigger"
#
### Hand animation player
#var _animation_player : AnimationPlayer
#
#
#func _ready() -> void:
	#
	#_animation_player = animation_player
	#_animation_tree = animation_tree
	#
	#_update_pose()
	#
#func _physics_process(_delta: float) -> void:
	#
		#
	#if _controller:
		#var grip : float = _controller.get_float(grip_action)
		#var trigger : float = _controller.get_float(trigger_action)
		#print(grip_action)
		#print(trigger_action)
		### Allow overriding of grip and trigger
		##if _force_grip >= 0.0: grip = _force_grip
		##if _force_trigger >= 0.0: trigger = _force_trigger
#
		#$AnimationTree.set("parameters/Grip/blend_amount", grip)
		#$AnimationTree.set("parameters/Trigger/blend_amount", trigger)
### Set the blend tree
#func set_hand_blend_tree(blend_tree : AnimationNodeBlendTree) -> void:
	#hand_blend_tree = blend_tree
	#if is_inside_tree():
		#_update_hand_blend_tree()
		#_update_pose()
#
### Set the default open-hand pose
#func set_default_pose(pose : XRToolsHandPoseSettings) -> void:
	#default_pose = pose
	#if is_inside_tree():
		#_update_pose()
		#
#func force_grip_trigger(grip : float = -1.0, trigger : float = -1.0) -> void:
	## Save the forced values
	#_force_grip = grip
	#_force_trigger = trigger
#
	## Update the animation if forcing to specific values
	#if grip >= 0.0: $AnimationTree.set("parameters/Grip/blend_amount", grip)
	#if trigger >= 0.0: $AnimationTree.set("parameters/Trigger/blend_amount", trigger)
#func _update_hand_blend_tree() -> void:
	## As we're going to make modifications to our animation tree, we need to do
	## a deep copy, simply setting resource local to scene does not seem to be enough
	#if _animation_tree and hand_blend_tree:
		#_tree_root = hand_blend_tree.duplicate(true)
		#_animation_tree.tree_root = _tree_root
		#
#
#func _update_pose() -> void:
	## Skip if no blend tree
	#if !_tree_root:
		#return
#
	## Select the pose settings
	#var pose_settings : XRToolsHandPoseSettings = default_pose
#
	## Get the open and closed pose animations
	#var open_pose : Animation = pose_settings.open_pose
	#var closed_pose : Animation = pose_settings.closed_pose
#
	## Apply the open hand pose in the player and blend tree
	#if open_pose:
		#var open_name = _animation_player.find_animation(open_pose)
		#if open_name == "":
			#open_name = "open_hand"
			#if _animation_player.has_animation(open_name):
				#_animation_player.remove_animation(open_name)
#
			#_animation_player.add_animation(open_name, open_pose)
#
		#var open_hand_obj : AnimationNodeAnimation = _tree_root.get_node("OpenHand")
		#if open_hand_obj:
			#open_hand_obj.animation = open_name
#
	## Apply the closed hand pose in the player and blend tree
	#if closed_pose:
		#var closed_name = _animation_player.find_animation(closed_pose)
		#if closed_name == "":
			#closed_name = "closed_hand"
			#if _animation_player.has_animation(closed_name):
				#_animation_player.remove_animation(closed_name)
#
			#_animation_player.add_animation(closed_name, closed_pose)
#
		#var closed_hand_obj : AnimationNodeAnimation = _tree_root.get_node("ClosedHand1")
		#if closed_hand_obj:
			#closed_hand_obj.animation = closed_name
#
		#closed_hand_obj = _tree_root.get_node("ClosedHand2")
		#if closed_hand_obj:
			#closed_hand_obj.animation = closed_name


func _on_xr_controller_left_button_pressed(name):

	if name == "trigger_click" :
		trigger = true

	elif name == "grip_click":
		grip = true

	update_pose()

func _on_xr_controller_left_button_released(name):
	
	if name == "trigger_click" :
		trigger = false

	elif name == "grip_click":
		grip = false
		
	update_pose()
	
func update_pose():
	if trigger == true and grip==true:
		print('fist')
		animation_player.play("Grip")
	elif trigger == false and grip==true:
		print("point")
		animation_player.play("Sign_Point")
		
	elif trigger == true and grip==false:
		print("pipiqq")
		animation_player.play("OK")
	else:
		print('palm')
		animation_player.play("Default pose")
