@tool
extends TextureButton

signal triggered(state, index)
var index = [0,0]

func _ready():
	self.pressed.connect(self._button_pressed)

func _button_pressed():
	triggered.emit(button_pressed, index)
