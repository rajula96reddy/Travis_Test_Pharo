I am a simple model describing a menu.
See AbstractWidgetModel

I only contains a list of menu groups (MenuGroupModel). Each group is separated by a splitter.

I provide the following variables and their accessors
- addGroup: use the block in parameter to initialize a new group, then add it in my collection.
- addMenuGroup: add the group in parameter in my collection.
- menuGroups getter of my collection.


todo
- addAllFromPragma:target:
- applyTo: activate the shortcut of the items of my groups.
- autoRefresh
- buildWithSpecAsPopup
- fromSpec:
- icon
- neglect:
- openWithSpecAt:
- printOn:
- title , addTitle:
