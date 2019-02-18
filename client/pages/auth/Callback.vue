<template>
  <h1>callback</h1>
</template>

<script>
import AuthService from '@/services/authService'

export default {
  auth: false,
  mounted() {
    if (this.$route.query) {
      AuthService.setCredentials(this.$route.query)
      this.$axios.get('/v1/user/current').then(res => {
        this.$auth.setUser(res.data.data)
        this.$router.push('/bots')
      })
    }
    this.$router.push('/')
  }
}
</script>
