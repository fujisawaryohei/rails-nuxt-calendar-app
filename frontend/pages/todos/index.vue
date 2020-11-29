<template>
  <div>
    <todo-top @switchTaskStatus="switchTaskStatus" />
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
      initData: [],
      todoData: [],
      isDone: false,
    }
  },
  async created() {
    await this.$axios.$get('/api/v1/todos').then((res) => {
      this.initData = res
      this.todoData = res.filter((data) => {
        return data.is_done === false
      })
    })
  },
  methods: {
    switchTaskStatus(value) {
      this.todoData = this.initData.filter((data) => {
        return data.is_done === value
      })
    },
  },
}
</script>
