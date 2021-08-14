const { get } = require("jquery")

window.addEventListener('turbo:load', () => {
  // 打開 new task modal 清空裡面的 value
  $('#new_task_btn').on('click', function(){
    // $('#task_title').val('')
    $('#task_tag_list').val(null).trigger('change')
  })
})