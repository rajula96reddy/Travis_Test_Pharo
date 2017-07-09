*System-Platforms
currentWorkingDirectoryPathWithBufferSize: aBufferSize
	"This method calls the method getPwdViaFFI with arugement of a buffer size."
	|buffer |
	buffer := String new: aBufferSize  .
	^OSEnvironment current getPwdViaFFI: buffer size:aBufferSize. 