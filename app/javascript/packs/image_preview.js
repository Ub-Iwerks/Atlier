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
    $(document).on('change', '#work_create_image', function () {
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
          <img src="${image}", alt="preview" class="prev-0">
        </div>
        `
      return html;
    }
    $(document).on('change', '#work_create_illustrations_attributes_0_photo', function () {
      var file = this.files[0];
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function () {
        var image = this.result;
        if ($('.prev-content').length == 0) {
          var html = buildHTML(image)
          $('.prev-contents').prepend(html);
        } else {
          $('.prev-content .prev-0').attr({ src: image });
        }
      }
    });
  });

  $(function () {
    function buildHTML(image) {
      var html =
        `
        <div class="prev-content">
          <img src="${image}", alt="preview" class="prev-1">
        </div>
        `
      return html;
    }
    $(document).on('change', '#work_create_illustrations_attributes_1_photo', function () {
      var file = this.files[0];
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function () {
        var image = this.result;
        if ($('.prev-content').length == 0) {
          var html = buildHTML(image)
          $('.prev-contents').prepend(html);
        } else {
          $('.prev-content .prev-1').attr({ src: image });
        }
      }
    });
  });

  $(function () {
    function buildHTML(image) {
      var html =
        `
        <div class="prev-content">
          <img src="${image}", alt="preview" class="prev-2">
        </div>
        `
      return html;
    }
    $(document).on('change', '#work_create_illustrations_attributes_2_photo', function () {
      var file = this.files[0];
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function () {
        var image = this.result;
        if ($('.prev-content').length == 0) {
          var html = buildHTML(image)
          $('.prev-contents').prepend(html);
        } else {
          $('.prev-content .prev-2').attr({ src: image });
        }
      }
    });
  });

  $(function () {
    function buildHTML(image) {
      var html =
        `
        <div class="prev-content">
          <img src="${image}", alt="preview" class="prev-3">
        </div>
        `
      return html;
    }
    $(document).on('change', '#work_create_illustrations_attributes_3_photo', function () {
      var file = this.files[0];
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function () {
        var image = this.result;
        if ($('.prev-content').length == 0) {
          var html = buildHTML(image)
          $('.prev-contents').prepend(html);
        } else {
          $('.prev-content .prev-3').attr({ src: image });
        }
      }
    });
  });

  $(function () {
    function buildHTML(image) {
      var html =
        `
        <div class="prev-content">
          <img src="${image}", alt="preview" class="prev-4">
        </div>
        `
      return html;
    }
    $(document).on('change', '#work_create_illustrations_attributes_4_photo', function () {
      var file = this.files[0];
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function () {
        var image = this.result;
        if ($('.prev-content').length == 0) {
          var html = buildHTML(image)
          $('.prev-contents').prepend(html);
        } else {
          $('.prev-content .prev-4').attr({ src: image });
        }
      }
    });
  });
});