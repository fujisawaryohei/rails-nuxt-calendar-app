<template>
  <div>
    <todo-top />
    <todo-card />
  </div>
</template>
<script>
import TodoTop from '../components/TodoTop'
import TodoCard from '../components/TodoCard'
export default {
  components: {
    'todo-top': TodoTop,
    'todo-card': TodoCard,
  },
}
</script>
