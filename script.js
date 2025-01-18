AddedScript("Script ini mirip lah seperti magic magnet di gorwtopia :v", "Magic Magnet", "Magic magnet.lua", "filesender");
AddedScript("Aku bukan yang buat :v cuma reupload", "Module Debug With UI", "moduledebugUI.lua", "filesender");

function AddedScript(desk, scriptname, locfile, classc) {
  const fbox = document.getElementById("f-box");
  const filex = document.createElement("div");
  filex.className = `message ${classc}`;
  fbox.appendChild(filex);

  // Nama script
  const scname = document.createElement("p");
  scname.textContent = "# " + scriptname;
  scname.className = `message scclass`;
  filex.appendChild(scname);

  // Deskripsi script
  const deks = document.createElement("p");
  deks.textContent = desk;
  deks.className = `message deksclass`;
  filex.appendChild(deks);

  // Tombol Download
  const btnsc = document.createElement("button");
  btnsc.textContent = "Download";
  btnsc.className = `message downloadsc`;
  btnsc.setAttribute("data-file", locfile);
  filex.appendChild(btnsc);

  // Tombol View File
  const vwsc = document.createElement("button");
  vwsc.textContent = "View File";
  vwsc.className = `message viewscs`;
  vwsc.setAttribute("data-file", locfile);
  filex.appendChild(vwsc);

  // Scroll otomatis ke bawah
  fbox.scrollTop = fbox.scrollHeight;
  return filex;
}

// Event Delegation untuk download
document.addEventListener("click", (event) => {
  if (event.target.classList.contains("downloadsc")) {
    event.preventDefault();
    const button = event.target;
    const filenamee = button.getAttribute("data-file");

    if (!filenamee) {
      console.error("File tidak ditemukan pada tombol ini.");
      return;
    }

    console.log("Attempting to download:", filenamee);

    // Cek apakah file tersedia di server
    fetch('LuaScript/' + filenamee, { method: 'HEAD' })
      .then(response => {
        if (!response.ok) {
          console.error("File not found on server:", response.status);
          return;
        }

        // Buat elemen <a> untuk download
        const link = document.createElement("a");
        link.href = 'LuaScript/' + filenamee;
        link.download = filenamee;
        document.body.appendChild(link); // Tambahkan sementara
        link.click();
        document.body.removeChild(link); // Hapus setelah digunakan
        console.log("Download initiated for:", filenamee);
      })
      .catch(err => console.error("Error checking file availability:", err));
  }
});

// Event Delegation untuk view file
document.addEventListener("click", (event) => {
  if (event.target.classList.contains("viewscs")) {
    const button = event.target;
    const filenamee = button.getAttribute("data-file");

    if (!filenamee) {
      console.error("File tidak ditemukan pada tombol ini.");
      return;
    }

    console.log("Attempting to view file:", filenamee);

    fetch('LuaScript/' + filenamee)
      .then(response => {
        if (!response.ok) throw new Error(`File not found: ${response.status}`);
        return response.text();
      })
      .then(code => {
        document.getElementById("filenamee22").textContent = filenamee;
        document.getElementById("lua-code").textContent = code;
        document.getElementById("code-display").style.display = "block";
        console.log("File viewed successfully:", filenamee);
      })
      .catch(err => console.error("Error viewing file:", err));
  }
});

// Tombol untuk menutup tampilan kode
document.getElementById("close-code-btn").addEventListener("click", function () {
  document.getElementById("code-display").style.display = "none";
});