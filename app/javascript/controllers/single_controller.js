import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    $(this.element).select2({
      placeholder: '請選擇一個標籤',
      allowClear: true,
      tags: true,
      tokenSeparators: [',', ' '],
    })
  }
}
