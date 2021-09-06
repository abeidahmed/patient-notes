class NotesController < ApplicationController
  before_action :underscore_params!, only: %i[create]

  def index
    @patient = get_patient
    @notes = @patient.notes
  end

  def new
    @patient = get_patient
  end

  def create
    patient = get_patient
    note = patient.notes.build(note_params)

    if note.save
      respond_to do |format|
        format.any { render json: note, status: :created }
      end
    else
      render_json_errors(note.errors)
    end
  end

  def show
    @patient = get_patient
    @note = @patient.notes.includes(practice_words: :pronunciations).find(params[:id])
  end

  private

  def note_params
    params.require(:note).permit(
      :poc,
      practice_words_attributes: [
        :name,
        :word_error,
        :additional_info,
        :_destroy,
        pronunciations_attributes: [:result, :_destroy]
      ]
    )
  end

  def get_patient
    @get_patient ||= Patient.find(params[:patient_id])
  end
end
