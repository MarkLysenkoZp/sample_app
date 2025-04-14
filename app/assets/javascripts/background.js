(function ($) {
  $(document).ready(function () {
    $('.animated-background').each(function (index) {
      setupBackground($(this), index);
    });
  });

  function setupBackground($el, index) {
    const canvas = $('<canvas></canvas>')[0];
    canvas.width = $el.width();
    canvas.height = $el.height();
    $el.prepend(canvas);

    const ctx = canvas.getContext('2d');
    const hexagons = createHexGrid(canvas.width, canvas.height);
    let time = 0;

    function drawFrame() {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      hexagons.forEach(h => drawHex(ctx, h, time));
      time += 0.20;
      requestAnimationFrame(drawFrame);
    }

    drawFrame();
  }

  function createHexGrid(width, height) {
    const size = 20;
    const distX = Math.sqrt(3) * size;
    const distY = size * 1.5;
    const hexes = [];

    for (let x = 0; x < width + distX; x += distX) {
      let offset = false;
      for (let y = 0; y < height + distY; y += distY) {
        const dx = offset ? distX / 2 : 0;
        hexes.push({ x: x + dx, y, size });
        offset = !offset;
      }
    }
    return hexes;
  }

  function drawHex(ctx, hex, time) {
    const { x, y, size } = hex;
    const a = 0.3 + 0.2 * Math.sin(time + x / 50 + y / 50);
    const fill = `rgba(200, 200, 200, ${a.toFixed(2)})`;
    const stroke = 'rgba(0, 0, 0, 0.15)';

    ctx.beginPath();
    for (let i = 0; i < 6; i++) {
      const angle = Math.PI / 3 * i;
      const px = x + size * Math.cos(angle);
      const py = y + size * Math.sin(angle);
      ctx.lineTo(px, py);
    }
    ctx.closePath();
    ctx.fillStyle = fill;
    ctx.fill();
    ctx.strokeStyle = stroke;
    ctx.stroke();
  }
})(jQuery);
