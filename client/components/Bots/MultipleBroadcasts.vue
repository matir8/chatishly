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
      <span class="pl-2">Multiple Broadcast</span>
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
                :items="items"
                v-model="selected"
                :item-value="session => session"
                item-text="senderName"
                persistent-hint
                multiple
                label="Facebook Users"
                data-vv-name="sessions"
              >
                <v-list-tile 
                  slot="prepend-item" 
                  ripple 
                  @click="toggleSelectAll()">
                  <v-list-tile-title class="accent--text darken-2">
                    {{ isAllSelected ? 'Clear' : 'Select All' }}
                  </v-list-tile-title>
                </v-list-tile>
                <v-divider slot="prepend-item"/>
              </v-select>
            </v-flex>

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
    sessions: {
      type: Array,
      default: null
    }
  },
  data() {
    return {
      dialog: false,
      flows: [],
      selectedFlow: null,
      selected: []
    }
  },
  computed: {
    isAllSelected() {
      return this.selected.length === this.items.length
    },
    items() {
      return this.sessions.map(session => {
        return {
          senderName: session.attributes['sender-name'],
          id: session.id
        }
      })
    }
  },
  methods: {
    toggleSelectAll() {
      this.$nextTick(() => {
        if (this.isAllSelected) {
          this.selected = []
        } else {
          this.selected = this.items.slice()
        }
      })
    },
    loadData() {
      this.$axios
        .get(`/v1/user/bots/${this.$route.params.botId}/flows`)
        .then(res => {
          this.flows = res.data.data.map(flow => {
            let result = {}

            result.title = flow.attributes.name
            result.type = 'postback'
            result.payload = flow.attributes['trigger-payload']['payload']
            result.id = flow.id

            return result
          })
        })
    },
    submit() {
      if (this.selected.length == 0 || this.selectedFlow == null) {
        this.$toast.error('Please fill in all fields.', {
          icon: 'error_outline'
        })
        return
      }

      this.$axios
        .put(`/v1/user/bots/${this.$route.params.botId}/broadcast`, {
          broadcasts: this.selected.map(session => {
            return {
              flow_id: this.selectedFlow.id,
              session_id: session.id
            }
          })
        })
        .then(res => {
          this.$toast.success('Broadcast successful.', { icon: 'done' })
          this.dialog = false
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
