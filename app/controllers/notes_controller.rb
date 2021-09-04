class NotesController < ApplicationController
  before_action :underscore_params!, only: %i[create]

  def new
    @patient = get_patient
  end

  def create
    patient = get_patient
    note = patient.notes.build(note_params)

    if note.save
      redirect_to patients_path, notice: "Note has been created"
    else
      render_json_errors(note.errors)
    end
  end

  private

  def note_params
    params.require(:note).permit(
      :poc,
      practice_words_attributes: [
        :id,
        :name,
        :word_error,
        :additional_info,
        :_destroy
      ]
    )
  end

  def get_patient
    @get_patient ||= Patient.find(params[:patient_id])
  end
end
