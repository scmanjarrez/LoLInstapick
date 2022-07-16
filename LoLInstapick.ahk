/*	Copyright (C) 2015-2022  Oscar Holmér, scmanjarrez
 *	
 *	This program is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 *	
 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *	
 *	You should have received a copy of the GNU General Public LicenseZilean
 *	along with this program.  If not, see http://www.gnu.org/licenses/.
*/

CoordMode, Mouse, Screen

; Triggers on F2 keypress, instapick
F1::
{
	; Check if the triggered window match the title "League of Legends"
	WinGetTitle, Title, A
	if(Title != "League of Legends")
		return

	; Retrieve Pick and Lane from .ini
	champ := ini_GetValue("Champ","Pick") 
	lane := ini_GetValue("Champ","Lane")
	delay := ini_GetValue("Champ","ChatDelay")
	
	chat_x := ini_GetValue("Positions","Chat_X")
	chat_y := ini_GetValue("Positions","Chat_Y")
	search_x := ini_GetValue("Positions","Search_X")
	search_y := ini_GetValue("Positions","Search_Y")
	champ_x := ini_GetValue("Positions","Champ_X")
	champ_y := ini_GetValue("Positions","Champ_Y")
	lock_x := ini_GetValue("Positions","Lock_X")
	lock_y := ini_GetValue("Positions","Lock_Y")
	
	; Search champ
	MouseClick, left, search_x, search_y
	SendInput, %champ%
	
	; Wait animation
	Sleep, 200
	
	; Lock champ
	MouseClick, left, champ_x, champ_y
	MouseClick, left, lock_x, lock_y
	
	; Wait chat to connect
	Sleep, delay
	
	; Declare position
	MouseClick, left, chat_x, chat_y
	SendInput, %lane%
	MouseClick, left, chat_x, chat_y
	SendInput, {ENTER}
	return
}

; Triggers on F2, reload the script
F2::
{
	Reload
	return
}

; Triggers on F3, start calibration
F3::
{
	MsgBox, This must be run on champ select in a custom game.`n`nFirst, click on the CHAT BOX
	KeyWait, LButton, D
	MouseGetPos, chat_x, chat_y
	ini_SetValue("Positions", "Chat_X", chat_x)
	ini_SetValue("Positions", "Chat_Y", chat_y)
	
	MsgBox, Now click on the SEARCH BOX
	KeyWait, LButton, D
	MouseGetPos, search_x, search_y
	ini_SetValue("Positions", "Search_X", search_x)
	ini_SetValue("Positions", "Search_Y", search_y)
	
	MsgBox, Now click on the first champ icon ('?' button)
	KeyWait, LButton, D
	MouseGetPos, champ_x, champ_y
	ini_SetValue("Positions", "Champ_X", champ_x)
	ini_SetValue("Positions", "Champ_Y", champ_y)
	
	MsgBox, Finally, click on the LOCK BOX
	KeyWait, LButton, D
	MouseGetPos, lock_x, lock_y
	ini_SetValue("Positions", "Lock_X", lock_x)
	ini_SetValue("Positions", "Lock_Y", lock_y)
	
	MsgBox, Calibration completed. Run the script (F1) when champ select pops up.
	return
}

ini_GetValue(_Section, _Key)
{
	Value = 
	IniRead, Value, LoLInstapick.ini, %_Section%, %_Key%, 0
	Return Value
}

ini_SetValue(_Section, _Key, _Value)
{
	IniWrite, %_Value%, LoLInstapick.ini, %_Section%, %_Key%
}