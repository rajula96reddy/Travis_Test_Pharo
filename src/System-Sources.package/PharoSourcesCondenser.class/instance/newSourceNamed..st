public
newSourceNamed: aString
	"Create a new version of the .soruces file by copying the existing file to a new location"
	| originalSourcesFile newSourcesFile |
	
	"Create a copy with the new name"
	originalSourcesFile := self originalFile resolve.
	Smalltalk sourceFileVersionString: aString.
	newSourcesFile := Smalltalk sourcesFile.

	originalSourcesFile copyTo: newSourcesFile.
	"Use the new sources file"
	Smalltalk openSourceFiles.