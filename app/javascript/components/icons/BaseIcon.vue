<template>
  <svg
    xmlns="http://www.w3.org/2000/svg"
    fill="currentColor"
    viewBox="0 0 24 24"
    :width="width"
    :height="width"
  >
    <slot />
  </svg>
</template>

<script>
export default {
  props: {
    width: {
      type: [Number, String],
      default: 24,
    },
    height: {
      type: [Number, String],
      default: 24,
    },
  },
};
</script>
