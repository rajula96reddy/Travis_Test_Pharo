system annoucements
methodAdded: aMethod

	| rules |

	(rbEnvironment includesMethod: aMethod) ifFalse: [ ^ self ].

	rules := self allRules.
	checker
		resetResult;
		getCritiquesAbout: aMethod by: (rules select: [ :r | r class checksMethod ]).

	rules do: [ :rule |		
		(checker criticsOf: rule) do:	[ :crit |
			cache addCritic: crit forRule: rule ].
		(checker falsePositiveOf: rule) do:	[ :crit |
			cache addFalsePositive: crit forRule: rule ].
		(checker toDoOf: rule) do:	[ :crit |
			cache addToDo: crit forRule: rule ] ].
	
	cache updateBrowser.