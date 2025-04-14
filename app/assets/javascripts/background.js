(function ($) {
  // Run when the DOM is fully loaded
  $(document).ready(function () {
    // For each element with the class 'animated-background', initialize the animation
    $('.animated-background').each(function (index) {
      setupBackground($(this), index);
    });
  });

  // Set up the animated background for a single element
  function setupBackground($el, index) {
    // Create a canvas element
    const canvas = $('<canvas></canvas>')[0];

    // Set the canvas size to match the container
    canvas.width = $el.width();
    canvas.height = $el.height();

    // Insert canvas at the beginning of the container
    $el.prepend(canvas);

    // Get the drawing context
    const ctx = canvas.getContext('2d');

    // Create a grid of hexagons based on the canvas size
    const hexagons = createHexGrid(canvas.width, canvas.height);
    let time = 0;

    // Animation loop
    function drawFrame() {
      // Clear the canvas before each frame
      ctx.clearRect(0, 0, canvas.width, canvas.height);

      // Draw each hexagon with animated fill
      hexagons.forEach(h => drawHex(ctx, h, time));

      // Increment time for animation effect
      time += 0.20;

      // Request the next animation frame
      requestAnimationFrame(drawFrame);
    }

    // Start the animation
    drawFrame();
  }

  // Generate a grid of hexagons to fill the canvas
  function createHexGrid(width, height) {
    const size = 20; // Radius of the hexagon
    const distX = Math.sqrt(3) * size; // Horizontal distance between hex centers
    const distY = size * 1.5;          // Vertical distance between hex centers
    const hexes = [];

    // Loop through grid positions
    for (let x = 0; x < width + distX; x += distX) {
      let offset = false;
      for (let y = 0; y < height + distY; y += distY) {
        // Offset every other row to create a honeycomb pattern
        const dx = offset ? distX / 2 : 0;

        // Store hexagon position and size
        hexes.push({ x: x + dx, y, size });

        offset = !offset;
      }
    }

    return hexes;
  }

  // Draw a single hexagon at a given position
  function drawHex(ctx, hex, time) {
    const { x, y, size } = hex;

    // Calculate dynamic opacity based on time and position
    const a = 0.3 + 0.2 * Math.sin(time + x / 50 + y / 50);

    // Fill and border colors
    const fill = `rgba(200, 200, 200, ${a.toFixed(2)})`;
    const stroke = 'rgba(0, 0, 0, 0.15)';

    // Start drawing path
    ctx.beginPath();

    // Draw 6 sides of the hexagon
    for (let i = 0; i < 6; i++) {
      const angle = Math.PI / 3 * i;
      const px = x + size * Math.cos(angle);
      const py = y + size * Math.sin(angle);
      ctx.lineTo(px, py);
    }

    ctx.closePath();

    // Fill with animated color
    ctx.fillStyle = fill;
    ctx.fill();

    // Draw border
    ctx.strokeStyle = stroke;
    ctx.stroke();
  }
})(jQuery);
