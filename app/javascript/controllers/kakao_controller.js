import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { image: String }
  connect() {
    if (!Kakao.isInitialized()) {
      Kakao.init('6e36c4ff9ea895eb794bfe234c1d2222');
    }
  }

  post(e) {
    e.preventDefault()

    console.log(this.imageValue)
    Kakao.Link.sendScrap({
      requestUrl: this.imageValue
    })
  }
}
