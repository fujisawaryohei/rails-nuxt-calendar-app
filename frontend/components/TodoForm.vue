<template>
  <v-row>
    <v-col cols="12">
      <v-form>
        <v-text-field
          label="Todo"
          :value="title"
          @change="(value) => (title = value)"
        >
        </v-text-field>
      </v-form>
    </v-col>
    <v-col cols="6">
      <v-menu
        ref="menu"
        v-model="menu"
        :close-on-content-click="false"
        :return-value.sync="date"
        transition="scale-transition"
        offset-y
        min-width="290px"
        :light="true"
      >
        <template v-slot:activator="{ on }">
          <v-text-field
            v-model="date"
            label="Picker in Date"
            readonly
            v-on="on"
          ></v-text-field>
        </template>
        <v-date-picker v-model="date" no-title scrollable>
          <v-spacer></v-spacer>
          <v-btn text color="primary" @click="menu = false">Cancel</v-btn>
          <v-btn text color="primary" @click="$refs.menu.save(date)">OK</v-btn>
        </v-date-picker>
      </v-menu>
    </v-col>
    <v-col cols="6">
      <v-menu
        ref="timeMenu"
        v-model="menu2"
        :close-on-content-click="false"
        :return-value.sync="time"
        transition="scale-transition"
        offset-y
        min-width="290px"
        :light="true"
      >
        <template v-slot:activator="{ on }">
          <v-text-field
            v-model="time"
            label="Picker in Time"
            readonly
            v-on="on"
          ></v-text-field>
        </template>
        <v-time-picker v-model="time">
          <v-spacer></v-spacer>
          <v-btn text color="primary" @click="menu2 = false">Cancel</v-btn>
          <v-btn text color="primary" @click="$refs.timeMenu.save(time)"
            >OK</v-btn
          >
        </v-time-picker>
      </v-menu>
    </v-col>
    <v-col cols="12">
      <v-textarea v-model="description" color="teal">
        <template v-slot:label>
          <div>description <small>(optional)</small></div>
        </template>
      </v-textarea>
    </v-col>
    <v-col cols="12">
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="error" @click="remove()"> 取り消す </v-btn>
        <v-btn color="primary" @click="submit()">送信</v-btn>
      </v-card-actions>
    </v-col>
  </v-row>
</template>
<script>
export default {
  props: {
    todoId: {
      type: String,
      required: false,
      default: '',
    },
  },
  data() {
    return {
      title: '',
      date: '',
      time: '',
      description: '',
      menu: false,
      menu2: false,
    }
  },
  async created() {
    if (this.todoId) {
      await this.$axios.$get(`api/v1/todos/${this.todoId}`).then((res) => {
        this.title = res.title
        this.date = res.date
        this.time = res.time
        this.description = res.content
      })
    }
  },
  methods: {
    submit() {
      const params = {
        title: this.title,
        content: this.description,
        date: this.date,
        time: this.time,
      }
      this.todoId ? this.update(params, this.todoId) : this.create(params)
    },
    remove() {
      this.title = ''
      this.description = ''
      this.date = ''
      this.time = ''
    },
    create(params) {
      this.$axios.post('/api/v1/todos', params).then((res) => {
        if (res.data) {
          const errorMessage = `
            下記の部分を確認してください. \n
            タイトル: ${res.data.title}
            日付: ${res.data.date}
            時間: ${res.data.time}
            内容: ${res.data.content} 
          `
          return window.alert(errorMessage)
        }
        this.$router.push('/todos')
      })
    },
    update(params, id) {
      this.$axios.patch(`/api/v1/todos/${id}`, params).then((res) => {
        if (res.data) {
          const errorMessage = `
            下記の部分を確認してください. \n
            タイトル: ${res.data.title}
            日付: ${res.data.date}
            時間: ${res.data.time}
            内容: ${res.data.content} 
          `
          return window.alert(errorMessage)
        }
        this.$router.push('/todos')
      })
    },
  },
}
</script>
