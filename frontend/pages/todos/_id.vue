<template>
  <!-- 本来はここでデータを取得してオブジェクトを渡す方がPropsの使用方針としては統一性があるが、emitするのが面倒なので、
  今回はidを子コンポーネントに渡す -->
  <todo-form :todo-id="$route.params.id" />
</template>
<script>
import TodoForm from '../../components/TodoForm'
export default {
  components: {
    'todo-form': TodoForm,
  },
}
</script>
