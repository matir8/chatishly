<template>
  <div id="navbar">
    <v-toolbar
      fixed
      height="44"
      app>
      <v-toolbar-title>
        <nuxt-link to="/">
          Chatishly
        </nuxt-link>
      </v-toolbar-title>
      <v-spacer />
      <div v-if="!$auth.loggedIn">
        <!-- <v-btn
          flat
          nuxt
          to="/auth/login"
        >Login</v-btn>
        <v-btn
          flat
          nuxt
          to="/auth/register"
        >Register</v-btn> -->
        <v-btn 
          :href="$axios.defaults.baseURL + '/auth/facebook'" 
          flat
        >
          Sign-in
        </v-btn>
      </div>
      <div v-else>
        <v-btn
          flat
          @click="logout"
        >Logout</v-btn>
      </div>
    </v-toolbar>
  </div>
</template>

<script>
import AuthService from '@/services/authService.js'

export default {
  methods: {
    logout() {
      this.$axios.delete('/auth/sign_out').then(() => {
        AuthService.clearCredentials()
        this.$router.go()
      })
    }
  }
}
</script>

<style>
a {
  text-decoration: none;
}
</style>
