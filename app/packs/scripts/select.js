import TomSelect from 'tom-select/dist/js/tom-select.popular'
import Translations from './i18n/select.json'

document.addEventListener("turbolinks:load", function() {
  const i18n = Translations[document.querySelector('body').dataset.lang]

  document.querySelectorAll('.js-multiple-select').forEach((element) => {
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

    new TomSelect(element, opts)
  })
})