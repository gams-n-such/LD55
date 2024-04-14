class_name RandomConditionGenerator extends Resource

var rng = RandomNumberGenerator.new()

func getRandomCondition() -> Condition:
	var condition_types : Array[String] = ["Faction", "Power", "HP"]
	var condition_type : String = condition_types.pick_random()
	
	var result = Condition.new()
	
	if (condition_type == "Faction"):
		var desired_faction = Demon.Fraction.values().pick_random()
		result.description = "You should have at least one demon of %s faction!" % str(desired_faction)
		result.check = func () -> bool :
			for demon : Demon in Game.player_state.player_legion.legion :
				if (demon.STATS["Fraction"] == desired_faction) :
					return true
			return false
	
	if (condition_type == "Power"):
		var desired_power = rng.randi_range(5, 50)
		result.description = "You should have at least one demon with at least %s power!" % str(desired_power)
		result.check = func () -> bool :
			for demon : Demon in Game.player_state.player_legion.legion :
				if (demon.STATS["Power"] >= desired_power) :
					return true
			return false
	
	if (condition_type == "HP"):
		var desired_hp = rng.randi_range(5, 50)
		result.description = "You should have at least one demon with at least %s HP!" % str(desired_hp)
		result.check = func () -> bool :
			for demon : Demon in Game.player_state.player_legion.legion :
				if (demon.STATS["Health"] >= desired_hp) :
					return true
			return false
	
	return result
