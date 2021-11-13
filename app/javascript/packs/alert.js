$(function(){
  function alertSize(fileField) {
    alert("最大サイズは5MBです。それ以下を選択して下さい。");
    fileField.value = ''
  }
  var targetImageFields = document.querySelectorAll(".image__field");
  targetImageFields.forEach(selector => {
    selector.addEventListener('change', function() {
      var size_in_megabytes = this.files[0].size/1024/1024;
      if (size_in_megabytes > 5) alertSize(this);
    });
  });
});
