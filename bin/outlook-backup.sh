#!/usr/bin/osascript

tell application "Microsoft Outlook"
        -- Set max age to three days ago
        set maxAge to (current date) - (30 * days)

        -- Set the list of subfolders to visit. All other folders are ignored
        set managedFolders to {"Launches", "WinWire", "_SA-Sec_List"}
        log managedFolders

        set baseFolder to mail folder "Archive" of on my computer
        log baseFolder

        -- set sbflders to (folders of destFolder whose name is "2020S1")
        -- log sbflders

        set clzz to properties of inbox
        repeat with managedFolderName in managedFolders
                set sbflders to (folders of inbox whose name is managedFolderName)
                set fldr to item 1 of sbflders
                set oldMessages to (every message of fldr whose time received is less than maxAge)
                set deletedMessagesCount to count of oldMessages
                repeat with msg in oldMessages
                        set {year:y, month:m, day:d} to time received of msg
                        set theMonthNumber to (m as integer)
                        -- log theMonthNumber 
                        set datedFolder to "" & y & "S1" & ""
                        
                        if theMonthNumber > 6 then
                            -- log "" & y & "S2" & ""
                            set datedFolder to "" & y & "S2" & ""
                        end if
                        
                        if not (exists mail folder datedFolder of baseFolder) then
                            log "Creating Folder..."
                            log datedFolder
			                make new mail folder with properties {name:datedFolder} at baseFolder
		                end if
                        
                        log datedFolder
                        set destFolder to (mail folder datedFolder of baseFolder)
		                move msg to destFolder
                end repeat
                log "moved " & deletedMessagesCount & " messages from " & managedFolderName
        end repeat
end tell

