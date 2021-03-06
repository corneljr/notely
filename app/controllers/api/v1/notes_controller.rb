class Api::V1::NotesController < ApplicationController
  before_action :set_note, only: [:show, :update, :destroy]
  doorkeeper_for :index, :show, scopes: [:public]
  doorkeeper_for :update, :create, scopes: [:write, :update, :destroy]
  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
    render json: @notes
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    render json: @note
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

    if @note.save
      render json: @note, status: :created
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    if @note.update(note_params)
      head :no_content
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy

    head :no_content
  end

private
  
  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :body, :category_id) if params[:note]
  end
end
