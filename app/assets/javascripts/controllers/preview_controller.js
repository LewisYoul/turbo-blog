import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['writeTab', 'previewTab', 'previewFormButton', 'previewFormMarkdown', 'preview', 'body']
  static values = { href: String }

  connect() {
    this.isWriting = true
  }

  setFormParams(event) {
    this.previewFormMarkdownTarget.value = event.currentTarget.value
  }
  
  preview() {
    if (!this.isWriting) return

    this.previewFormButtonTarget.click()
  }

  previewComplete() {
    setTimeout(() => {
      this.toggleClasses()
      this.isWriting = false
    }, 150)
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