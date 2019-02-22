<template>
  <v-dialog 
    v-model="dialog" 
    persistent 
    max-width="600px">
    <v-tooltip 
      slot="activator" 
      top>
      <v-btn
        v-if="!bot"
        slot="activator" 
        color="primary" 
        fixed
        fab
        bottom
        right
        dark
        @click="loadFacebookPages"
      >
        <span class="headline">+</span>
      </v-btn>
      <v-btn 
        v-else
        slot="activator" 
        color="primary"
        flat
        @click="loadFacebookPages"
      >
        <i class="material-icons">edit</i>
      </v-btn>
      <span v-if="!bot">Create bot</span>
      <span v-else>Edit</span>
    </v-tooltip>

    <v-card>
      <v-card-title class="justify-center">
        <span 
          v-if="!bot" 
          class="headline">Create bot</span>
        <span 
          v-else 
          class="headline">Edit bot</span>
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
                data-vv-name="name"/>
            </v-flex>
            <v-flex 
              xs12>
              <v-select
                v-validate="'required'"
                :items="pages"
                v-model="formData.pageId"
                item-text="attributes.name"
                item-value="id"
                label="Page"
                data-vv-name="page"
              />
            </v-flex>
            <v-flex 
              v-if="bot"
              xs12>
              <v-select
                v-validate="'required'"
                :items="flows"
                v-model="formData.default_flow_id"
                :item-text="flow => flow.attributes.name"
                item-value="id"
                label="Default flow"
                data-vv-name="defaultFlow"
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
    bot: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      dialog: false,
      pages: [],
      flows: [],
      formData: {
        name: '',
        pageId: null,
        default_flow_id: null
      }
    }
  },
  created() {
    if (this.bot) {
      this.formData.name = this.bot.attributes['name']
      this.formData.pageId = this.bot.attributes.page.id.toString()

      if (this.bot.attributes['default-flow']) {
        this.formData.default_flow_id = this.bot.attributes['default-flow'].id
      }

      this.$axios.get(`v1/bots/${this.bot.id}/flows`).then(res => {
        this.flows = res.data.data
      })
    }
  },
  methods: {
    loadFacebookPages() {
      this.$axios.get('v1/user/facebook_pages').then(res => {
        this.pages = res.data.data
      })
    },
    submit() {
      let reqPromise

      if (this.formData.name == '' || this.formData.pageId == null) {
        this.$toast.error('Please fill in all fields.', {
          icon: 'error_outline'
        })
        return
      }

      if (this.bot) {
        reqPromise = this.$axios.put(`v1/bots/${this.bot.id}`, {
          name: this.formData.name,
          page_id: this.formData.pageId,
          default_flow_id: this.formData.default_flow_id
        })
      } else {
        reqPromise = this.$axios.post('v1/bots', {
          name: this.formData.name,
          page_id: this.formData.pageId
        })
      }

      reqPromise
        .then(res => {
          this.dialog = false
          this.$toast.success('Operation successful', { icon: 'done' })
          this.$emit('updateBots', res.data.data)
          this.$router.push(`/bots/${res.data.data.id}`)
        })
        .catch(err => {
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
