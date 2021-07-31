import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['messageWrapper', 'message']
  static values = {
    alert: String,
    notice: String
  }

  connect() {
    console.log('connext')
    if (this.alertValue || this.noticeValue) {
      this.showToast()
    }
  }

  showToast() {
    console.log('displaying toast')

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
    return this.alertValue ? ['bg-red-50', 'border-red-500'] : ['bg-green-50', 'border-green-500']
  }
}