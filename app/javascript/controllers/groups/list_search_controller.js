import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="groups--list-search"
export default class extends Controller {
    static targets = ["form", "type"]

    connect() {
        this.typeTarget.addEventListener("change", () => {
            this.submitForm()
        })
        this.triggerTypeChange()
    }

    submitForm() {
        this.formTarget.requestSubmit()
    }

    triggerTypeChange() {
        this.typeTarget.dispatchEvent(new Event("change"));
    }

}
