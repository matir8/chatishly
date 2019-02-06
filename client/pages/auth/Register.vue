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
          <v-text-field
            v-validate="{ is: user.password, required: true }"
            v-model="user.passwordConfirmation"
            :error-messages="errors.collect('passwordConfirmation').length == 0 ? '' : 'Passwords does not match'" 
            label="Confirm Password"
            data-vv-name="passwordConfirmation"
            type="password"
            required
          />
          <v-text-field
            v-validate="'required|min:3|max:30'"
            v-model="user.name"
            :error-messages="errors.collect('name')"
            label="Name"
            data-vv-name="name"
            type="text"
            required
          />
          <v-btn @click="register">Register</v-btn>
          <v-btn :href="$axios.defaults.baseURL + '/auth/facebook'">Sign up with Facebook</v-btn>
        </form>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
export default {
  auth: false,
  data() {
    return {
      user: {
        email: '',
        password: '',
        passwordConfirmation: '',
        name: ''
      }
    }
  },
  methods: {
    async register() {
      try {
        await this.$axios.post('/auth', {
          email: this.user.email,
          password: this.user.password,
          password_confirmation: this.user.passwordConfirmation,
          name: this.user.name
        })

        await this.$auth.loginWith('local', {
          data: {
            email: this.user.email,
            password: this.user.password
          }
        })

        if (this.$auth.loggedIn) {
          this.$toast.success('Registration successful', { icon: 'done' })
          this.$router.push('/')
        }
      } catch (e) {
        this.$toast.error('Registration failed.', { icon: 'error_outline' })
      }
    }
  }
}
</script>
<style>
</style>
