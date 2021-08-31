import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['messageWrapper', 'message']
  static values = {
    alert: String,
    notice: String
  }

  connect() {
    if (this.alertValue || this.noticeValue) {
      this.showToast()
    }
  }

  showToast() {
    this.messageTarget.innerHTML = this.alertValue || this.noticeValue
    this.messageWrapperTarget.classList.add(...this.classesForToastType())
    this.element.classList.remove('hidden')

    this.setToastTimeout()
  }

  setToastTimeout() {
    const timeout = 8000

    setTimeout(() => {
      this.messageTarget.innerHTML = ''
      this.messageWrapperTarget.classList.remove(...this.classesForToastType())
      this.element.classList.add('hidden')
    }, timeout)
  }

  classesForToastType() {
    return this.alertValue ? ['bg-red-100'] : ['bg-green-100']
  }
}