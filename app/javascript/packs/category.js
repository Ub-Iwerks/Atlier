$(document).on('turbolinks:load', function () {
  $(function(){
    function appendOption(category){
      var html = `<option value="${category.id}">${category.name}</option>`;
      return html;
    }
    function appendChildrenBox(insertHTML){
      var childSelectHtml = "";
      childSelectHtml = `<div class="category__child category__select" id="children_wrapper">
                          <select class="select_field" name="work_create[category_id]" id="child__category">
                            <option value="">&emsp;サブカテゴリー&emsp;</option>
                            ${insertHTML}
                          </select>
                        </div>`;
      $('.field--category').append(childSelectHtml);
    }
    $("#parent_category_id").on('change',function(){
      var parentId = document.getElementById('parent_category_id').value;
      if (parentId != ""){
        $.ajax({
          url: '/works/get_category_children/',
          type: 'GET',
          data: { parent_id: parentId },
          dataType: 'json'
        })
        .done(function(children){
          $('#children_wrapper').remove();
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChildrenBox(insertHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#children_wrapper').remove();
      }
    });
  });
});