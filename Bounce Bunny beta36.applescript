use AppleScript version "2.4"
use scripting additions
use framework "Foundation"
use framework "AppKit"

property aStatusItem : missing value

on run
	init() of me
end run

on menu_click(mList)
	
	local appName, topMenu, r
	2
	
	
	-- Validate our input
	
	if mList's length < 3 then error "Menu list is not long enough"
	
	
	
	-- Set these variables for clarity and brevity later on
	
	set {appName, topMenu} to (items 1 through 2 of mList)
	
	set r to (items 3 through (mList's length) of mList)
	
	
	
	-- This overly-long line calls the menu_recurse function with
	
	-- two arguments: r, and a reference to the top-level menu
	
	tell application "System Events" to my menu_click_recurse(r, ((process appName)'s (menu bar 1)'s (menu bar item topMenu)'s (menu topMenu)))
	
end menu_click



on menu_click_recurse(mList, parentObject)
	
	local f, r
	
	
	
	-- `f` = first item, `r` = rest of items
	
	set f to item 1 of mList
	
	if mList's length > 1 then set r to (items 2 through (mList's length) of mList)
	
	
	
	-- either actually click the menu item, or recurse again
	
	tell application "System Events"
		
		if mList's length is 1 then
			
			click parentObject's menu item f
			
		else
			
			my menu_click_recurse(r, (parentObject's (menu item f)'s (menu f)))
			
		end if
		
	end tell
	
end menu_click_recurse

on init()
	set aList to {"Bounce", "Stop", "", "Quit"}
	
	set aStatusItem to current application's NSStatusBar's systemStatusBar()'s statusItemWithLength:(current application's NSVariableStatusItemLength)
	
	aStatusItem's setTitle:"Bounce Bunny"
	aStatusItem's setHighlightMode:true
	aStatusItem's setMenu:(createMenu(aList) of me)
end init


on createMenu(aList)
	set aMenu to current application's NSMenu's alloc()'s init()
	set aCount to 1
	
	repeat with i in aList
		set j to contents of i
		
		if j is not equal to "" then
			
			if j = "Quit" then
				set aMenuItem to (current application's NSMenuItem's alloc()'s initWithTitle:j action:"actionHandler:" keyEquivalent:"")
				--(aMenuItem's setKeyEquivalentModifierMask:(current application's NSControlKeyMask))
			else
				set aMenuItem to (current application's NSMenuItem's alloc()'s initWithTitle:j action:"actionHandler:" keyEquivalent:"")
			end if
			
		else
			set aMenuItem to (current application's NSMenuItem's separatorItem())
		end if
		(aMenuItem's setTarget:me)
		(aMenuItem's setTag:aCount)
		(aMenu's addItem:aMenuItem)
		
		if j is not equal to "" then
			set aCount to aCount + 1
		end if
	end repeat
	
	return aMenu
end createMenu


on actionHandler:sender
	set aTitle to title of sender as string
	if aTitle is equal to "Quit" then
		current application's NSStatusBar's systemStatusBar()'s removeStatusItem:aStatusItem
		if (name of current application) is not "Script Editor" then
			tell current application to quit
		end if
	else if aTitle is equal to "Bounce" then
		
		delay 2
		set BBv to "Bounce Bunny beta36"
		
		tell application BBv to activate
		set theResponse to display dialog "How many tracks to bounce ?" default answer "1" with icon note buttons {"Cancel", "Continue"} default button "Continue"
		--> {button returned:"Continue", text returned:"Jen"}
		display dialog "Total Tracks " & (text returned of theResponse) & "."
		set theResponse to (text returned of theResponse)
		tell application "Finder"
			set currentPath to choose folder
		end tell
		tell application "Logic Pro X" to activate --Bring Logic in front
		set firstB to theResponse
		repeat while theResponse > 0
			if firstB = theResponse then
				menu_click({"Logic Pro X", "Logic Pro X", "Key Commands", "Presets", "BBKCv1"}) -- Key Commands
			else
				display notification "Remaining tracks" & theResponse & "."
				--Commands being here
			end if
			delay 0.2
			tell application "Logic Pro X" to activate --Bring Logic in front
			delay 0.3
			menu_click({"Logic Pro X", "Track", "Rename Track"}) -- Rename Track
			delay 0.1
			menu_click({"Logic Pro X", "Edit", "Copy"}) -- Copy Track Name
			delay 0.1
			tell application "System Events" to keystroke return --Deselect Track Name
			delay 0.1
			tell application "System Events" to keystroke "s" using {shift down} --Solo Selected Track
			delay 0.1
			tell application "System Events" to keystroke "b" using {command down} --Bounce Track
			delay 0.3
			if firstB = theResponse then
				tell application BBv to activate
				display dialog "Set The Settings You Want the Bounce Bunny To Bounce Your Tracks in Logic and Press Continue" buttons {"Cancel", "Continue"} default button "Continue"
				delay 0.3
				tell application "Logic Pro X" to activate --Bring Logic in front
				delay 0.3
				tell application "System Events" to keystroke return --initiate Bounce
				delay 0.3
				menu_click({"Logic Pro X", "Edit", "Paste"}) -- Paste Track Name
				delay 1
				tell application "System Events" to keystroke "g" using {command down, shift down} --go to folder
				delay 0.5
				tell application "System Events" to keystroke currentPath
				delay 2.5
				tell application "System Events" to keystroke return --select folder
				delay 0.2
				tell application "System Events" to keystroke return --Bounce
			else
				tell application "System Events" to keystroke return --Bounce
				tell application "System Events" to keystroke "v" using {command down} --Paste Track Name
				delay 1
				tell application "System Events" to keystroke return --Bounce
			end if
			delay 1
			
			delay 2
			
			tell application "System Events"
				
				--if (exists window "Logic Pro X" of application process "Logic Pro X") then
				
				repeat while (exists window "Logic Pro X" of application process "Logic Pro X")
					
					delay 1
					
					display dialog "Stop Bouncing ? Remaining tracks " & theResponse buttons {"Stop", "Continue"} default button "Continue" cancel button "Stop" giving up after 5
					
					delay 1
					
				end repeat
				
				tell application "Logic Pro X" to activate --Bring Logic in front
				
				tell application "System Events" to keystroke "s" using {shift down} --Unsolo Selected Track
				
				tell application "System Events" to key code 125 --Unsolo Selected Track
				
				--else
				
				delay 3
				
				--end if
				
				
				
			end tell
			set theResponse to theResponse - 1
		end repeat
		
		delay 1
		tell application "Finder" to activate --Bring Finder in front
		tell application "System Events" to keystroke "g" using {command down, shift down} --go to folder
		delay 1
		tell application "System Events" to keystroke return --Goto the Folder
		
		
		
		--  # Your code to run for this menu choice goes here:
		
	else if aTitle is equal to "Stop" then
		
		
		set T1 to minutes of (current date)
		
		set T1s to seconds of (current date)
		
		
		say "stop................. wait a minute"
		
		delay 10
		
		
		
		
		
		set T2 to minutes of (current date)
		
		set T2s to seconds of (current date)
		
		set TT_ to ((T2 * 60) + T2s) - ((T1 * 60) + T1s)
		
		display dialog "Timer Test Expect 12 sec " & TT_ & " sec"
		--  # Your code to run for this menu choice goes here:
		
		--else if aTitle is equal to "Takaaki" then
		
		--  # Your code to run for this menu choice goes here:
		
		--else if aTitle is equal to "Naganoya" then
		
		--  # Your code to run for this menu choice goes here:
		
	end if
end actionHandler:
