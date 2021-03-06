preparation
exportJenkinsToolsInStFile

	| mcst blacklistedClasses blacklistedMethods | 
	
	blacklistedClasses := #().	
	blacklistedMethods := #().		
	
	mcst := (self bootstrapCacheDirectory / 'st-cache' / 'JenkinsTools.st') asFileReference.
	mcst ensureDelete.
	mcst parent ensureCreateDirectory.
	mcst writeStreamDo: [ :stream | | writer version |
		writer := MCStWriter on: stream.
		writer writeInitializers: false.
		
		#('JenkinsTools-Core') do: [ :packageName |
			| definitions |
			version := (self originRepository loadVersionFromFileNamed: packageName, '.package').
			definitions := version snapshot definitions.
			definitions := definitions reject: [:def | blacklistedClasses includes: def className ].
			definitions := definitions reject: [:def | def isMethodDefinition and: [blacklistedMethods includes: def selector] ].
			writer writeDefinitions: definitions.].
	].