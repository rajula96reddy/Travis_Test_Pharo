I provide a mock (or null) driver, which can create a valid OSWindow instances, despite the fact that underlaying OS may not support any notion of windows or even graphical user interface.

I can be used for testing (by picking as a preferrable driver in window attributes),
or as a default driver while running image in headless mode.

Using null driver allows most of the code which relies on existance of at least single main window to work flawlessly, by simply ignoring all requests/commands passed to it.