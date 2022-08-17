import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="groups--from-modal"
export default class extends Controller {
    connect() {
    }

    close(e) {
        e.preventDefault()
        this.element.remove()
    }
}
