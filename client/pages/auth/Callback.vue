<template>
  <h1>callback</h1>
</template>

<script>
export default {
  auth: false,
  mounted() {
    if (this.$route.query) {
      localStorage.setItem('auth.access-token', this.$route.query['auth_token'])
      localStorage.setItem('auth.uid', this.$route.query['uid'])
      localStorage.setItem('auth.client', this.$route.query['client_id'])
    }
    this.$axios.get('/v1/users/current').then(res => {
      this.$auth.setUser(res.data.data)
    })
    this.$router.push('/')
  }
}
</script>
