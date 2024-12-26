
-----[ Local List ]--------
--Bagian ini jangan diubah--

jumlah_vend,jumlah_yang_dibeli = 0,0
id_item_vend = 0
price = "0"
xnya,ynya = 0,0
delay,jumlah_spam = 200,200
prefix = ""

-----[ Hook List ]-------
AddHook(function(pkt)
if pkt.type == 3 and pkt.value == 32 then
xnya,ynya = pkt.px,pkt.py
dialog_vend = [[add_label_with_icon|big|`5Auto Buy Vending Machine|left|13812|
add_smalltext|`oScript by `9@YellowGold|
add_spacer|small|
add_text_input|delY|Delay?|200|5|
add_smalltext|`o Try to use a delay above 200 to avoid `4crashes|
add_button|vend_gaskan|`0Start `^Auto|noflags|0|0|
add_quick_exit|
end_dialog|vend1abalabal|Close|||
]]
growtopia.sendDialog(dialog_vend)
LogToConsole("Mmeek")
end
end,"OnSendPacketRaw")

AddHook(function(type,str)
if str:find("buttonClicked|vend_gaskan") then
delay = str:match("delY|(%d+)")
dialog_vend = [[add_label_with_icon|big|`5Auto Buy Vending Machine|left|13812|
add_smalltext|`oScript by `9@YellowGold|
add_spacer|small|
add_label_with_icon|small|Total in machine `2]]..jumlah_vend..[[|left|]]..id_item_vend..[[|
add_smalltext|`0Price Item : `2]]..price..[[|
add_spacer|small|
add_text_input|count|How many would you like to buy?|0|3|
add_text_input|spam|How many you like to spam?|200|3|
add_quick_exit|
add_button|gaskan_auto|`0Run Auto|noflags|0|0|
end_dialog|vendabalabal|Close||
]]
growtopia.sendDialog(dialog_vend)
end
if str:find("buttonClicked|gaskan_auto") then
jumlah_yang_dibeli = str:match("count|(%d+)")
jumlah_spam = str:match("spam|(%d+)")
growtopia.notify("`0Ready spam to `2"..jumlah_spam.." `0captain")
for i = 1,jumlah_spam do
CSleep(delay)
SendPacket(2, "action|dialog_return\ndialog_name|vending\ntilex|"..xnya.."|\ntiley|"..ynya.."|\nverify|1|\nbuycount|"..jumlah_yang_dibeli.."|\nexpectprice|"..prefix..""..price.."|\nexpectitem|"..id_item_vend.."|\n")
CSleep(delay)
SendPacket(2, "action|dialog_return\ndialog_name|backpack_menu\nitemid|"..id_item_vend.."\n")
end
growtopia.notify("`0I've spammed `2"..jumlah_spam.."`0 times captain!")
end
end,"OnSendPacket",true)

AddHook(function(var)
if var.v1 == "OnDialogRequest" and var.v2:find("add_label_with_icon|sml|The machine contains a total of (%d+) (.+)|left|(%d+)") and var.v1 == "OnDialogRequest" and var.v2:find("embed_data|expectprice|(%d+)") then
jumlah_vend,ga_guna,id_item_vend = var.v2:match("add_label_with_icon|sml|The machine contains a total of (%d+) (.+)|left|(%d+)")
price = var.v2:match("embed_data|expectprice|(%d+)")
prefix = ""
return true
end
if var.v1 == "OnDialogRequest" and var.v2:find("add_label_with_icon|sml|The machine contains a total of (%d+) (.+)|left|(%d+)") and var.v1 == "OnDialogRequest" and var.v2:find("embed_data|expectprice|--(%d+)") then
jumlah_vend,ga_guna,id_item_vend = var.v2:match("add_label_with_icon|sml|The machine contains a total of (%d+) (.+)|left|(%d+)")
price = var.v2:match("embed_data|expectprice|--(%d+)")
prefix ="-"
end
if var.v1 == "OnDialogRequest" and var.v2:find("end_dialog|backpack_menu") then
return true
end
end,"OnVariant")
SendVariant({
v1 = "OnAddNotification",
v2 = "interface/tutorial/tut00_growpedia.rttex",
v3 = "`c#`0Script By `9@YellowGold\n`c#`0Resell? `4BlackList\n`c#`0Script work on `e@Growlauncher\n`c#`0Script `2Free `0dont resell\n`o>> Thanks `^@User `ofor use my script :)",
v4 = "audio/tip_start.wav",
v5 = 2
})