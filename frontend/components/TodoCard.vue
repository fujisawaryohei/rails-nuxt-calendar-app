<template>
  <v-row>
    <v-col cols="12">
      <v-card elevation="2" outlined :light="true">
        <v-card-title>{{ todoTitle }}</v-card-title>
        <v-card-subtitle>{{ todoDate }}, {{ todoTime }}に開始</v-card-subtitle>
        <v-card-text>{{ todoContent }}</v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn depressed color="error" @click="remove()"> 削除する </v-btn>
          <v-btn depressed color="info" @click="toEdit()"> 編集する </v-btn>
          <v-btn v-if="!todo.is_done" depressed color="primary" @click="done()">
            完了
          </v-btn>
          <v-btn v-else depressed color="warning" @click="back()">未完了</v-btn>
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
    async done() {
      await this.$axios.$patch(`/api/v1/todos/${this.todo.id}`, {
        is_done: true,
      })
      // TODO: 環境変数管理にシフト
      window.location.href = `http://localhost:3000/todos`
    },
    async back() {
      await this.$axios.$patch(`/api/v1/todos/${this.todo.id}`, {
        is_done: false,
      })
      // TODO: 環境変数管理にシフト
      window.location.href = `http://localhost:3000/todos`
    },
    async remove() {
      const confirmation = window.confirm('本当に削除しますか？')
      if (confirmation) {
        await this.$axios.$delete(`/api/v1/todos/${this.todo.id}`)
        // TODO: 環境変数管理にシフト
        window.location.href = `http://localhost:3000/todos`
      }
    },
  },
}
</script>
