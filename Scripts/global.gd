extends Node

var steps
var level
var artifacts
var timer
var enemies

func _ready():
	set_values()

func set_values():
	steps = 60
	level = 2
	artifacts = 20
	timer = 65
	enemies = 0

func set_steps(newSteps):
	steps = newSteps

func set_level(newLevel):
	level = newLevel
	
func set_artifacts(newArtifact):
	artifacts = newArtifact

func set_timer(newTimer):
	timer = newTimer
	
func set_enemies(newEnemies):
	enemies = newEnemies
