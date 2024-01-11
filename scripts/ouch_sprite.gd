extends ColorRect

var c=1
# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible=false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#c-=.01
	PlayerVariables.ouch_sprite=self
	
	if PlayerVariables.ouch==true:
		self.visible=true
		#c=.5
	if PlayerVariables.ouch==false:
		
		#self.color=Color(1,0,0,c)
		self.visible=false
	pass
	

