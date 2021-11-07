$(function(){
  // TODO: 上手く引数が反映されていない（target, thisなど）
  function alertSize(fileField) {
    alert("最大サイズは5MBです。それ以下を選択して下さい。");
    fileField.value = ''
  }
  $(".image__field").on("change", function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) alertSize(this);
  });
});
