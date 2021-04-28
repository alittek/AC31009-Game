extends Node

var steps = 60
var level = 3
var artifacts = 20
var timer = 15
var enemies = 0

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

func reset_values():
	steps = 50
	level = 1
	artifacts = 0
	timer = 10
	enemies = 0
