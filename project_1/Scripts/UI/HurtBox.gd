extends Area2D


const HitEffect = preload("res://Scenes/Effects/HitEffect.tscn")
export(bool) var show_hit = true 


func _on_HurtBox_area_entered(area):
	if show_hit:
		var effectHit = HitEffect.instance()
		var main = get_tree().current_scene
		main.add_child(effectHit)
		effectHit.global_position = global_position
