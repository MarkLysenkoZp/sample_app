document.addEventListener("DOMContentLoaded", function () {
    const toggleBtn = document.getElementById("theme-toggle");
    const bg = document.getElementById("animated-background");
    const currentTheme = localStorage.getItem("theme") || "light";
    
    bg.classList.add(`${currentTheme}-mode`);
    toggleBtn.textContent = currentTheme === "dark" ? "☀️" : "🌙";

    toggleBtn.addEventListener("click", () => {
      const isDark = bg.classList.contains("dark-mode");
      bg.classList.toggle("dark-mode", !isDark);
      bg.classList.toggle("light-mode", isDark);
      toggleBtn.textContent = isDark ? "🌙" : "☀️";
      localStorage.setItem("theme", isDark ? "light" : "dark");
    });
  });