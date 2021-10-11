import { Controller } from "stimulus"

export default class extends Controller {
  submit() {
    this.element.querySelector('input[type="submit"]').click()
  }

  submitEnd(event) {
    let formData = event.detail.formSubmission.formData
    formData.delete('authenticity_token')
    formData.delete('commit')

    if (!formData.get('search_term')) { formData.delete('search_term') }

    const baseUrl = window.location.origin + window.location.pathname
    const queryString = new URLSearchParams(formData).toString()
    const searchUrl = `${baseUrl}?${queryString}`

    history.pushState({}, null, searchUrl);
  }
}
