$(document).on('turbolinks:load', function () {
  $(function(){
    function getOption(category){
      var html = `<option value="${category.id}">${category.name}</option>`;
      return html;
    }
    function removeOptions(select_id){
      var options = document.getElementById(select_id).children;
      for (let count = options.length; count > 1; count--) {
        options[1].remove();
      }
    }
    function changeOptoins(parent_category_id, child_category_id){
      var parentId = document.getElementById(parent_category_id).value;
      if (parentId != ""){
        $.ajax({
          url: '/works/get_category_children/',
          type: 'GET',
          data: { parent_id: parentId },
          dataType: 'json'
        })
        .done(function(children){
          removeOptions(child_category_id);
          var first_option = document.getElementById(child_category_id).children[0];
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += getOption(child);
          });
          first_option.insertAdjacentHTML('afterend', insertHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        removeOptions(child_category_id);
      }
    }

    $("#parent_category_id").on('change', function(){
      changeOptoins('parent_category_id', 'work_create_category_id')
    });
    $("#work_search_parent_category_id").on('change', function(){
      changeOptoins('work_search_parent_category_id', 'work_search_category_id')
    });
  });
});