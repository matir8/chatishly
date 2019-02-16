<template>
  <div id="configure">
    <v-dialog 
      v-model="dialog" 
      persistent 
      max-width="600px">

      <v-tooltip 
        slot="activator" 
        top>
        <v-btn 
          slot="activator" 
          flat
          @click="loadFlows"
        >
          <i class="material-icons">menu</i>
        </v-btn>
        <span>Configure persistent menu</span>
      </v-tooltip>
      <v-card>
        <v-card-title class="justify-center">
          <span class="headline">Select flows to be included in the persistent menu</span>
        </v-card-title>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout wrap>
              <v-flex xs12>
                <v-select
                  v-validate="'required'"
                  :items="flows"
                  v-model="menu"
                  :item-value="flow => flow"
                  item-text="title"
                  multiple
                  persistent-hint
                  label="Flows"
                  data-vv-name="menu"
                />
                <span 
                  v-show="errors.has('menu')" 
                  class="danger">{{ errors.first('menu') }}</span>
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
            @click="configure">Set menu</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  props: {
    bot: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      dialog: false,
      menu: [],
      flows: []
    }
  },
  methods: {
    loadFlows() {
      this.$axios.get(`/v1/user/bots/${this.bot.id}/flows`).then(res => {
        this.flows = res.data.data.map(flow => {
          let result = {}

          result.title = flow.attributes['menu-action-title']
          result.type = 'postback'
          result.payload = flow.attributes['trigger-payload']['payload']

          return result
        })
      })
    },
    configure() {
      this.$axios
        .put(`/v1/user/bots/${this.bot.id}/configure_persistent_menu`, {
          menu: [
            {
              locale: 'default',
              composer_input_disabled: 'false',
              call_to_actions: this.menu
            }
          ]
        })
        .then(res => {
          this.$toast.success('Persistent menu configured.', { icon: 'done' })
          this.dialog = false
        })
    }
  }
}
</script>

<style>
</style>
