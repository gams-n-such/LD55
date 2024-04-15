class_name RandomBonusGenerator extends Resource

var rng = RandomNumberGenerator.new()

func getRandomBonus() -> Bonus:
	var applicable_stats : Array[String] = ["Power", "Health", "Sacrifice value", "Abilities"]
	var stat_name : String = applicable_stats.pick_random()
	var result = Bonus.new()
	if (stat_name != "Abilities") :
		var bonus_value : int = rng.randi_range(1, 25)
		result.description = "%s increase for %s points" % [stat_name, str(bonus_value)]
		result.apply = func (demon : Demon) :
			demon.STATS[stat_name] += bonus_value
		return result
	
	var bonus_ability = Demon.Abilities.values().pick_random()
	result.description = "Demon receives this ability: %s" % str(bonus_ability)
	result.apply = func (demon : Demon) :
		demon.STATS["Abilities"].append(bonus_ability)
	return result
