<template>
  <section>
    <label class="inline-flex flex-items-center">
      <input
        type="checkbox"
        @change="toggleField"
        :checked="showField"
        class="rounded-sm border-gray-300 mt-1"
      />

      <span class="ml-2 leading-5">
        {{ label }}
      </span>
    </label>

    <div v-if="type === 'textarea'">
      <textarea
        :value="value"
        @input="emitValue($event.target.value)"
        :placeholder="placeholder"
        v-show="showField"
        rows="4"
        class="block w-full rounded-md border-gray-300 mt-2"
        autocomplete="off"
      ></textarea>
    </div>

    <div v-else>
      <input
        :type="type"
        :value="value"
        @input="emitValue($event.target.value)"
        :placeholder="placeholder"
        v-show="showField"
        class="block w-full rounded-md border-gray-300 mt-2"
        autocomplete="off"
      />
    </div>
  </section>
</template>

<script>
export default {
  data: function() {
    return {
      showField: false,
    };
  },
  props: {
    label: String,
    value: String,
    type: {
      type: String,
      default: 'text',
    },
    placeholder: {
      type: String,
      default: '',
    },
  },
  methods: {
    emitValue(value) {
      this.$emit('input', value);
    },
    toggleField(event) {
      if (event.target.checked) {
        this.showField = true;
      } else {
        this.showField = false;
      }
    },
  },
};
</script>
