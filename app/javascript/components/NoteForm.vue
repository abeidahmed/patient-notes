<template>
  <form @submit.prevent="createNote" class="space-y-4">
    <section>
      <label class="mb-2 inline-block font-semibold" for="poc">
        Plan of care
      </label>
      <input
        type="text"
        v-model="poc"
        id="poc"
        class="block w-full rounded-md border-gray-300"
        placeholder="STG=3 visual identification"
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

            <PronunciationStatus
              @pronounced="addPronunciationStatus(field.id, $event)"
            />
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
import ToggleableField from './ToggleableField.vue';
import PronunciationStatus from './PronunciationStatus.vue';

export default {
  components: { ToggleableField, PronunciationStatus },
  props: ['patient_id'],
  data: function() {
    return {
      poc: '',
      fields: [],
    };
  },
  created() {
    this.addField();
  },
  methods: {
    addField() {
      this.fields.push({
        id: uuid(),
        name: '',
        wordError: '',
        additionalInfo: '',
        pronunciationsAttributes: [],
      });
    },
    removeField(id) {
      this.fields = this.fields.filter((field) => field.id !== id);
    },
    addPronunciationStatus(fieldId, array) {
      const foundField = this.fields.find((field) => field.id === fieldId);
      foundField.pronunciationsAttributes = array;
    },
    async createNote() {
      const request = new FetchRequest(
        'post',
        `/patients/${this.patient_id}/notes`,
        {
          body: JSON.stringify({
            note: {
              poc: this.poc,
              practiceWordsAttributes: this.fields,
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
