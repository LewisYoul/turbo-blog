import { Controller } from "stimulus"

export default class extends Controller {
  static values = { text: String }

  confirm(event) {
    const confirmation = window.confirm(this.textValue)

    if (!confirmation) { event.preventDefault() }
  }
}