<template>
  <div id="flows">
    <flows :bot="bot"/>
    <flow-form />
  </div>
</template>

<script>
import Flows from '@/components/Flows'
import FlowForm from '@/components/Flows/FlowForm.vue'

export default {
  components: {
    Flows,
    FlowForm
  },
  data() {
    return {
      bot: null
    }
  },
  created() {
    this.$axios.get(`/v1/user/bots/${this.$route.params.botId}`).then(res => {
      this.bot = res.data.data
    })
  }
}
</script>

<style>
</style>
