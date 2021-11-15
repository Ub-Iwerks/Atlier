$(function(){
  function alertSize(fileField) {
    alert("最大サイズは5MBです。それ以下を選択して下さい。");
    fileField.value = ''
  }

  var targetImageFields = document.querySelectorAll(".image__field");
  targetImageFields.forEach(selector => {

    // 5MB以上でアラートを表示するメソッドを設置
    selector.addEventListener('change', function() {
      var size_in_megabytes = this.files[0].size/1024/1024;
      if (size_in_megabytes > 5) alertSize(this);
    });

    // 画像のプレビューを表示するメソッド
    selector.addEventListener('change', function() {
      // TODO: HTMLの順番に依存しているから、改善が必要
      var previewImg = this.previousElementSibling;
      var file = this.files[0];
      var reader = new FileReader();

      // 画像が変更され、その読み込みが行われるタイミング（readAsDataURL）で発火。
      reader.addEventListener("load", function () {
        imageURL = reader.result
        previewImg.setAttribute('src', imageURL)
      }, false);

      if (file) reader.readAsDataURL(file);
    });
  });
});
