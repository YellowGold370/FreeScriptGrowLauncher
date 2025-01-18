-- ⟨ * EDUCATIONAL PURPOSES! * ⟩

module_setup = [[
    {
        "sub_name": "Tools By Erzy.sh",
        "icon": "Handyman",
        "menu": [
            {
                "type": "label",
                "text": "Usefull Tools"
            },
            {
                "type": "toggle",
                "text": "Debug Packet",
                "alias": "cheat_config_debugsendpacket"
            },
            {
                "type": "toggle",
                "text": "Debug Packet Raw (server)",
                "alias": "cheat_config_debugsendpacketrawserver"
            },
            {
                "type": "toggle",
                "text": "Debug Packet Raw (Client)",
                "alias": "cheat_config_debugsendpacketrawclient"
            },
            {
                "type": "toggle",
                "text": "Debug Variant",
                "alias": "cheat_config_debugvariant"
            },
            {
                "type": "toggle",
                "text": "Debug Value",
                "alias": "cheat_config_debugvalue"
            },
            {
              "type": "divider"
            },
            {
                "type": "label",
                "text": "Miscellaneous"
            },
            {
                "type": "toggle",
                "text": "Block Dialog",
                "alias": "cheat_config_block_dialog"
            },
            {
                "type": "label",
                "text": "You can add more feature by yourself \nor wait for me to update this script.."
            },
            {
              "type": "divider"
            },
            {
              "type": "dialog",
              "text": "Save Account",
              "support_text": "Click to save bot account",
              "fill": true,
              "menu": [
                 {
                   "type": "input_string",
                   "text": "Save Your Account Information",
                   "default": "GrowID|Password",
                   "label": "Your Growid|Your Password",
                   "placeholder": "Type your growid and password here",
                   "icon": "Edit",
                   "alias": "config_save_acc_gid"
                 }
              ]
            },
            {
              "type": "divider"
            },
            {
                "type": "button",
                "text": "Send Login Dialog",
                "alias": "config_login"
            },
            {
                "type": "button",
                "text": "Send Search Blocks Dialog",
                "alias": "config_blocks"
            },
            {
                "type": "button",
                "text": "Find Coordinate",
                "alias": "config_findCoordinate"
            },
            {
              "type": "divider"
            },
            {
              "type": "labelapp",
              "text": "ZyModule by Erzy.sh",
              "alias": "config_plantwm`id",
              "icon": "Copyright"
            },
            {
                "type": "divider"
            },
            {
                "type": "tooltip",
                "icon": "Link",
                "text": "Discord Server :",
                "support_text": "https://discord.gg/Wy4XYcTcSP"
            }
        ]
    }
]]

pkt, raw, var, dial, val, game = false, false, false, false, false, false
function say(text, toClient)
  SendPacket(2, "action|input\n|text|"..text, toClient)
end
function log(...)
  runCoroutine(function(...) LogToConsole("`c[`9Erzy.sh Script``]`9>> `0"..table.concat({...}, " : ")) end, ...)
end
function notif(...)
  runCoroutine(function(...) growtopia.notify("`c[`9Erzy.sh Script``]`9>> `0"..table.concat({...}, " : ")) end, ...)
end
function spread(t, i)
    local result = ""
    i = i or ""
    for k, v in pairs(t) do
        if type(v) == "table" then
            result = result .. i .. k .. " = \n"
            result = result .. spread(v, i .. "  ")
            result = result .. i .. "}\n"
        else
          if type(v) == "string" then
            result = result .. k .. "=\"" .. tostring(v) .. "\",\n"
          else
            result = result .. k .. "=" .. tostring(v) .. ",\n"
          end
        end
    end
    return "{"..result:sub(1, -2).."}"
end
function find(array, predicate)
    for i = 1, #array do
        if predicate(array[i], i, array) then
            return array[i]
        end
    end
    return nil
end
function write(name, s)
  local file = io.open("/storage/emulated/0/Android/data/launcher.powerkuy.growlauncher/ScriptLua/"..name, "a+")
  file:write(s.."\n\n")
  file:close()
  return "Done"
end
function pos()
  local l = GetLocal()
  return {x = l.posX//32, y = l.posY//32}
end

function onValue(type, name, value)
  if val then
    log("Type : "..type.."\nName : "..name.."\nValue : "..tostring(value))
  end
  if type == 0 then
    if name == "cheat_config_debugsendpacket" then
      pkt = value
    elseif name == "cheat_config_debugvalue" then
      val = value
    elseif name == "cheat_config_debugsendpacketrawclient" then
      game = value
    elseif name == "cheat_config_debugsendpacketrawserver" then
      raw = value
    elseif name == "cheat_config_debugvariant" then
      var = value
    elseif name == "cheat_config_block_dialog" then
      dial = value
    elseif name == "config_findCoordinate" and not value then
      if getLocal() then
        growtopia.notify("`c[`9ZyModule``]`9>> `0 X:".. getLocal().pos.x//32 ..", Y: "..getLocal().pos.y//32)
      else
        growtopia.notify("`c[`9ZyModule Script``]`9>> `0 You're not in a world!")
      end
    elseif name == "config_blocks" and not value then
      blocks = {}
      for k,v in pairs(GetTiles()) do
        if v.fg ~= 0 and v.fg ~= 8 and v.fg ~= 6 and v.fg ~= 3760 and not find(blocks, function(a) return a == v.fg end) then
          table.insert(blocks, v.fg)
         end
      end
      blockDialog = [[set_default_color|
add_quick_exit|
add_label_with_icon|big|Blocks in the `2]]..GetWorldName()..[[``|left|3902
add_spacer|small|
end_dialog|blocksearch|||
]]
      for k,v in pairs(blocks) do
        blockDialog = blockDialog.."add_button_with_icon|search"..v.."|"..growtopia.getItemName(v).."|noflags|"..v.."|"..v.."|\n"
      end
      growtopia.sendDialog(blockDialog)
    elseif name == "config_login" and not value then
      local dialog = [[set_default_color|
add_quick_exit|
add_label_with_icon|big|Select Bot Login|left|3902
add_spacer|small|
end_dialog|loginbot|||
]]
      local c = 0
      for v in io.open("/storage/emulated/0/.accounts_db.json", "r"):read("a"):gmatch("[^\n]+") do
        local gid, pass = v:match("(.*)|(.*)")
        dialog = dialog.."add_button_with_icon|"..gid.."&"..pass.."|"..gid.."|noflags|"..growtopia.getItemID("Number Block "..c%10).."||\n"
        c = c + 1
      end
      growtopia.sendDialog(dialog)
      return true
    end
  end
  if type == 5 then
    if name == "config_save_acc_gid" then
      if value == "GrowID|Password" then return end
      io.open("/storage/emulated/0/.accounts_db.json", "a+"):write(value.."\n"):close()
      sendDialog({title ="Done", message = value})
    end
  end
end
function onSendPacket(t,s)
  if pkt then log("Type",t.."\n"..s) end
  if t == 2 then
    if s:find("loginbot") then
      local gid,pass = s:match("ed|(.*)&(.*)")
      log("Logging on account",gid.."|"..pass)
      sendVariant({v1 = "SetHasGrowID", v2 = 1, v3 = gid, v4 = pass})
      sendVariant({v1 = "OnReconnect"})
    elseif s:find("/run .*") then
      log("`2Result : ``".. tostring(load("return "..s:match("/run (.*)"))()))
      return true
    elseif s:find("blocksearch") then
      local blockId = tonumber(s:match("blocksearch.*|search(%d+).*"))
      blockDialog = [[set_default_color|
add_quick_exit|
add_label_with_icon|big|`9]]..growtopia.getItemName(blockId).."`` Blocks in the `2"..GetWorldName()..[[``|left|3902
add_spacer|small|
end_dialog|blockmove|||
]]
      for k,v in pairs(GetTiles()) do
        if v.fg == blockId then
          blockDialog = blockDialog.."add_button_with_icon|coor"..v.x..":"..v.y.."|(`2"..v.x.."``, `9"..v.y.."``)|noflags|"..v.fg.."||\n"
        end
      end
      growtopia.sendDialog(blockDialog)
      return true
    elseif s:find("blockmove") then
      local x,y = s:match("blockmove.*|coor(%d+):(%d+).*")
      if not FindPath(x,y) then
        notif("Failed to FindPath")
        return true
      end
      growtopia.sendDialog(blockDialog)
      return true
    end
  end
end

function onVariant(v)
  if var then 
  local list = ""
  if v.v1 then
    list = list.."v1 = "..v.v1
  end
  if v.v2 then
    if type(v.v2) == "table" then
      list = list.."\nv2 = { "
      for k,j in pairs(v.v2) do
        list = list..j..", "
      end
      list = list:sub(1, #list-2).." }"
    else
      list = list.."\nv2 = "..v.v2
    end
  end
  if v.v3 ~= 0 then
    if type(v.v3) == "table" then
      list = list.."\nv3 = { "
      for k,j in pairs(v.v3) do
        list = list..j..", "
      end
      list = list:sub(1, #list-2).." }"
    else
      list = list.."\nv3 = "..v.v3
    end
  end
  if v.v4 ~= 0 then
    list = list.."\nv4 = "..v.v4
  end
  if v.v5 ~= 0 then
    list = list.."\nv5 = "..v.v5
  end
  log(list)
  return false
  end
  if dial then
    if v.v1 == "OnDialogRequest" then
      return true
    end
  end
end

function onGamePacket(k)
  if not game then return false end
  if game then
    log(spread(k))
  end
end

function onSendPacketRaw(p)
  if not raw then return false end
  if raw then
    log(spread(p))
  end
end

addIntoModule(module_setup)
sendNotification("Erzy.sh Tools / ZyModule Added")
applyHook()