// set la class dark en fonction de localstorage.theme
if (
  localStorage.theme === "dark" ||
  (!("theme" in localStorage) &&
    window.matchMedia("(prefers-color-scheme: dark)").matches)
) {
  document.documentElement.classList.add("dark");
} else {
  document.documentElement.classList.remove("dark");
}

// fonction btn dark
function switchModeDark() {
  const btnSwitch = document.querySelector(".active-mode-dark");

  btnSwitch?.addEventListener("click", () => {
    document.documentElement.classList.toggle("dark");
  });
}

switchModeDark();
