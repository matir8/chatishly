<template>
  <div>
    <h1>Flows</h1>
    <v-layout 
      v-if="flows.length > 0" 
      id="flows" 
      row
      wrap
    >
      <v-flex 
        v-for="flow in flows" 
        :key="flow.id"
        xs4
      >
        <v-card>
          <v-card-title
            class="justify-center"
            primary-title
          >
            <div>
              <h3 class="headline">{{ flow.attributes.name }}</h3>
            </div>
          </v-card-title>
          <v-card-actions class="justify-center">
            <nuxt-link :to="`/bots/${$route.params.botId}/flows/${flow.id}`">
              <v-btn 
                flat
                color="blue"
              >
                Info
              </v-btn>
            </nuxt-link>
          </v-card-actions>
        </v-card>
      </v-flex>
    </v-layout>
    <v-layout 
      v-else
      row 
      wrap>
      <v-flex xs12>
        <v-card>
          <v-card-title class="headline justify-center">
            There aren't any flows yet.
          </v-card-title>
        </v-card>
      </v-flex>
    </v-layout>

    <flow-form />
  </div>
</template>

<script>
import FlowForm from '@/components/Flows/FlowForm.vue'

export default {
  components: {
    FlowForm
  },
  props: {
    bot: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      flows: []
    }
  },
  created() {
    this.$axios
      .get(`/v1/user/bots/${this.$route.params.botId}/flows`)
      .then(res => {
        this.flows = res.data.data
      })
  }
}
</script>

<style>
</style>
