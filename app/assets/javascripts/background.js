(function ($) {
  document.addEventListener("turbolinks:load", function () {
    $('.animated-background').each(function () {
      setupAnimatedGradient($(this));
    });
  });

  function setupAnimatedGradient($el) {
    const canvas = $('<canvas></canvas>')[0];
    canvas.width = $el.width();
    canvas.height = $el.height();
    $el.prepend(canvas);

    const ctx = canvas.getContext('2d');
    let time = 0;

    function drawFrame() {
      const width = canvas.width;
      const height = canvas.height;

      ctx.clearRect(0, 0, width, height);

      const cx = width / 2 + Math.sin(time / 50) * 100;
      const cy = height / 2 + Math.cos(time / 60) * 100;

      const gradient = ctx.createRadialGradient(cx, cy, 0, cx, cy, width);
      gradient.addColorStop(0, 'rgba(0,113,255,0.4)');
      gradient.addColorStop(1, 'rgba(0,0,0,0)');

      ctx.fillStyle = gradient;
      ctx.fillRect(0, 0, width, height);

      time += 1;
      requestAnimationFrame(drawFrame);
    }

    drawFrame();
  }
})(jQuery);
