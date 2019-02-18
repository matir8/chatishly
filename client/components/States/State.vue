<template>
  <state-container :state="state" />
</template>

<script>
export default {
  components: {
    stateContainer: {
      props: {
        state: {
          type: Object,
          default: null
        }
      },
      render: function(createElement) {
        switch (this.state.attributes['statable-type']) {
          case 'TextState':
            return createElement('span', this.state.attributes.statable.text)
            break
          case 'QuestionState':
            return createElement(
              'span',
              this.state.attributes.statable.question
            )
            break
          case 'ImageState':
            return createElement('v-img', {
              attrs: { src: this.state.attributes.statable.url }
            })
            break
          case 'OpenGraphState':
            return createElement(
              'a',
              {
                attrs: {
                  href: this.state.attributes.statable.url,
                  target: '_blank'
                }
              },
              this.state.attributes.statable.url
            )
            break
          default:
            return 'Unknown state'
            break
        }
      }
    }
  },
  props: {
    state: {
      type: Object,
      default: null
    }
  }
}
</script>

<style>
</style>
