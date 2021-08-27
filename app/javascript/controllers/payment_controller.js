import { Controller } from "stimulus"
import dropin from "braintree-web-drop-in"

export default class extends Controller {
  static targets = ["dropin", "nonce"]
  static values = { token: String }

  connect() {
    dropin
      .create({
        container: this.dropinTarget,
        authorization: this.tokenValue,
      })
      .then((dropinInstance) => {
        this.element.addEventListener("submit", (e) => {
          e.preventDefault()
          dropinInstance
            .requestPaymentMethod()
            .then((payload) => {
              this.nonceTarget.value = payload.nonce
              this.element.submit()
            })
            .catch((err) => console.error(err))
        })

        // console.log(dropin.create)
        // console.log("hi")
      })
  }
}
