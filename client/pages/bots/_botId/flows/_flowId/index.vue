<template>
  <div id="flow">
    <div v-if="flow">
      <v-container 
        text-xs-center
        grid-list-lg
      >
        <v-layout
          row
          wrap
        >
          <v-flex>
            <v-card>
              <v-card-title class="justify-center">
                <span class="headline">Flow {{ flow.attributes.name }}</span>
              </v-card-title>
              <v-card-text>
                <span>Menu Title:</span> {{ flow.attributes['menu-action-title'] }}
              </v-card-text>
              <v-card-actions class="justify-center">
                <flow-form :flow="flow"/>
                <delete-confirmation @agree="deleteFlow"/>
              </v-card-actions>
            </v-card>
            <br>
            <states :flow="flow" />
          </v-flex>
        </v-layout>
      </v-container>
    </div>
    
  </div>
</template>

<script>
import FlowForm from '@/components/Flows/FlowForm.vue'
import DeleteConfirmation from '@/components/DeleteConfirmation.vue'
import States from '@/components/States'

export default {
  components: {
    FlowForm,
    DeleteConfirmation,
    States
  },
  data() {
    return {
      botId: this.$route.params.botId,
      flowId: this.$route.params.flowId,
      flow: null
    }
  },
  created() {
    this.$axios.get(`/v1/bots/${this.botId}/flows/${this.flowId}`).then(res => {
      this.flow = res.data.data
    })
  },
  methods: {
    deleteFlow() {
      this.$axios
        .delete(`/v1/bots/${this.botId}/flows/${this.flowId}`)
        .then(res => {
          this.$toast.success('Flow deleted.', { icon: 'done' })
          this.$router.push(`/bots/${this.botId}/flows`)
        })
    },
    updateStates(state) {
      this.flow
    }
  }
}
</script>

<style>
</style>
