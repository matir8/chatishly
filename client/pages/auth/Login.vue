<template>
  <v-container 
    fluid 
    fill-height>
    <v-layout 
      align-center 
      justify-center>
      <v-flex 
        xs12 
        sm8 
        md6>
        <form>
          <v-text-field
            v-validate="'required|email'"
            v-model="user.email"
            :error-messages="errors.collect('email')"
            label="E-mail"
            data-vv-name="email"
            required
          />
          <v-text-field
            v-validate="'required|min:8|max:64'"
            v-model="user.password"
            :error-messages="errors.collect('password')"
            label="Password"
            data-vv-name="password"
            type="password"
            required
          />
          <v-btn @click="local">submit</v-btn>
          <v-btn href="http://localhost:3000/auth/facebook">Facebook</v-btn>
        </form>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      drawer: null,
      user: {
        email: '',
        password: ''
      }
    }
  },
  mounted() {
    if (this.$auth.loggedIn) {
      this.$router.push('/')
    }
  },
  methods: {
    async local() {
      try {
        this.$toast.show('Logging in...', { icon: 'fingerprint' })
        await this.$auth
          .loginWith('local', {
            data: {
              email: this.user.email,
              password: this.user.password
            }
          })
          .catch(e => {
            console.log(e)
            this.$toast.error('Failed Logging In', { icon: 'error_outline' })
          })
        if (this.$auth.loggedIn) {
          this.$toast.success('Successfully Logged In', { icon: 'done' })
        }
      } catch (e) {
        console.log(e)
        this.$toast.error('Username or Password wrong', { icon: 'error' })
      }
    },
    check() {
      console.log(this.$auth.loggedIn)
    },
    logout() {
      this.$toast.show('Logging out...', { icon: 'fingerprint' })
      this.$auth.logout()
    }
  }
}
</script>
