<template>
  <div id="navigation-drawer">
    <v-navigation-drawer
      mini-variant
      mini-variant-width="50"
      permanent
      dark
      app
    >
      <v-list dense>
        <v-list-tile
          v-for="item in items"
          :key="item.title"
        >
          <v-list-tile-action>
            <nuxt-link
              :to="item.href"
              class="nav-link"
            >
              <v-icon>{{ item.icon }}</v-icon>
            </nuxt-link>
          </v-list-tile-action>
        </v-list-tile> 
      </v-list>
    </v-navigation-drawer>
  </div>
</template>

<script>
export default {
  data() {
    return {
      items: [
        { href: '/', icon: 'home' },
        // { href: '/profile', icon: 'account_box' },
        { href: '/', icon: 'gavel' }
      ]
    }
  }
}
</script>

<style>
a.nav-link {
  text-decoration: none;
}

a.nav-link i.v-icon:hover {
  color: #ffa000;
}

.v-list__tile {
  padding: 0px;
}
</style>
