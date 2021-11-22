$(function(){
  // コンセプトcheckboxがチェックされたら、フォームをグレーアウトさせる
  var conceptCheckbox = document.getElementsByClassName('checkbox__work_concept')[0]
  var conceptForm = document.querySelector('#work_create_concept')
  conceptCheckbox.addEventListener('change', function() {
    if (this.checked) conceptForm.disabled = true;
    else conceptForm.disabled = false;
  });
});
