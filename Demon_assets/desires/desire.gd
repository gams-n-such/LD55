class_name Desire extends Resource

var bonus : Bonus

var condition : Condition

func apply(demon : Demon):
	if (condition.check.call()):
		bonus.apply.call(demon)
		demon.STATS["Desires"].remove_at(demon.STATS["Desires"].find(self))

func _to_string() :
	return "Condition: %s\nBonus: %s" % [condition.description, bonus.description]
