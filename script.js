function LuaFree() {
  window.location.href = "sclocation.html";
}

function BuyVend() {
  const file = "scriptLuaGL/buyvend.lua";
  const link = document.createElement("a");
  link.href = file;
  link.download = "AutoBuyVend_YellowGold.lua";
  link.click();
}