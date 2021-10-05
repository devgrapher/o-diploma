const colors = require('tailwindcss/colors')
module.exports = {
  purge: {
    enabled: true,
    content: [
      './app/**/*.haml',
      './app/**/*.html.erb',
      './app/**/*.js',
    ],
    preserveHtmlElements: false,
    options: {
      defaultExtractor: content => ((content.match(/[A-Za-z0-9-_:/\.]+/g) || [])
        .map(word => {
          let result = word.match(/[^\.]*[^\.\s]/g) || []
          result.push(word)

          return result
        }).flat(Infinity) || []),
    }
  },
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      backgroundImage: {
       'main': "url('../images/main.jpg')",
       'diploma': "url('../images/diploma.png')",
      }
    },
    colors: {
      primary: colors.yellow,
      transparent: 'transparent',
      current: 'currentColor',
      black: colors.black,
      white: colors.white,
      gray: colors.trueGray,
      indigo: colors.indigo,
      red: colors.rose,
      yellow: colors.amber,
    }
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
