<template>
  <v-dialog 
    v-model="dialog" 
    persistent 
    max-width="600px">
    
    <v-tooltip 
      slot="activator" 
      top>
      <v-btn
        v-if="!flow"
        slot="activator" 
        color="primary" 
        fixed
        fab
        bottom
        right
        dark
      >
        <span class="headline">+</span>
      </v-btn>
      <v-btn 
        v-else
        slot="activator" 
        color="primary"
        flat
        @click="loadFormData"
      >
        <i class="material-icons">edit</i>
      </v-btn>
      <span v-if="!flow">Create flow</span>
      <span v-else>Edit</span>
    </v-tooltip>

    <v-card>
      <v-card-title class="justify-center">
        <span 
          v-if="!flow" 
          class="headline">Create flow</span>
        <span 
          v-else 
          class="headline">Update flow</span>
      </v-card-title>
      <v-card-text>
        <v-container grid-list-md>
          <v-layout wrap>
            <v-flex xs12>
              <v-text-field 
                v-validate="'required|max:64'"
                v-model="formData.name"
                :error-messages="errors.collect('name')"
                label="Name"
                data-vv-name="name"
              />
            </v-flex>
            <v-flex xs12>
              <v-text-field 
                v-validate="'required|max:64'"
                v-model="formData.menuTitle"
                :error-messages="errors.collect('menuTitle')"
                label="Menu Title"
                data-vv-name="menuTitle"
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
    flow: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      dialog: false,
      states: [],
      formData: {
        name: '',
        menuTitle: ''
      }
    }
  },
  methods: {
    loadFormData() {
      if (this.flow) {
        this.formData.name = this.flow.attributes['name']
        this.formData.menuTitle = this.flow.attributes['menu-action-title']
      }
    },
    submit() {
      let reqPromise

      if (this.formData.name == '' || this.formData.menuTitle == '') {
        this.$toast.error('Please fill in all fields.', {
          icon: 'error_outline'
        })
        return
      }

      if (this.flow) {
        reqPromise = this.$axios.put(
          `v1/user/bots/${this.$route.params.botId}/flows/${this.flow.id}`,
          {
            name: this.formData.name,
            menu_action_title: this.formData.menuTitle
          }
        )
      } else {
        reqPromise = this.$axios.post(
          `v1/user/bots/${this.$route.params.botId}/flows`,
          {
            name: this.formData.name,
            menu_action_title: this.formData.menuTitle
          }
        )
      }

      reqPromise
        .then(res => {
          let flow = res.data.data

          this.dialog = false
          this.$toast.success('Operation successful', { icon: 'done' })
          this.$router.push(
            `/bots/${flow.attributes['bot-id']}/flows/${flow.id}`
          )
        })
        .catch(err => {
          console.log(err)
          this.$toast.error('A bot for the selected page already exists', {
            icon: 'error_outline'
          })
        })
    }
  }
}
</script>

<style>
</style>
