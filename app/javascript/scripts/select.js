import TomSelect from 'tom-select/dist/js/tom-select.popular'
import Translations from './i18n/select.json'

let selects = []

document.addEventListener("turbo:before-cache", function() {
  selects.forEach((select) => {
    select.destroy()
  })
})

const rerender = function() {
  const i18n = Translations[document.querySelector('body').dataset.lang]

  document.querySelectorAll('select.js-multiple-select').forEach((element) => {
    if(!element.classList.contains('tomselected')) {
      let opts = {
        plugins: {
          'remove_button': {
            title: i18n['remove_button']
          },
          'no_backspace_delete': {},
          'restore_on_backspace': {}
        },
        valueField: 'id',
        labelField: 'title',
        searchField: 'title',
        create: false,
        load: function(query, callback) {
          const url = element.dataset.ajaxUrl + '.json?term=' + encodeURIComponent(query)

          fetch(url)
            .then(response => response.json())
            .then (json => {
              callback(json)
            }).catch(() => {
              callback()
            })
        },
        render: {
          no_results: function(_data, _escape){
            return '<div class="no-results">' + i18n['no_results'] + '</div>';
          }
        }
      }

      const el = new TomSelect(element, opts)
      selects.push(el)
    }
  })
}

document.addEventListener("turbo:load", rerender)
document.addEventListener("turbo:frame-render", rerender)
document.addEventListener("turbo:render", rerender)