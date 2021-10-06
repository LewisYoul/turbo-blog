import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    console.log('search')
  }

  submitEnd(event) {
    let formData = event.detail.formSubmission.formData
    formData.delete('authenticity_token')
    formData.delete('commit')

    const baseUrl = window.location.origin + window.location.pathname
    const queryString = new URLSearchParams(formData).toString()
    const searchUrl = `${baseUrl}?${queryString}`

    history.pushState({}, null, searchUrl);
  }
}
