(function ($) {
  $(document).ready(function () {
    $('.animated-background').each(function (index) {
      const $this = $(this);
      const canvas = $("<canvas></canvas>").attr("id", "can" + index)[0];
      $this.prepend(canvas);

      const ctx = canvas.getContext("2d");
      let w = canvas.width = $this.width();
      let h = canvas.height = $this.height();

      const side = 16;
      const difX = Math.sqrt(3) * side / 2;
      const difY = side * 3 / 2;
      const cos = Math.cos(Math.PI / 6) * side;
      const sin = Math.sin(Math.PI / 6) * side;

      const colorSet = $this.data("color") === "red"
        ? ['rgba(206, 23, 41, 0)', 'rgba(193, 23, 43, 0)']
        : ['rgba(245, 245, 245, alp)', 'rgba(229, 229, 229, alp)'];

      const strokeColor = $this.data("color") === "red"
        ? 'rgb(185, 185, 185)'
        : 'rgba(245,245,245, 0.5)';

      const opts = {
        picksPerTick: 8,
        baseTime: 200,
        addedTime: 5,
        colors: colorSet,
        strokeColor: strokeColor,
        hueSpeed: 0.1
      };

      const hexes = [];

      class Hex {
        constructor(x, y) {
          this.x = x;
          this.y = y;
          this.reset();

          this.xs = [x + cos, x, x - cos, x - cos, x, x + cos];
          this.ys = [y - sin, y - side, y - sin, y + sin, y + side, y + sin];
        }

        reset() {
          this.picked = false;
          this.time = 0;
          this.targetTime = 0;
        }

        pick() {
          this.color = opts.colors[Math.random() * opts.colors.length | 0];
          this.picked = true;
          this.time = 0;
          this.targetTime = opts.baseTime + Math.random() * opts.addedTime | 0;
        }

        step() {
          const progress = this.time / this.targetTime;

          ctx.beginPath();
          ctx.moveTo(this.xs[0], this.ys[0]);
          for (let i = 1; i < 6; i++) {
            ctx.lineTo(this.xs[i], this.ys[i]);
          }
          ctx.closePath();

          if (this.picked) {
            this.time++;
            if (this.time >= this.targetTime) this.reset();

            const alpha = Math.sin(progress * Math.PI);
            ctx.fillStyle = ctx.shadowColor = this.color.replace('alp', alpha);
            ctx.fill();
          } else {
            ctx.strokeStyle = ctx.shadowColor = opts.strokeColor;
            ctx.stroke();
          }
        }
      }

      function generateHexes() {
        hexes.length = 0;
        for (let x = 0; x < w; x += difX * 2) {
          let offset = false;
          for (let y = 0; y < h; y += difY) {
            hexes.push(new Hex(x + (offset ? difX : 0), y));
            offset = !offset;
          }
        }
      }

      function loop() {
        requestAnimationFrame(loop);
        ctx.fillStyle = 'rgba(255,255,255,0.9)';
        ctx.fillRect(0, 0, w, h);

        for (let i = 0; i < opts.picksPerTick; i++) {
          hexes[Math.random() * hexes.length | 0].pick();
        }

        hexes.forEach(hex => hex.step());
      }

      generateHexes();
      loop();

      $(window).on('resize', function () {
        w = canvas.width = window.innerWidth;
        h = canvas.height = window.innerHeight;
        generateHexes();
      });
    });
  });
})(jQuery);
