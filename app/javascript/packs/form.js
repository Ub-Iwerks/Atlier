$(function(){
  // コンセプトcheckboxがチェックされたら、フォームをグレーアウトさせる
  var conceptCheckbox = document.querySelector('.checkbox__work_concept')
  var conceptForm = document.querySelector('#work_create_concept')
  conceptCheckbox.addEventListener('change', function() {
    if (this.checked) conceptForm.disabled = true;
    else conceptForm.disabled = false;
  });
});
