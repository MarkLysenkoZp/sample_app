document.addEventListener("turbolinks:load", function () {
  applyDarkMode();
});

function applyDarkMode() {
  const toggleBtn = document.getElementById("theme-toggle");
  const body = document.body;

  if (!toggleBtn) return;

  const savedTheme = localStorage.getItem('theme');
  if (savedTheme === 'dark') {
    body.classList.add('dark-mode');
    toggleBtn.textContent = '☀️ Light Mode';
  } else {
    body.classList.remove('dark-mode');
    toggleBtn.textContent = '🌙 Dark Mode';
  }

  // Удалим предыдущий обработчик, если есть (простой способ — через проверку флага)
  if (!toggleBtn.hasAttribute('data-listener')) {
    toggleBtn.addEventListener('click', () => {
      body.classList.toggle('dark-mode');

      if (body.classList.contains('dark-mode')) {
        localStorage.setItem('theme', 'dark');
        toggleBtn.textContent = '☀️ Light Mode';
      } else {
        localStorage.setItem('theme', 'light');
        toggleBtn.textContent = '🌙 Dark Mode';
      }
    });

    toggleBtn.setAttribute('data-listener', 'true'); // помечаем, что уже навесили
  }
}
