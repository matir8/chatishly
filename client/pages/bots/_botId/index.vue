<template>
  <div id="bot">
    <div v-if="bot">
      <v-container 
        id="bots"
        text-xs-center
        grid-list-lg
      >
        <v-layout 
          row 
          wrap
        >
          <v-flex xs12>
            <bots :bot="bot" />
          </v-flex>

          <v-flex xs12>
            <flows :bot-id="bot.id"/>
          </v-flex>    
      
          <v-flex xs12>
            <sessions :bot="bot"/>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
    <div v-else>
      <h1 class="red--text">No bot found</h1>
    </div>
  </div>
</template>

<script>
import Bots from '@/components/Bots'
import Sessions from '@/components/Bots/Sessions.vue'
import Flows from '@/components/Flows'

export default {
  components: {
    Bots,
    Sessions,
    Flows
  },
  data() {
    return {
      bot: null
    }
  },
  beforeCreate() {
    this.$axios.get(`/v1/bots/${this.$route.params.botId}`).then(res => {
      this.bot = res.data.data
    })
  }
}
</script>

<style>
</style>
