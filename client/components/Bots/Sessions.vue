<template>
  <div id="sessions" >
    <h1>Facebook Users</h1>
    <multiple-broadcasts :sessions="sessions" />
    <v-layout 
      row 
      wrap>
      <v-flex
        v-for="session in sessions"
        :key="session.id"
        xs6
        md4
        class="text-sm-left"
      >
        <v-layout 
          row
          wrap
        >
          <v-flex 
            xs4 
            md3>
            <v-img
              :src="session.attributes['sender-profile-pic']"
              contain
            />
          </v-flex>
          <v-flex 
            xs8 
            md9>
            <v-card>
              <v-card-text>
                <div class="headline">{{ session.attributes['sender-name'] }}</div>  
                <div>
                  Flow:
                  <nuxt-link 
                    :to="`/bots/${bot.id}/flows/${session.attributes['progress']['flow']['id']}`" 
                    class="blue--text">
                    {{ session.attributes['progress']['flow']['name'] }}
                  </nuxt-link>
                </div>
                <div>
                  State: {{ session.attributes['progress']['state']['name'] }}
                </div>
                <div>Last active: {{ new Date(session.attributes['last-active']).toLocaleString("bg-BG") }}</div>
              </v-card-text>
              <v-card-actions class="justify-center">
                <single-broadcast :session="session" />
              </v-card-actions>
            </v-card>
          </v-flex>
        </v-layout>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import SingleBroadcast from '@/components/Bots/SingleBroadcast.vue'
import MultipleBroadcasts from '@/components/Bots/MultipleBroadcasts.vue'

export default {
  components: {
    SingleBroadcast,
    MultipleBroadcasts
  },
  props: {
    bot: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      sessions: []
    }
  },
  beforeCreate() {
    this.$axios
      .get(`/v1/bots/${this.$route.params.botId}/bot_sessions`)
      .then(res => {
        this.sessions = res.data.data
      })
  }
}
</script>

<style>
</style>
