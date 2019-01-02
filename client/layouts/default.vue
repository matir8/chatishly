<template>
  <v-app id="inspire">
    <navigation-drawer />
    <navbar/>
    <v-content>
      <nuxt />
    </v-content>
  </v-app>
</template>

<script>
import NavigationDrawer from '@/components/NavigationDrawer.vue'
import Navbar from '@/components/Navbar.vue'

export default {
  components: {
    NavigationDrawer,
    Navbar
  }
}
</script>

<style>
</style>
