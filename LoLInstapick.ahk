/*	Copyright (C) 2015  Oscar Holmér
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
 *	You should have received a copy of the GNU General Public License
 *	along with this program.  If not, see http://www.gnu.org/licenses/.
*/

#EscapeChar \ 
if (ini_GetValue("General","ShowHelp") == 0)
{
	string = 
	( LTrim
	LoLInstapick  Copyright (C) 2015  Oscar Holmér
   
	This program comes with ABSOLUTELY NO WARRANTY.
	This is free software, and you are welcome to redistribute it
	under certain conditions
	
	Testa Instalock #KomIgenDetBlirKul
	)
	MsgBox, %string%
	ini_SetValue("General","ShowHelp",1)
}

;Jacka in sig på F5 för denna funktion körs när F5 klickas på
^f5::
{
	;Tjena! Välkommen  till min kod, här är lite kommentarer för dig :3 <333
	;Kolla om vi _INTE_ är på LoL Clienten, vars titel är "PVP.net Client". Fint och hårdkodat
	WinGetTitle, Title, A ;Hämta titel för aktivt window
	if(Title != "PVP.net Client")
	{
		SendPlay {f5} ;Skicka F5 istället så allt fungerar som "vanligt".
		return
	}
	WinGetPos, x, y,w,h,A ;Spara fnsterpositionen och storlek, för beräkningar var playknapp etc ligger
	
	;kolla i ini-fil efter champ och position
	who := ini_GetValue("Champ","Pick") 
	pos := ini_GetValue("Champ","Pos")
	
	;Fråga användaren efter vilken champ, senast valda som default
	InputBox, who, Who?,,,100,100,,,,,%who%
	if ErrorLevel	;cancel trycktes
		return
	InputBox, pos, Pos?,,,100,100,,,,,%pos%
	if ErrorLevel
		return
		
	;spara ner värderna i ini
	ini_SetValue("Champ","Pick",who)
	ini_SetValue("Champ","Pos",pos)
	
	MsgBox, 292,, Instalock?		;Ska vi intstalocka? #KomIgenDetBlirKul
	ifMsgBox Yes
		instalock := true
	else
		instalock := false
	
	;leta efter not lock som kommer upp när man är i ett gejm
	;find(bild) leter har en loop där den leter efter bilden tills den är funnen och returnar endast då
	find("img/notPicked.PNG")
	
	;chat 850, 740
	click(850/w*w,740/h*h)			;Skriva position i chatten, som ligger på {x:850,y:740} kompenserat för storleken av fönstret.
	SendInput, %pos%
	
	;Chilla i 100ms
	Sleep, 100
	
	;send 950, 740
	click(950/w*w,740/h*h)			;Clicka på send, varför inte enter? ja.. jag vet inte...
	
	;Leta efter champ, AKA ens tur att välja / kan välja
	find("img/champ.PNG")
		
	;search 900, 130
	click(900/w*w,130/h*h)			;Klicka på search
	Send, {CtrlDown}a{CtrlUp}		;Ctrl + A för markera allt
	Send, %who%						;skriva in champ namn
	
	;champ 320, 200
	Sleep, 300						;Chilla 300 ms för animationer typ
	click(320/w*w,200/h*h)			;Klicka champ längst upp till vänster (borde vara den man sökte på)
	click(900/w*w,130/h*h)			;err vet inte... klicka någon stans i guess
	
	;instalock 860, 500
	if(instalock)					;#Instalock ? :D :PpPpPpPp
	{
		find("img/lock.PNG")		;Vänta på att vi kan locka
		click(860/w*w,500/h*h)		;Klicka på lock
	}
	
	;hover send
	;MouseMove, 950/w*w,740/h*h
	
	;DÖNE
	return
}

^f6::Reload

;Find används av programmet för att vänta tills en bild är funnen.
;Med 20ms mellanrum letar den efter given bild tills den är hittad.
find(what)
{
	Loop,
	{
		if(findImage(what)==1)
		{
			break
		}
		Sleep, 20
	}
	return 1
}

;hurr durr
click(x,y)
{
	MouseMove, x,y
	MouseClick, Left
	return
}

;Hitta en bild med ImageSearch
findImage(what)
{
	CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %what% ;pick.PNG
	if ErrorLevel = 2
		return -1
	else if ErrorLevel = 1
		return -1
	else
		return 1
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