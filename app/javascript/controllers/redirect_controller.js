import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['close', 'title']

  close() {
    if(this.titleTarget.value) {
      this.closeTarget.click()
    }
  }
}
