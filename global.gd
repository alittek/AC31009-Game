extends Node

var steps = 200
var level = 1
var artifacts = 0
var timer = 100
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
	steps = 20
	level = 1
	artifacts = 0
	timer = 15
	enemies = 0
