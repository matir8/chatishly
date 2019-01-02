import AuthService from '@/services/authService'

export default function({ $axios }) {
  $axios.onRequest(req => {
    req.headers['Content-Type'] = 'application/json'
    req.headers['Access-Control-Allow-Origin'] = '*'

    if (localStorage.getItem('auth.access-token')) {
      req.headers['access-token'] = localStorage.getItem('auth.access-token')
      req.headers['uid'] = localStorage.getItem('auth.uid')
      req.headers['client'] = localStorage.getItem('auth.client')
    }
  })

  $axios.onResponse(config => {
    if (
      config.request.responseURL == `${$axios.defaults.baseURL}/auth/sign_in` &&
      config.request.status == 200
    ) {
      AuthService.setCredentials(config.headers)
    }
  })
}
