<template>
  <v-dialog 
    v-model="dialog" 
    persistent 
    max-width="600px">
    <v-btn
      slot="activator" 
      color="primary" 
      dark
      @click="loadData"
    >
      <span v-if="reply">{{ reply.title }}</span>
      <span 
        v-else 
        class="headline">
        +
      </span>
    </v-btn>
    <v-card>
      <v-card-title class="justify-center">
        <span 
          v-if="reply" 
          class="headline">
          Update {{ reply.id }}
        </span>
        <span 
          v-else 
          class="headline">
          Create Quick Reply
        </span>
      </v-card-title>
      <v-card-text class="justify-center">
        <v-container grid-list-md>
          <v-layout wrap>
            <v-flex xs12>
              <v-text-field 
                v-validate="'required|max:64'"
                v-model="formData.title"
                :error-messages="errors.collect('title')"
                label="Title"
                data-vv-name="title"
              />  
              <v-select
                v-validate="'required'"
                :items="payloads"
                v-model="formData.payload"
                :item-text="x => `${x.type} ${x.name}`"
                :error-messages="errors.collect('payload')"
                item-value="payload"
                label="Next Flow or State"
                data-vv-name="payload"
              />
              <v-text-field 
                v-validate="'url'"
                v-model="formData.image_url"
                :error-messages="errors.collect('image_url')"
                label="Image URL (optional)"
                data-vv-name="image_url"
              />  
            </v-flex>
          </v-layout>
        </v-container>
      </v-card-text>
      <v-card-actions>
        <delete-confirmation 
          v-if="reply" 
          @agree="deleteReply(reply)" />
        <v-spacer/>
        <v-btn 
          color="red darken-1" 
          flat 
          @click="dialog = false">Cancel</v-btn>
        <v-btn
          color="blue darken-1" 
          flat 
          @click="submit">Submit</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
import DeleteConfirmation from '@/components/DeleteConfirmation.vue'

export default {
  components: {
    DeleteConfirmation
  },
  props: {
    replyProp: {
      type: Object,
      default: null
    },
    state: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      dialog: false,
      botId: this.$route.params.botId,
      flowId: this.$route.params.flowId,
      flows: [],
      states: [],
      payloads: [],
      formData: {
        content_type: 'text',
        title: '',
        payload: '',
        image_url: ''
      },
      reply: this.replyProp
    }
  },
  methods: {
    loadData() {
      if (this.reply) {
        this.formData.title = this.reply.title
        this.formData.payload = this.reply.payload
        this.formData.image_url = this.reply.image_url
      }
      this.$axios.get(`v1/bots/${this.botId}`).then(res => {
        this.flows = res.data.data.attributes['list-flows-triggers']
      })

      this.$axios
        .get(`v1/bots/${this.botId}/flows/${this.flowId}`)
        .then(res => {
          this.states = res.data.data.attributes['list-states-triggers']
          this.payloads = this.flows.concat(this.states)
        })
    },
    submit() {
      let requestPromise

      if (this.formData.title == '' || this.formData.payload == '') {
        this.$toast.error('Please fill the required fields.', {
          icon: 'error_outline'
        })
        return
      }

      if (this.reply) {
        requestPromise = this.$axios.put(
          `v1/bots/${this.botId}/flows/${this.flowId}/states/${
            this.state.id
          }/quick_replies/${this.reply.id}`,
          this.formData
        )
      } else {
        requestPromise = this.$axios.post(
          `v1/bots/${this.botId}/flows/${this.flowId}/states/${
            this.state.id
          }/quick_replies`,
          this.formData
        )
      }
      requestPromise
        .then(res => {
          let newReply = res.data.data.attributes
          newReply.id = res.data.data.id

          this.dialog = false
          this.$toast.success('Operation successful', { icon: 'done' })
          if (this.reply) {
            let i = this.state.attributes['quick-replies'].findIndex(x => {
              return x.id == this.reply.id
            })

            this.reply = newReply
          } else {
            this.state.attributes['quick-replies'].push(newReply)
          }

          this.loadData()
        })
        .catch(err => {
          this.$toast.error('Error', {
            icon: 'error_outline'
          })
        })
    },
    deleteReply(reply) {
      this.$axios
        .delete(
          `v1/bots/${this.botId}/flows/${this.flowId}/states/${
            this.state.id
          }/quick_replies/${reply.id}`
        )
        .then(res => {
          this.dialog = false
          let replies = this.state.attributes['quick-replies'].filter(x => {
            return x.id != reply.id
          })
          this.state.attributes['quick-replies'] = replies
          this.$toast.success('Deleted', { icon: 'done' })
        })
    }
  }
}
</script>

<style>
</style>
