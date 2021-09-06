import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    console.log('connect')
  }

  select(event) {
    const optionsArray = Array.from(event.currentTarget.options)
    const selectedOptions = optionsArray.filter(option => option.selected)

    console.log(selectedOptions)
  }
}