$(function(){
  // コンセプトcheckboxがチェックされたら、フォームをグレーアウトさせる
  var conceptCheckbox = document.querySelector('.checkbox__work_concept')
  var conceptForm = document.querySelector('#work_create_concept')
  conceptCheckbox.addEventListener('change', function() {
    var check = this.checked
    if (check) {
      conceptForm.value = 'checkされてますやん'
    } else {
      conceptForm.value = 'されてなーーい'
    }
  });
});
