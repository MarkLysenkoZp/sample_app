document.addEventListener("DOMContentLoaded", () => {
  const colors = [
    "linear-gradient(45deg, #ff9a9e, #fad0c4)",
    "linear-gradient(45deg, #a18cd1, #fbc2eb)",
    "linear-gradient(45deg, #fbc2eb, #ff9a9e)",
  ];

  let index = 0;

  setInterval(() => {
    document.body.style.background = colors[index];
    document.body.style.backgroundSize = "300% 300%";
    document.body.style.transition = "background 2s ease";
    index = (index + 1) % colors.length;
  }, 5000); // Меняет фон каждые 5 секунд
});