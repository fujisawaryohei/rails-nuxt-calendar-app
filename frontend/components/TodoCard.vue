<template>
  <v-row>
    <v-col cols="12">
      <v-card elevation="2" outlined :light="true">
        <v-card-title>{{ todoTitle }}</v-card-title>
        <v-card-subtitle>{{ todoDate }}, {{ todoTime }}に開始</v-card-subtitle>
        <v-card-text>{{ todoContent }}</v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn depressed color="error"> 削除する </v-btn>
          <v-btn depressed color="info" @click="toEdit()"> 編集する </v-btn>
          <v-btn depressed color="primary"> 完了 </v-btn>
        </v-card-actions>
      </v-card>
    </v-col>
  </v-row>
</template>
<script>
export default {
  props: {
    todo: {
      type: Object,
      required: true,
      default: () => [],
    },
  },
  computed: {
    todoTitle() {
      return this.todo.title
    },
    todoContent() {
      return this.todo.content
    },
    todoDate() {
      return this.todo.date
    },
    todoTime() {
      return this.todo.time
    },
  },
  methods: {
    toEdit() {
      this.$router.push(`/todos/${this.todo.id}`)
    },
  },
}
</script>
