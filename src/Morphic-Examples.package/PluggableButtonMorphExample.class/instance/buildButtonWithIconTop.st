building
buildButtonWithIconTop
	^ (PluggableButtonMorph
		on: self 
		getState: nil 
		action:  #action 
		label: #label 
		icon: #icon
		menu: nil)
		beIconTop. 	