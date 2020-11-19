<template>
  <v-app dark>
    <side-nav-menu
      :drawer="drawer"
      :mini-variant="miniVariant"
      :clipped="clipped"
      :items="loggedInItems"
    />
    <v-app-bar :clipped-left="clipped" fixed app>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      <v-btn icon @click.stop="miniVariant = !miniVariant">
        <v-icon>mdi-{{ `chevron-${miniVariant ? 'right' : 'left'}` }}</v-icon>
      </v-btn>
      <v-btn icon @click.stop="clipped = !clipped">
        <v-icon>mdi-application</v-icon>
      </v-btn>
      <v-toolbar-title v-text="title" />
      <v-spacer />
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
      clipped: false,
      drawer: false,
      fixed: false,
      loggedInItems: [
        {
          icon: 'mdi-apps',
          title: 'カレンダー',
          to: '/',
        },
      ],
      miniVariant: false,
      right: true,
      title: 'Roryu',
    }
  },
}
</script>
