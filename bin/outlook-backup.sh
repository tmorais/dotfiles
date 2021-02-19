#!/usr/bin/osascript

# https://medium.com/hackernoon/automated-inbox-cleansing-with-outlook-2016-and-applescript-49cf4c4422fa

set startDay to date (date string of ((current date) - (5 * days)) & "at 12:00:00 AM" as string)
set endDay to date (date string of ((current date)) & "at 11:59:59 PM" as string)

tell application "Microsoft Outlook"

        log "Moving Launches, WinWires, etc"

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
                        
                        # log datedFolder
                        set destFolder to (mail folder datedFolder of baseFolder)
		                move msg to destFolder
                end repeat
                log "moved " & deletedMessagesCount & " messages from " & managedFolderName
        end repeat

        -- inbox filters
        set baseFolder to mail folder "Archive" of on my computer
        log baseFolder

        set myInbox to folder "Inbox" of default account
        
        set daysToPreserve to 7
        set dateReference to (current date) - (daysToPreserve * days)
        
        set today to (current date)
        set cutoff to 2 * days
        set shortCutoff to 3 * hours

        set theMessages to messages of inbox      

        set movedMessagesCount to 0

        repeat with theMessage in theMessages
                try
                        set messageTime to time received of theMessage
                        set messageAge to today - messageTime
                        set theSubject to the subject of theMessage
                        set theSender to sender of theMessage
                        set fromAddress to address of theSender

                        # This archives a New Relic alert if it's more than 2 days old
                        # if name of theSender contains "Launch Annoucem" then
                        #         if messageAge > cutoff then
                        #                 move theMessage to folder "Notifications" of archive
                        #                 set countMoved to countMoved + 1
                        #         end if
                        # end if

                        -- log theSubject

                        if theSubject contains "Launch Announcement" then
                                move theMessage to folder "Launches" of myInbox
                                log "moved " & theSubject & " to " & "inbox/Launches"
                                set movedMessagesCount to movedMessagesCount + 1
                        end if

                        if (theSubject contains "is an AWSome Builder") or (theSubject contains "AWSome CSM") then
                                move theMessage to folder "AWSomeBuilder" of myInbox
                                log "moved " & theSubject & " to " & "inbox/AWSomeBuilder"
                                set movedMessagesCount to movedMessagesCount + 1
                        end if

                        if theSubject contains "[EXTERNAL]" then
                                if (fromAddress contains "nubank") or (fromAddress contains "artimar") or (fromAddress contains "microchip") then 
                                        log "doing nothing... " & theSubject
                                else
                                        log "moved " & theSubject & " to " & "inbox/External"
                                        set movedMessagesCount to movedMessagesCount + 1
                                end if
                        end if

                        if theSubject contains "Daily Amazon.com Digest" then
                                move theMessage to folder "__IOT" of myInbox
                                log "moved " & theSubject & " to " & "inbox/Misc"
                                set movedMessagesCount to movedMessagesCount + 1
                        end if

                        if theSubject contains "Your PFR:" then
                                move theMessage to folder "__IOT" of myInbox
                                log "moved " & theSubject & " to " & "inbox/__IOT"
                                set movedMessagesCount to movedMessagesCount + 1
                        end if

                        if theSubject contains "Update to PFR" then
                                move theMessage to folder "__IOT" of myInbox
                                log "moved " & theSubject & " to " & "inbox/__IOT"
                                set movedMessagesCount to movedMessagesCount + 1
                        end if
                        
                        if theSender contains "monthly-statement-notification@amazon.com" then
                                move theMessage to folder "inbox/Misc" of myInbox
                                log "moved " & theSubject & " to " & "inbox/Misc"
                                set movedMessagesCount to movedMessagesCount + 1
                        end if 

                        if theSubject contains "Office Hours" then
                                # move theMessage to folder "AWSomeBuilder" of myInbox
                                log "moved " & theSubject & " to " & "inbox/AWSomeBuilder"
                                set movedMessagesCount to movedMessagesCount + 1
                        end if
      
                on error errorMsg
                        log "Error: " & errorMsg
                        log theMessage
                end try
        end repeat

        log "you saved the time of evaluating " & movedMessagesCount & " messages. Yeaayyyy!"

end tell

# set startDay to date (date string of ((current date) - (30 * days)) & "at 12:00:00 AM" as string)
# set endDay to date (date string of ((current date) + (30 * days)) & "at 11:59:59 PM" as string)

# tell application "Microsoft Outlook"
# 	log "Cleaning invites"

# 	set myInbox to folder "Inbox" of default account
	
# 	set daysToPreserve to 7
# 	set dateReference to (current date) - (daysToPreserve * days)
	
# 	set today to (current date)
# 	set cutoff to 10 * days
# 	set shortCutoff to 3 * hours
	
# 	set theMessages to (every message of inbox whose time received is greater than or equal to startDay and time received is less than endDay)
# 	set movedMessagesCount to 0
	
# 	set withResp to true
# 	set aComment to "This meeting was auto declined. If you think this is wrong, please contact me."
	
# 	repeat with theMessage in theMessages
# 		try
# 			set messageTime to time received of theMessage
# 			set messageAge to today - messageTime
# 			set messageSender to "UNK"
# 			set theSubject to the subject of theMessage
# 			set isMeeting to is meeting of theMessage
			
			
# 			if isMeeting then
# 				if (theSubject does not contain "Cancel") and (theSubject does not contain "Decline") then
# 					if theSubject contains "Office Hours" then
# 						log "TO BE Canceled - " & messageTime & " - " & messageSender & " - " & theSubject
# 						decline invite theMessage with withResp and aComment
# 					else if theSubject contains "ISV Unp" then
# 						log "TO BE Canceled - " & messageTime & " - " & messageSender & " - " & theSubject
# 						decline invite theMessage with withResp and aComment
# 					else
# 						log "TO BE KEPT - " & messageTime & " - " & messageSender & " - " & theSubject
# 					end if
# 				else
# 					log "ALREADY Canceled - " & messageTime & " - " & messageSender & " - " & theSubject
# 				end if
# 			end if
			
# 		on error errorMsg
# 			log "ERROR: " & errorMsg
# 			# log theMessage
# 		end try
# 	end repeat
# end tell


#         # log "Cleaning calendar"

# 	# -- get list of todays non-recurring events
# 	# set todaysEvents to (every calendar event whose start time is greater than or equal to startDay and end time is less than endDay)
	
#         # set withResp to true
# 	# set aComment to "This meeting was auto declined. If you think this is wrong, please contact me."
	
# 	# repeat with anEvent in todaysEvents
# 	# 	try
#         #                 set eventSubject to subject of anEvent
#         #                 set startEvent to start time of anEvent

#         #                 if eventSubject contains "Office Hours" then
#         #                         log "sub " & eventSubject & " starts " & startEvent
#         #                         set anEvent decline meeting  with {comment:"TEST"} # , sending response:withResp}
#         #                         log "DECLINED sub " & eventSubject & " starts " & startEvent
#         #                         # decline meeting calendar event : The meeting to decline.
#         #                         # [comment text] : When sending responses, the text of the response body (in HTML)
#         #                         # [sending response boolean] : Should the decline response message be sent back to the organizer.
#         #                 end if

#         #                 # if eventSubject contains "AWS PREQUELS" then
#         #                 #         log "sub " & eventSubject & " starts " & startEvent
#         #                 #         decline meeting anEvent with properties {comment:aComment}
#         #                 #         log "DECLINED sub " & eventSubject & " starts " & startEvent
#         #                 # end if
                        
#         #         on error errorMsg
#         #                 log "Error: " & errorMsg
#         #                 log anEvent
#         #         end try
#         # end repeat
