// Entry point for the build script in your package.json
import * as ActiveStorage from "@rails/activestorage"
import "@hotwired/turbo-rails"
import 'bootstrap/js/dist/dropdown'
import 'bootstrap/js/dist/collapse'
import './scripts/select'

ActiveStorage.start()
