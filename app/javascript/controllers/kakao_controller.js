import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { image: String }
  connect() {
    if (!Kakao.isInitialized()) {
      Kakao.init('54fa60f20d8980459e780d9a7e27df2c');
    }
  }

  async post(e) {
    e.preventDefault()

    console.log(this.imageValue)
    Kakao.Link.sendScrap({
      requestUrl: this.imageValue
    })
  }
}
