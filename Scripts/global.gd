extends Node

# Singleton pattern used here to store persistent data 
# between scenes to set increasing level difficulty 
var steps
var level
var artifacts
var timer
var enemies

func _ready():
	set_values()

func set_values():
	steps = 40
	level = 14
	artifacts = 20
	timer = 400

func set_steps(newSteps):
	steps = newSteps

func set_level(newLevel):
	level = newLevel
	
func set_artifacts(newArtifact):
	artifacts = newArtifact

func set_timer(newTimer):
	timer = newTimer
