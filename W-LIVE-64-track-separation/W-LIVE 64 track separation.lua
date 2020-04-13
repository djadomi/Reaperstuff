-- function to run Reaper command on all items in a track
-- this is mainly useful for reassigning channel mode
-- note: use "real" channel numbers (1-64) not zero-indexed
function chmode(tr, cm)
	-- get track and select it:
	track = reaper.GetTrack(0, tr - 1)
	reaper.SetOnlyTrackSelected(track, true)
	-- count items in the track
	items = reaper.CountTrackMediaItems(track)
	-- loop items:
	for i = 0, items - 1 do
		-- get item and select it:
		item = reaper.GetTrackMediaItem(track, i)
		reaper.SetMediaItemSelected(item, true)
		-- run command on item, then deselect it:
		reaper.Main_OnCommand(cm, 0)
		reaper.SetMediaItemSelected(item, false)
	end
	-- deselect track:
	reaper.SetTrackSelected(track, false)
end
function renametrack(tr, name)
	-- get track and select it:
	track = reaper.GetTrack(0, tr - 1)
	-- rename track to name param:
	reaper.GetSetMediaTrackInfo_String(track, "P_NAME", name, true)
end
-- loop duplication, to make a track for each channel:
for i = 0, 4 do
	reaper.Main_OnCommand(40296, 0)
	reaper.Main_OnCommand(40062, 0)
end

-- set track 1 to Main L:
chmode(1, 40179)
-- set track 2 to Main R:
chmode(2, 40180)
-- run through remaining tracks of SD A:
for t = 3, 32 do
	-- set channel mode to track number, minus 1 (to get zero-indexed) plus the index of the first command to set channel mode to Mono numbered channels:
	chmode(t, t - 1 + 41386)
end
-- set track 33 (first of SD B) to Main L:
chmode(33, 40179)
-- set track 34 (second of SD B) to Main R:
chmode(34, 40180)
-- run through remaining tracks of SD B:
for t = 35, 64 do
	-- same as SD A, except subtract 32 from track number to get the correct command:
	-- [I've left this so verbose (instead of just t - 41355) so that it's clear what is going on]
	chmode(t, t - 1 + 41386 - 32)
end
channels = {
	'Kick',
	'Snare',
	'Clap',
	'HiHat',
	'MFB522 L',
	'MFB522 R',
	'Minilogue',
	'MicroBrute',
	'Volca Bass',
	'Volca Keys',
	'Volca Sample L',
	'Volca Sample R',
	'Volca FM',
	'Anode',
	'D20 L',
	'D20 R',
	'DK-80',
	'',
	'K4r L',
	'K4r R',
	'Patchblock L',
	'Patchblock R',
	'Drum bus L',
	'Drum bus R',
	'Delay 1 L',
	'Delay 1 R',
	'Reverb 1 L',
	'Reverb 1 R',
	'Reverb 2 L',
	'Reverb 2 R',
	'Bus 4 L',
	'Bus 4 R',
	'Kick pre',
	'Snare pre',
	'Clap pre',
	'HiHat pre',
	'MFB522 L pre',
	'MFB522 R pre',
	'Patchblock L pre',
	'Patchblock R pre',
	'MicroBrute pre',
	'Volca Bass pre',
	'Volca FM pre',
	'Volca Keys pre',
	'Volca Sample L pre',
	'Volca Sample R pre',
	'Anode pre',
	'Minilogue pre',
	'D20 L pre',
	'D20 R pre',
	'DK-80 pre',
	'',
	'K4r L pre',
	'K4r R pre',
	'Zoom B3n L pre',
	'Zoom B3n R pre',
	'',
	'',
	'',
	'',
	'',
	'',
	'Main 3 L',
	'Main 3 R',
}
for i = 1, 64 do
	renametrack(i, channels[i])
end
