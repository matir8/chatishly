const pkg = require('./package')

module.exports = {
  mode: 'spa',

  /*
  ** Headers of the page
  */
  head: {
    title: pkg.name,
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: pkg.description }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
      {
        rel: 'stylesheet',
        href:
          'https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons'
      }
    ]
  },

  /*
  ** Customize the progress-bar color
  */
  loading: { color: '#fff' },

  /*
  ** Global CSS
  */
  css: ['~/assets/style/app.styl'],

  /*
  ** Plugins to load before mounting the App
  */
  plugins: ['@/plugins/axios.js', '@/plugins/vuetify'],

  /*
  ** Nuxt.js modules
  */
  modules: [
    // Doc: https://github.com/nuxt-community/axios-module#usage
    '@nuxtjs/axios',
    '@nuxtjs/auth',
    '@nuxtjs/toast',
    'nuxt-validate'
  ],
  /*
  ** Axios module configuration
  */
  axios: {
    baseURL: 'http://localhost:3000'
  },

  auth: {
    strategies: {
      local: {
        endpoints: {
          login: {
            url: '/auth/sign_in',
            method: 'post',
            propertyName: 'auth'
          },
          logout: {
            url: '/auth/sign_out',
            method: 'delete'
          },
          user: {
            url: '/v1/user/current',
            method: 'get',
            propertyName: 'data'
          }
        }
      }
    },
    redirect: {
      login: '/',
      logout: '/',
      user: '/v1/user/current',
      callback: '/'
    }
  },

  router: {
    middleware: ['auth']
  },

  toast: {
    position: 'top-right',
    duration: 2000
  },

  server: {
    port: 8000, // default: 3000
    host: 'localhost'
  },

  /*
  ** Build configuration
  */
  build: {
    /*
    ** You can extend webpack config here
    */
    extend(config, ctx) {
      // Run ESLint on save
      if (ctx.isDev && ctx.isClient) {
        config.module.rules.push({
          enforce: 'pre',
          test: /\.(js|vue)$/,
          loader: 'eslint-loader',
          exclude: /(node_modules)/
        })
      }
    }
  }
}
