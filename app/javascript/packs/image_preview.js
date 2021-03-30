$(document).on('turbolinks:load', function () {
  $(function () {
    function buildHTML(image) {
      var html =
        `
        <div class="prev-content">
          <img src="${image}", alt="preview" class="prev-image">
        </div>
        `
      return html;
    }
    $(document).on('change', '.hidden_file', function () {
      var file = this.files[0];
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function () {
        var image = this.result;
        if ($('.prev-content').length == 0) {
          var html = buildHTML(image)
          $('.prev-contents').prepend(html);
        } else {
          $('.prev-content .prev-image').attr({ src: image });
        }
      }
    });
  });

  $(function () {
    function buildHTML(image) {
      var html =
        `
        <div class="prev-content">
          <img src="${image}", alt="preview" class="prev-work">
        </div>
        `
      return html;
    }
    $(document).on('change', '.hidden_work', function () {
      var file = this.files[0];
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function () {
        var image = this.result;
        if ($('.prev-content').length == 0) {
          var html = buildHTML(image)
          $('.prev-contents').prepend(html);
        } else {
          $('.prev-content .prev-work').attr({ src: image });
        }
      }
    });
  });

  $(function () {
    function buildHTML(image) {
      var html =
        `
        <div class="prev-content">
          <img src="${image}", alt="preview" class="prev-illustration">
        </div>
        `
      return html;
    }
    $(document).on('change', '.hidden_illustration1', function () {
      var file = this.files[0];
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function () {
        var image = this.result;
        if ($('.prev-content').length == 0) {
          var html = buildHTML(image)
          $('.prev-contents').prepend(html);
        } else {
          $('.prev-content .prev-illustration').attr({ src: image });
        }
      }
    });
  });

});