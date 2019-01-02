export default class AuthService {
  static setCredentials(credentials) {
    localStorage.setItem(
      'auth.access-token',
      credentials['access-token'] || credentials['auth_token']
    )
    localStorage.setItem('auth.uid', credentials['uid'])
    localStorage.setItem(
      'auth.client',
      credentials['client'] || credentials['client_id']
    )
  }

  static clearCredentials() {
    localStorage.removeItem('auth.access-token')
    localStorage.removeItem('auth.uid')
    localStorage.removeItem('auth.client')
  }
}
