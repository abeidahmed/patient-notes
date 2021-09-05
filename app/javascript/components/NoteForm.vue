<template>
  <form @submit="createNote" class="space-y-4">
    <section>
      <label class="mb-2 inline-block font-semibold" for="poc">
        Plan of care
      </label>
      <input
        type="text"
        v-model="poc"
        id="poc"
        class="block w-full rounded-md border-gray-300"
        autocomplete="off"
        required
      />
    </section>

    <div class="space-y-4">
      <section class="divide-y space-y-5">
        <div v-for="field in fields" :key="field.id" class="space-y-4 pt-4">
          <section>
            <div>
              <label
                class="mb-2 inline-block font-semibold"
                for="practice-word"
              >
                Practice word
              </label>
              <input
                type="text"
                v-model="field.name"
                id="practice-word"
                class="block w-full rounded-md border-gray-300"
                placeholder="/sh/ IWP, bird, fish, etc"
                autocomplete="off"
              />
            </div>

            <div class="flex items-center justify-between mt-2">
              <div class="flex-1 flex items-center flex-wrap text-gray-700">
                <BaseIcon><PlusIcon /></BaseIcon>
                <BaseIcon><MinusIcon /></BaseIcon>
              </div>

              <div class="flex-shrink-0">
                <button
                  type="button"
                  class="p-1 rounded-md text-green-600 hover:bg-green-100"
                >
                  <BaseIcon><CheckIcon /></BaseIcon>
                </button>

                <button
                  type="button"
                  class="p-1 rounded-md text-red-600 hover:bg-red-100"
                >
                  <BaseIcon><XIcon /></BaseIcon>
                </button>
              </div>
            </div>
          </section>

          <ToggleableField
            v-model="field.wordError"
            placeholder="Mispronounced swim, kick, catch, throw"
            label="Track word specific errors?"
          />

          <ToggleableField
            v-model="field.additionalInfo"
            placeholder="Any other information about the word..."
            label="Add additional information?"
            type="textarea"
          />

          <section class="flex justify-end">
            <button
              type="button"
              @click="removeField(field.id)"
              v-if="fields.length > 1"
              class="bg-transparent hover:text-blue-700"
            >
              Remove field
            </button>
          </section>
        </div>
      </section>

      <button
        type="button"
        @click="addField"
        class="rounded-md py-2 px-3 bg-white border block w-full text-center font-semibold text-gray-700 hover:bg-gray-100"
      >
        Add another practice word
      </button>
    </div>

    <hr class="border-gray-400" />

    <div class="flex justify-end space-x-3">
      <button
        type="submit"
        class="rounded-md py-2 px-3 bg-indigo-600 text-white hover:bg-indigo-500 font-semibold cursor-pointer"
      >
        Create note
      </button>
    </div>
  </form>
</template>

<script>
import { FetchRequest } from '@rails/request.js';
import uuid from '../helpers/uuid';
import removeProperties from '../helpers/remove_properties';
import ToggleableField from './ToggleableField.vue';
import BaseIcon from './icons/BaseIcon.vue';
import CheckIcon from './icons/CheckIcon.vue';
import XIcon from './icons/XIcon.vue';
import PlusIcon from './icons/PlusIcon.vue';
import MinusIcon from './icons/MinusIcon.vue';

export default {
  components: {
    ToggleableField,
    BaseIcon,
    CheckIcon,
    XIcon,
    PlusIcon,
    MinusIcon,
  },
  props: ['patient_id'],
  data: function() {
    return {
      poc: '',
      fields: [
        {
          id: uuid(),
          name: '',
          wordError: '',
          additionalInfo: '',
        },
      ],
    };
  },
  methods: {
    addField(event) {
      event.preventDefault();

      this.fields.push({
        id: uuid(),
        name: '',
        wordError: '',
        additionalInfo: '',
      });
    },
    removeField(id) {
      this.fields = this.fields.filter((field) => field.id !== id);
    },
    async createNote(event) {
      event.preventDefault();

      const fieldObjects = removeProperties(this.fields, ...['id']);

      const request = new FetchRequest(
        'post',
        `/patients/${this.patient_id}/notes`,
        {
          body: JSON.stringify({
            note: {
              poc: this.poc,
              practiceWordsAttributes: fieldObjects,
            },
          }),
        }
      );

      try {
        const response = await request.perform();
        if (!response.ok) throw new Error('Something went wrong!');
      } catch (error) {
        console.log(error);
      }
    },
  },
};
</script>
