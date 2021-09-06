<template>
  <div>
    <div class="flex items-baseline justify-between mt-2">
      <div class="flex-1 flex items-center flex-wrap text-gray-700">
        <div v-for="pronunciation in pronunciations" :key="pronunciation.id">
          <BaseIcon v-if="pronunciation.result === 'pronounced'">
            <PlusIcon />
          </BaseIcon>

          <BaseIcon v-else-if="pronunciation.result === 'mispronounced'">
            <MinusIcon />
          </BaseIcon>
        </div>
      </div>

      <div class="flex-shrink-0">
        <button
          type="button"
          @click="addPronunciationStatus('pronounced')"
          class="p-1 rounded-md text-green-600 hover:bg-green-100"
        >
          <BaseIcon><CheckIcon /></BaseIcon>
        </button>

        <button
          type="button"
          @click="addPronunciationStatus('mispronounced')"
          class="p-1 rounded-md text-red-600 hover:bg-red-100"
        >
          <BaseIcon><XIcon /></BaseIcon>
        </button>
      </div>
    </div>

    <div
      v-show="totalPronunciations > 0"
      class="flex items-center justify-between"
    >
      <p class="mt-2">
        Result: {{ totalPronounced }}/{{ totalPronunciations }} =
        {{ successPercentage }}
      </p>

      <button
        type="button"
        @click="resetPronunciations"
        class="bg-transparent text-gray-600 hover:text-blue-700"
      >
        Reset result
      </button>
    </div>
  </div>
</template>

<script>
import uuid from '../helpers/uuid';
import BaseIcon from './icons/BaseIcon.vue';
import CheckIcon from './icons/CheckIcon.vue';
import XIcon from './icons/XIcon.vue';
import PlusIcon from './icons/PlusIcon.vue';
import MinusIcon from './icons/MinusIcon.vue';

export default {
  components: { BaseIcon, CheckIcon, XIcon, PlusIcon, MinusIcon },
  data: function() {
    return {
      pronunciations: [],
    };
  },
  methods: {
    addPronunciationStatus(result) {
      this.pronunciations.push({
        id: uuid(),
        result,
      });

      this.emitPronunciations()
    },
    resetPronunciations() {
      this.pronunciations = [];
      this.emitPronunciations()
    },
    emitPronunciations() {
      this.$emit('pronounced', this.pronunciations);
    }
  },
  computed: {
    totalPronounced() {
      return this.pronunciations.reduce((total, value) => {
        return total + (value.result === 'pronounced');
      }, 0);
    },
    totalPronunciations() {
      return this.pronunciations.length;
    },
    successPercentage() {
      const percentage =
        (this.totalPronounced / this.totalPronunciations) * 100;
      return `${Math.ceil(percentage)}%`;
    },
  },
};
</script>
