<template>
  <v-card>
    <v-card-title
      class="justify-center"
      primary-title
    >
      <div>
        <h3 class="headline">{{ bot.attributes.name }}</h3>
      </div>
    </v-card-title>
    <v-card-text>
      <div>
        Connceted to 
        <a 
          :href="`https://facebook.com/${bot.attributes.page.id}`" 
          target="_blank"
          class="blue--text">
          {{ bot.attributes.page.name }}
        </a>
      </div>
      <div>
        Default Flow:
        <nuxt-link 
          v-if="bot.attributes['default-flow']"
          :to="`/bots/${this.$route.params.botId}/flows/${bot.attributes['default-flow'].id}`" 
          class="blue--text">
          {{ bot.attributes['default-flow'].name }}
        </nuxt-link>
        <span 
          v-else 
          class="red--text">Not set!</span>
      </div>
      <v-card-actions
        v-if="isDetailedView()"
        class="justify-center"
      >
        <bot-form 
          :bot="bot"
          @updateBots="updateBots"
        />
        <delete-confirmation @agree="deleteBot"/>
        <configure-menu :bot="bot"/>
      </v-card-actions>
      <v-card-actions
        v-else
        class="justify-center"
      >
        <nuxt-link :to="`/bots/${bot.id}`">
          <v-btn 
            flat
            color="blue"
          >
            Info
          </v-btn>
        </nuxt-link>
      </v-card-actions>
    </v-card-text>
  </v-card>
</template>

<script>
import BotForm from '@/components/Bots/BotForm.vue'
import DeleteConfirmation from '@/components/DeleteConfirmation.vue'
import ConfigureMenu from '@/components/Bots/ConfigureMenu.vue'

export default {
  components: {
    BotForm,
    DeleteConfirmation,
    ConfigureMenu
  },
  props: {
    bot: {
      type: Object,
      default: null
    }
  },
  methods: {
    isDetailedView() {
      return this.$route.params.botId
    },
    deleteBot() {
      this.$axios
        .delete(`/v1/user/bots/${this.$route.params.botId}`)
        .then(res => {
          this.$toast.success('Bot deleted.', { icon: 'done' })
          this.$router.push('/bots')
        })
    },
    updateBots(bot) {
      this.bot = bot
    }
  }
}
</script>

<style>
a {
  text-decoration: none;
}
</style>
