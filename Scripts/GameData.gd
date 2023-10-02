extends Node2D

var number_of_deaths = 0

func player_died():
	number_of_deaths += 1

func reset_deaths():
	number_of_deaths = 0
