@tool

extends Button

@export_category("React Button")
@export var ButtonColor : Color:
	get:
		return (%BG as ColorRect).color
	set(value):
		(%BG as ColorRect).color = value

@export var ButtonIcon : Texture2D:
	get:
		return (%Icon as TextureRect).texture
	set(value):
		(%Icon as TextureRect).texture = value
