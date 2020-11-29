<template>
  <div>
    <todo-top />
    <todo-card v-for="todo in todoData" :key="todo.id" :todo="todo" />
  </div>
</template>
<script>
import TodoTop from '../../components/TodoTop'
import TodoCard from '../../components/TodoCard'
export default {
  components: {
    'todo-top': TodoTop,
    'todo-card': TodoCard,
  },
  data() {
    return {
      todoData: [],
    }
  },
  async created() {
    await this.$axios.$get('/api/v1/todos').then((res) => {
      this.todoData = res
    })
  },
}
</script>
