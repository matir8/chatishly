<template>
  <div id="states">
    <span class="headline">States</span>
    <v-timeline align-top>
      <v-timeline-item 
        v-for="state in states" 
        :key="state.id"
        :color="stateColor(type(state))"
      >
        <v-card>
          <v-card-title :class="`title ${type(state)}`">
            {{ state.attributes['statable']['name'] }}
            <v-spacer />
            <delete-confirmation @agree="deleteState(state.id)" />
          </v-card-title>
          <v-card-text>
            <state :state="state" />
          </v-card-text>
          <v-card-actions class="justify-center">
            <quick-reply-form 
              :state="state" 
              class="mr-2"/>
            <quick-reply-form 
              v-for="reply in state.attributes['quick-replies']" 
              :key="reply.id"
              :reply-prop="reply"
              :state="state"
              class="mr-2"
            />
          </v-card-actions>
        </v-card>
      </v-timeline-item>
    </v-timeline>
    <state-form @updateStates="updateStates"/>
  </div>
</template>

<script>
import State from '@/components/States/State.vue'
import StateForm from '@/components/States/StateForm.vue'
import DeleteConfirmation from '@/components/DeleteConfirmation.vue'
import QuickReplyForm from '@/components/QuickReplyForm.vue'

export default {
  components: {
    State,
    StateForm,
    DeleteConfirmation,
    QuickReplyForm
  },
  data() {
    return {
      botId: this.$route.params.botId,
      flowId: this.$route.params.flowId,
      flow: null,
      states: []
    }
  },
  beforeMount() {
    this.$axios
      .get(`/v1/user/bots/${this.botId}/flows/${this.flowId}/states`)
      .then(res => {
        this.states = res.data.data
      })

    if (!this.flow) {
      this.$axios
        .get(`/v1/user/bots/${this.botId}/flows/${this.flowId}`)
        .then(res => {
          this.flow = res.data.data
        })
    }
  },
  methods: {
    deleteState(id) {
      this.$axios
        .delete(`/v1/user/bots/${this.botId}/flows/${this.flowId}/states/${id}`)
        .then(res => {
          this.states = this.states.filter(state => state.id != id)
          this.$toast.success('State deleted.', { icon: 'done' })
        })
    },
    updateStates(state) {
      this.states.push(state)
    },
    type(state) {
      return state.attributes['statable-type']
    },
    stateColor(statableType) {
      switch (statableType) {
        case 'TextState':
          return 'blue'
          break
        case 'QuestionState':
          return 'deep-purple'
          break
        case 'ImageState':
          return 'lighten-1 red'
          break
        case 'OpenGraphState':
          return 'lighten-1 green'
          break
        default:
          break
      }
    }
  }
}
</script>

<style>
</style>
