class_name ArtifactManager
extends RefCounted
@warning_ignore_start("unused_signal")

var artifact_array: Array[BaseArtifact]


signal on_player_shield_broken(player, source)

func _init():
	pass

func add_artifact(artifact: BaseArtifact):
	artifact_array.append(artifact)

func remove_artifact():
	pass
