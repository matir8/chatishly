<template>
  <v-dialog 
    v-model="dialog" 
    persistent 
    max-width="600px">
    
    <v-btn
      slot="activator"
      class="blue white--text"
      @click="loadData()"
    >
      <i class="material-icons">record_voice_over</i>
      <span class="pl-2">Broadcast</span>
    </v-btn>

    <v-card>
      <v-card-title class="justify-center">
        <span class="headline">Broadcast Flow</span>
      </v-card-title>
      <v-card-text>
        <v-container grid-list-md>
          <v-layout wrap>
            <v-flex xs12>
              <v-select
                v-validate="'required'"
                :items="flows"
                v-model="selectedFlow"
                :item-value="flow => flow"
                item-text="title"
                label="Flow"
                data-vv-name="flow"
              />
            </v-flex>
          </v-layout>
        </v-container>
      </v-card-text>
      <v-card-actions>
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
export default {
  props: {
    session: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      dialog: false,
      flows: [],
      selectedFlow: null
    }
  },
  methods: {
    loadData() {
      this.$axios
        .get(`/v1/user/bots/${this.$route.params.botId}/flows`)
        .then(res => {
          this.flows = res.data.data.map(flow => {
            let result = {}

            result.title = flow.attributes['menu-action-title']
            result.type = 'postback'
            result.payload = flow.attributes['trigger-payload']['payload']
            result.id = flow.id

            return result
          })
        })
    },
    submit() {
      if (this.selectedFlow == null) {
        this.$toast.error('Please fill in all fields.', {
          icon: 'error_outline'
        })
        return
      }

      this.$axios
        .put(`/v1/user/bots/${this.$route.params.botId}/broadcast`, {
          broadcasts: [
            {
              flow_id: this.selectedFlow.id,
              session_id: this.session.id
            }
          ]
        })
        .then(res => {
          this.$toast.success('Broadcast successful.', { icon: 'done' })
        })
        .catch(err => {
          this.$toast.error('Something went wrong.', { icon: 'error_outline' })
        })
    }
  }
}
</script>

<style>
</style>
