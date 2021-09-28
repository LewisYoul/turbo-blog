import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['writeTab', 'previewTab', 'previewForm', 'previewFormButton', 'preview', 'body']
  static values = { href: String }

  connect() {
    this.isWriting = true
  }

  setFormParams(event) {
    const encodedMarkdown = encodeURIComponent(event.currentTarget.value)
    this.previewFormTarget.action = `${this.hrefValue}?markdown=${encodedMarkdown}`
  }
  
  preview() {
    if (!this.isWriting) return

    this.previewFormButtonTarget.click()
  }

  previewComplete() {
    setTimeout(() => this.toggleClasses(), 150)
    this.previewFormTarget.reset()

    this.isWriting = false
  }
  
  write() {
    if (this.isWriting) return
    
    this.toggleClasses()

    this.isWriting = true
  }

  toggleClasses() {
    this.writeTabTarget.classList.toggle('bg-gray-100')
    this.previewTabTarget.classList.toggle('bg-gray-100')
    this.bodyTarget.classList.toggle('hidden')
    this.previewTarget.classList.toggle('hidden')
  }
}