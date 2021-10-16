import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['openIcon', 'closedIcon', 'option', 'options', 'check', 'spacer']
  static classes = ['selected']
  static values = { selected: Boolean }

  toggle() {
    this.openIconTarget.classList.toggle('hidden')
    this.closedIconTarget.classList.toggle('hidden')
    this.optionsTarget.classList.toggle('hidden')
  }

  toggleSelection(event) {
    event.stopPropagation()

    const optionElement = event.currentTarget
    const index = this.optionTargets.indexOf(optionElement)
    const option = this.optionTargets[index]
    const check = this.checkTargets[index]
    const spacer = this.spacerTargets[index]

    option.classList.toggle(this.selectedClass)
    check.classList.toggle('hidden')
    spacer.classList.toggle('hidden')
  }
}