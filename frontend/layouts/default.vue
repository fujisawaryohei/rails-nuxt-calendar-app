<template>
  <v-app dark>
    <side-nav-menu :drawer="drawer" :items="loggedInItems" />
    <v-app-bar fixed app>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      <v-toolbar-title v-text="title" />
    </v-app-bar>
    <v-main>
      <v-container>
        <nuxt />
      </v-container>
    </v-main>
    <v-footer :absolute="!fixed" app>
      <span>&copy; {{ new Date().getFullYear() }}</span>
    </v-footer>
  </v-app>
</template>

<script>
import SideNavMenu from '../components/SideNav'
export default {
  components: {
    'side-nav-menu': SideNavMenu,
  },
  data() {
    return {
      title: 'Sample TodoApp',
      drawer: false,
      fixed: false,
      loggedInItems: [
        {
          icon: 'mdi-apps',
          title: 'Todoを追加する',
          to: '/',
        },
      ],
    }
  },
}
</script>
