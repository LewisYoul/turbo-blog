import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['select', 'tag', 'check', 'cross', 'iconWrapper', 'tagsCount']
  static classes = ['selected', 'deselected']
  static values = { name: String, count: Number }

  toggle(event) {
    const tagElement = event.currentTarget
    const index = this.tagTargets.indexOf(tagElement)
    const option = this.options().find(option => tagElement.dataset.tagsIdValue == option.value)
    
    tagElement.classList.toggle(this.deselectedClass)
    tagElement.classList.toggle(this.selectedClass)
    this.checkTargets[index].classList.toggle('hidden')
    this.crossTargets[index].classList.toggle('hidden')
    this.iconWrapperTargets[index].classList.toggle('text-green-400')
    this.iconWrapperTargets[index].classList.toggle('text-pink-400')
    tagElement.classList.toggle('hover:bg-pink-200')
    tagElement.classList.toggle('hover:bg-green-200')

    option.selected ? this.countValue -= 1 : this.countValue += 1

    this.tagsCountTarget.innerHTML = `Tags ${this.countValue}`
    option.selected = !option.selected

    const changeEvent = new Event('change')
    this.selectTarget.form.dispatchEvent(changeEvent)
  }

  options() {
    return Array.from(this.selectTarget.options)
  }
}