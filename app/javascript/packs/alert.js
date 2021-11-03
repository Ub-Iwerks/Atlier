$(function(){
  // TODO: 上手く引数が反映されていない（target, thisなど）
  function alertSize(target) {
    var size_in_megabytes = target.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert("最大サイズは5MBです。それ以下を選択して下さい。");
      $(target).val("");
    }
  }
  $("#work_create_image").bind("change", function() {
    alertSize(this.id);
  })
  $("#work_create_illustrations_attributes_0_photo").bind("change", function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert("最大サイズは5MBです。それ以下を選択して下さい。");
      $("#work_create_illustrations_attributes_0_photo").val("");
    }
  });
  $("#work_create_illustrations_attributes_1_photo").bind("change", function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert("最大サイズは5MBです。それ以下を選択して下さい。");
      $("#work_create_illustrations_attributes_1_photo").val("");
    }
  });
  $("#work_create_illustrations_attributes_2_photo").bind("change", function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert("最大サイズは5MBです。それ以下を選択して下さい。");
      $("#work_create_illustrations_attributes_2_photo").val("");
    }
  });
  $("#work_create_illustrations_attributes_3_photo").bind("change", function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert("最大サイズは5MBです。それ以下を選択して下さい。");
      $("#work_create_illustrations_attributes_3_photo").val("");
    }
  });
  $("#work_create_illustrations_attributes_4_photo").bind("change", function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert("最大サイズは5MBです。それ以下を選択して下さい。");
      $("#work_create_illustrations_attributes_4_photo").val("");
    }
  });
});