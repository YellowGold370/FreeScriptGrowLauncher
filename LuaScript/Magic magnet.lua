--To be learned by those who want to learn!
--It is prohibited to sell this script to the general public!
--Made by YellowGold
--Join channel : https://whatsapp.com/channel/0029VaiREdHEVccMDnnIIj2L


local idnya = 0
local decmm = false
function packet(type,str)
if str:find("|/magicmagnet") or str:find("|/mm") then
decmm = true
LogToConsole("`o Magic Magnet feature has been `2Enabled")
SendVariant({v1="OnDialogRequest",v2=[[
add_label_with_icon|big|`0Magic Magnet      |left|8304|
add_smalltext|`oScript by `9@YellowGold|
add_spacer|small|
add_label_with_icon|small|`2]]..growtopia.getItemName(idnya)..[[`0 Has been selected|left|]]..idnya..[[|
add_spacer|small|
add_item_picker|id_item_magnet|`0Choose Item|Select item to taked|
add_button|clear_m|`oClear|noflags|0|0|
add_spacer|small|
add_quick_exit|
end_dialog|magic_magnet|Close||
]]})
return true
end
if str:find("|/decmm") then
decmm = false
LogToConsole("`o Magic Magnet feature has been `4disabled")
return true
end
if str:find("|/help") then
LogToConsole("`2Command: `o/magicmagnet `0(Script by YellowGold) `2(Enabled Feature)")
LogToConsole("`2Command: `o/mm `0(Script by YellowGold) `2(Enabled Feature)")
LogToConsole("`2Command: `o/decmm `0(Script by YellowGold) `4(Disabled Feature)")
end
if str:find("\nid_item_magnet|(%d+)\n") then
idnya = tonumber(str:match("\nid_item_magnet|(%d+)\n"))
end
if str:find("buttonClicked|clear_m") then
idnya = 0
end
return false
end

function raw_packet(pkt)
if decmm == true then
if pkt.type == 11 then
for _, obj in pairs(GetObjectList()) do
if obj.itemid == idnya then
else
if pkt.value == obj.id then
return true
end
end
end
end
end
end
addHook(packet,"OnSendPacket")
addHook(raw_packet,"OnSendPacketRaw")