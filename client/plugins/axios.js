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
      localStorage.setItem('auth.access-token', config.headers['access-token'])
      localStorage.setItem('auth.uid', config.headers['uid'])
      localStorage.setItem('auth.client', config.headers['client'])
    }
  })
}
