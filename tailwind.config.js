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
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
