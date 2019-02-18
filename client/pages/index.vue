<template>
  <div id="home">
    <section>
      <v-parallax 
        src="background.jpg" 
        height="700">
        <v-layout
          column
          align-center
          justify-center
          class="white--text"
        >
          <h1 class="white--text mb-2 display-3 text-xs-center">Chatishly</h1>
          <div class="subheading mb-3 text-xs-center">Create chatbots with ease</div>
          <v-btn 
            :href="$axios.defaults.baseURL + '/auth/facebook'"
            class="white blue--text" 
            dark 
            large 
          >
            Continue with Facebook
          </v-btn>
        </v-layout>
      </v-parallax>
    </section>

    <section>
      <v-layout
        column
        wrap
        class="my-5"
        align-center
      >
        <v-flex 
          xs12 
          sm4 
          class="my-3">
          <div class="text-xs-center">
            <h2 class="headline">The easiest way to create a simple chatbot for your page</h2>
          </div>
        </v-flex>
        <v-flex xs12>
          <v-container grid-list-xl>
            <v-layout 
              row 
              wrap 
              align-center>
              <v-flex 
                xs12 
                md4>
                <v-card class="elevation-0 transparent">
                  <v-card-text class="text-xs-center">
                    <v-icon 
                      x-large 
                      class="blue--text">accessibility</v-icon>
                  </v-card-text>
                  <v-card-title 
                    primary-title 
                    class="layout justify-center">
                    <div class="headline text-xs-center">No coding skills required</div>
                  </v-card-title>
                  <v-card-text>
                    Creating a chatbot was never so easy.
                    With Chatishly you don't have to know how to code to set-up a chatbot for your Facebook page.
                    Everything is ready and configured for you. Just design your bot's logic. It's super easy.
                  </v-card-text>
                </v-card>
              </v-flex>
              <v-flex 
                xs12 
                md4>
                <v-card class="elevation-0 transparent">
                  <v-card-text class="text-xs-center">
                    <v-icon 
                      x-large 
                      class="blue--text">reorder</v-icon>
                  </v-card-text>
                  <v-card-title 
                    primary-title 
                    class="layout justify-center">
                    <div class="headline">Arrange bot logic</div>
                  </v-card-title>
                  <v-card-text>
                    Organize your chatbot's logic in different Flows with multiple States.
                    Each State represents a message sent to the user.
                    Navigate your clients with the QuickReplies which can trigger different Flows or States.
                  </v-card-text>
                </v-card>
              </v-flex>
              <v-flex 
                xs12 
                md4>
                <v-card class="elevation-0 transparent">
                  <v-card-text class="text-xs-center">
                    <v-icon 
                      x-large 
                      class="blue--text">record_voice_over</v-icon>
                  </v-card-text>
                  <v-card-title 
                    primary-title 
                    class="layout justify-center">
                    <div class="headline text-xs-center">Broadcast messages</div>
                  </v-card-title>
                  <v-card-text>
                    You can broadcast messages to a single or multiple clients in a click of a button.
                    Notify your clients about important stuff that are going on with your business.
                    Create better marketing campaigns with Chatishly.
                  </v-card-text>
                </v-card>
              </v-flex>
            </v-layout>
          </v-container>
        </v-flex>
      </v-layout>
    </section>
  </div>
</template>

<script>
export default {
  auth: false,
  created() {
    if (this.$auth.loggedIn) {
      this.$router.push('/bots')
    }
  }
}
</script>

<style>
a {
  text-decoration: none;
}
</style>
