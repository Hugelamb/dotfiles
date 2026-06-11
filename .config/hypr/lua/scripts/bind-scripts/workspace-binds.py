#!/usr/bin/python3
from hyprpy import Hyprland
from hyprpy.utils.shell import run_or_fail
from fuzzel import fuzzel


# want function to swap all windows between current and specified workspaces.
# function should be called by a binding, and open a fuzzel dmenu instance for selection of the secondary workspace to swap with, if not specified will use the special workspace
class HyprInstance():
    def __init__(self):
        self.instance = Hyprland()
        
    def updateInstance(self):
        self.instance = Hyprland()

def swapWorkspaceWindows(activeWorkspace,targetWorkspace):
    windowsA = [ w for w in self.instance.get_workspace_by_id(int(activeWorkspace))] 
    return 


if __name__ == "__main__": 
    print("Welcome to the workspace bindings Python script.")
    hi = HyprInstance()

    options = [ str(monitor.active_workspace_id) for monitor in hi.instance.get_monitors() if monitor.active_workspace_id is not hi.instance.get_active_workspace().id ] # get list of active workspaces across all connected monitors
    key, index, selected = fuzzel('Select workspace', options, [
        '--minimal-lines'
    ]) # user selection of target workspace 
    # print("key : ", key, " | index : ", index ," | selected ", selected)


