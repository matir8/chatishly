<template>
  <v-layout 
    row 
    justify-center>
    <v-dialog 
      v-model="dialog" 
      persistent 
      max-width="600px">
      <v-btn
        slot="activator" 
        color="primary" 
        dark
        fab
      >
        <span class="headline">+</span>
      </v-btn>
      <v-card>
        <v-card-title class="justify-center">
          <span class="headline">Create State</span>
        </v-card-title>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout wrap>
              <v-flex 
                xs12>
                <v-select
                  v-validate="'required'"
                  :items="statableTypes"
                  v-model="formData.statable_type"
                  label="Type"
                  data-vv-name="type"
                />
                <v-text-field 
                  v-validate="'required|max:64'"
                  v-model="formData.name"
                  :error-messages="errors.collect('name')"
                  label="Name"
                  data-vv-name="name"
                />  
              </v-flex>

              <v-flex 
                v-if="formData.statable_type == 'TextState'"
                xs12
              >
                <v-text-field 
                  v-validate="'required|max:64'"
                  v-model="formData.text"
                  :error-messages="errors.collect('text')"
                  label="Text"
                  data-vv-name="text"
                />
              </v-flex>

              <v-flex v-if="formData.statable_type == 'QuestionState'">
                <v-text-field 
                  v-validate="'required|max:64'"
                  v-model="formData.question"
                  :error-messages="errors.collect('question')"
                  label="Question"
                  data-vv-name="question"
                />
              </v-flex>

              <v-flex v-if="formData.statable_type == 'OpenGraphState'">
                <v-text-field 
                  v-validate="'required|url'"
                  v-model="formData.url"
                  :error-messages="errors.collect('url')"
                  label="Open Graph Url (YouTube, Spotify, Vimeo, etc.)"
                  data-vv-name="url"
                />
              </v-flex>

              <v-flex v-if="formData.statable_type == 'ImageState'">
                <v-text-field 
                  v-validate="'required|url'"
                  v-model="formData.url"
                  :error-messages="errors.collect('url')"
                  label="Image URL"
                  data-vv-name="url"
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
  </v-layout>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
      statableTypes: [
        'TextState',
        'QuestionState',
        'ImageState',
        'OpenGraphState'
      ],
      formData: {
        statable_type: '',
        name: '',
        text: '',
        question: '',
        url: ''
      }
    }
  },
  methods: {
    submit() {
      let botId = this.$route.params.botId
      let flowId = this.$route.params.flowId

      this.$axios
        .post(`v1/user/bots/${botId}/flows/${flowId}/states`, this.formData)
        .then(res => {
          this.dialog = false
          this.$toast.success('Operation successful', { icon: 'done' })
          this.$emit('updateStates', res.data.data)
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
