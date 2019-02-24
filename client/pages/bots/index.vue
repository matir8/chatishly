<template>
  <v-container 
    id="bots"
    text-xs-center
    grid-list-lg>
    <h1>All bots</h1>
    <v-layout 
      row 
      wrap>
      <v-flex 
        v-for="bot in bots"
        :key="bot.id"
        md4
      >
        <bots :bot="bot"/>
      </v-flex>
    </v-layout>
    <bot-form @updateBots="addBot"/>
  </v-container>
</template>

<script>
import BotForm from '@/components/Bots/BotForm.vue'
import Bots from '@/components/Bots'

export default {
  components: {
    Bots,
    BotForm
  },
  data() {
    return {
      bots: []
    }
  },
  created() {
    this.$axios.get('/v1/bots').then(res => {
      this.bots = res.data.data
    })
  },
  methods: {
    addBot(bot) {
      this.bots.push(bot)
    }
  }
}
</script>

<style>
a {
  text-decoration: none;
}
</style>
