$(function(){
  // 変更の方向性
  // セレクターが変更されたら、発火する。
  // FileReaderで選択された画像を取得する
  // 取得したfileが存在する場合、img.previewのsrc属性を変更する
    // var preview = img.preview
    // 上記previewのsrc属性を取得したファイルパスに変更する
  // 取得したfileが存在しない場合、取得前のファイルに戻す。（もしくは変更しない）

  // 注意点
  // document.getElementByClassName('~')で取得できるプロトタイプは、HTMLcollection
  // 変更で必要なターゲットは、HTMLcollection(0)である、要素そのもの。




  // $(document).on('turbolinks:load', function () {
  // 公式の書き方を真似て記したプレビュー画像表示
  // https://developer.mozilla.org/ja/docs/Web/API/FileReader/readAsDataURL
  // var targetImageFields = document.querySelectorAll(".image__field");
  // targetImageFields.forEach(selector => {
  //   function previewFile() {
  //     var preview = document.querySelector('.prev-work');
  //     var file = selector.files[0];
  //     var reader = new FileReader();

  //     reader.addEventListener("load", function () {
  //       preview.src = reader.result;
  //     }, false);

  //     if (file) reader.readAsDataURL(file);
  //   }
  //   selector.addEventListener('change', previewFile() )
  // });

  // こんんソールで確認しながら処理をつなげていこう！

  // $(function () {
  //   function buildHTML(image) {
  //     var html =
  //       `
  //       <div class="prev-content">
  //         <img src="${image}", alt="preview" class="prev-image">
  //       </div>
  //       `
  //     return html;
  //   }
  //   $(document).on('change', '.hidden_file', function () {
  //     var file = this.files[0];
  //     var reader = new FileReader();
  //     reader.readAsDataURL(file);
  //     reader.onload = function () {
  //       var image = this.result;
  //       if ($('.prev-content').length == 0) {
  //         var html = buildHTML(image)
  //         $('.prev-contents').prepend(html);
  //       } else {
  //         $('.prev-content .prev-image').attr({ src: image });
  //       }
  //     }
  //   });
  // });


  // これがメイン画像のプレビューを表示するimgタグ
  // document.querySelectorAll(".prev-work");
  // これがメイン画像のセレクトタグ
  // document.querySelectorAll("#work_create_image");

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

  // $(function () {
  //   function buildHTML(image) {
  //     var html =
  //       `
  //       <div class="prev-content">
  //         <img src="${image}", alt="preview" class="prev-0">
  //       </div>
  //       `
  //     return html;
  //   }
  //   $(document).on('change', '#work_create_illustrations_attributes_0_photo', function () {
  //     var file = this.files[0];
  //     var reader = new FileReader();
  //     reader.readAsDataURL(file);
  //     reader.onload = function () {
  //       var image = this.result;
  //       if ($('.prev-content').length == 0) {
  //         var html = buildHTML(image)
  //         $('.prev-contents').prepend(html);
  //       } else {
  //         $('.prev-content .prev-0').attr({ src: image });
  //       }
  //     }
  //   });
  // });

  // $(function () {
  //   function buildHTML(image) {
  //     var html =
  //       `
  //       <div class="prev-content">
  //         <img src="${image}", alt="preview" class="prev-1">
  //       </div>
  //       `
  //     return html;
  //   }
  //   $(document).on('change', '#work_create_illustrations_attributes_1_photo', function () {
  //     var file = this.files[0];
  //     var reader = new FileReader();
  //     reader.readAsDataURL(file);
  //     reader.onload = function () {
  //       var image = this.result;
  //       if ($('.prev-content').length == 0) {
  //         var html = buildHTML(image)
  //         $('.prev-contents').prepend(html);
  //       } else {
  //         $('.prev-content .prev-1').attr({ src: image });
  //       }
  //     }
  //   });
  // });

  // $(function () {
  //   function buildHTML(image) {
  //     var html =
  //       `
  //       <div class="prev-content">
  //         <img src="${image}", alt="preview" class="prev-2">
  //       </div>
  //       `
  //     return html;
  //   }
  //   $(document).on('change', '#work_create_illustrations_attributes_2_photo', function () {
  //     var file = this.files[0];
  //     var reader = new FileReader();
  //     reader.readAsDataURL(file);
  //     reader.onload = function () {
  //       var image = this.result;
  //       if ($('.prev-content').length == 0) {
  //         var html = buildHTML(image)
  //         $('.prev-contents').prepend(html);
  //       } else {
  //         $('.prev-content .prev-2').attr({ src: image });
  //       }
  //     }
  //   });
  // });

  // $(function () {
  //   function buildHTML(image) {
  //     var html =
  //       `
  //       <div class="prev-content">
  //         <img src="${image}", alt="preview" class="prev-3">
  //       </div>
  //       `
  //     return html;
  //   }
  //   $(document).on('change', '#work_create_illustrations_attributes_3_photo', function () {
  //     var file = this.files[0];
  //     var reader = new FileReader();
  //     reader.readAsDataURL(file);
  //     reader.onload = function () {
  //       var image = this.result;
  //       if ($('.prev-content').length == 0) {
  //         var html = buildHTML(image)
  //         $('.prev-contents').prepend(html);
  //       } else {
  //         $('.prev-content .prev-3').attr({ src: image });
  //       }
  //     }
  //   });
  // });

  // $(function () {
  //   function buildHTML(image) {
  //     var html =
  //       `
  //       <div class="prev-content">
  //         <img src="${image}", alt="preview" class="prev-4">
  //       </div>
  //       `
  //     return html;
  //   }
  //   $(document).on('change', '#work_create_illustrations_attributes_4_photo', function () {
  //     var file = this.files[0];
  //     var reader = new FileReader();
  //     reader.readAsDataURL(file);
  //     reader.onload = function () {
  //       var image = this.result;
  //       if ($('.prev-content').length == 0) {
  //         var html = buildHTML(image)
  //         $('.prev-contents').prepend(html);
  //       } else {
  //         $('.prev-content .prev-4').attr({ src: image });
  //       }
  //     }
  //   });
  // });
});
