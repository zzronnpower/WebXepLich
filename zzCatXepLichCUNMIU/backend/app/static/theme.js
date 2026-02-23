(function () {
  var storageKey = "cunmiu_theme";
  var themes = ["default", "pinky", "light-green"];

  function syncBodyClass(theme) {
    if (!document.body) return;
    Array.prototype.slice
      .call(document.body.classList)
      .filter(function (name) {
        return name.indexOf("theme-") === 0;
      })
      .forEach(function (name) {
        document.body.classList.remove(name);
      });
    document.body.classList.add("theme-" + theme);
  }

  function applyTheme(theme) {
    var next = themes.indexOf((theme || "").toLowerCase()) >= 0 ? theme.toLowerCase() : "default";
    document.documentElement.setAttribute("data-theme", next);
    syncBodyClass(next);
    localStorage.setItem(storageKey, next);
  }

  function currentTheme() {
    var saved = (localStorage.getItem(storageKey) || "default").toLowerCase();
    return themes.indexOf(saved) >= 0 ? saved : "default";
  }

  function mountThemeDock() {
    if (document.getElementById("theme-dock")) return;
    var dock = document.createElement("div");
    dock.id = "theme-dock";
    dock.className = "theme-dock";
    dock.innerHTML = '<label for="theme-select">Theme</label><select id="theme-select"><option value="default">Default</option><option value="pinky">Pinky</option><option value="light-green">Light Green</option></select>';
    document.body.appendChild(dock);
    var select = document.getElementById("theme-select");
    select.value = currentTheme();
    select.addEventListener("change", function () {
      applyTheme(select.value);
    });
  }

  document.addEventListener("DOMContentLoaded", function () {
    applyTheme(currentTheme());
    mountThemeDock();
  });

  if (document.readyState === "interactive" || document.readyState === "complete") {
    applyTheme(currentTheme());
    mountThemeDock();
  }
})();
