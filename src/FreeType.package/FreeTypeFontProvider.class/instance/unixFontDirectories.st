file paths
unixFontDirectories
	"Trying with some common directories in unix. The prefered version is to read the /etc/fonts/fonts.conf"

	| localUserFonts |
	localUserFonts := FileLocator home / '.fonts'.
	^ {localUserFonts} , #('/usr/share/fonts' '/usr/local/share/fonts') collect: [ :each | each asFileReference ] thenSelect: [ :each | each exists ]