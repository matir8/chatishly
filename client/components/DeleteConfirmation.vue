<template>
  <div id="deleteConfirmation">
    <v-tooltip top>
      <v-btn
        slot="activator"
        flat
        @click="dialog = true"
      >
        <i class="material-icons">delete</i>
      </v-btn>
      <span>Delete</span>
    </v-tooltip>

    <v-dialog
      v-model="dialog"
      max-width="290"
    >
      <v-card>
        <v-card-title class="headline">Confirm deletion?</v-card-title>

        <v-card-text>
          Are you sure?
        </v-card-text>

        <v-card-actions>
          <v-spacer/>

          <v-btn
            color="black darken-1"
            flat="flat"
            @click="dialog = false"
          >
            Cancel
          </v-btn>

          <v-btn
            color="red darken-1"
            flat="flat"
            @click="remove"
          >
            Agree
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      dialog: false
    }
  },
  methods: {
    remove() {
      this.dialog = false
      this.$emit('agree')
    }
  }
}
</script>

<style>
</style>
