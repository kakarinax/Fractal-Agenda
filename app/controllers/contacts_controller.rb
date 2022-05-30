class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ show edit update destroy ]

  # GET /contacts or /contacts.json
  def index
    @contacts = current_user.contacts
  end

  # GET /contacts/1 or /contacts/1.json
  def show
    @contact = current_user.contacts.find(params[:id])
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    @contact.user = current_user
  end

  # GET /contacts/1/edit
  def edit
    @contact
  end

  # POST /contacts or /contacts.json
  def create
    @contact = Contact.new(contact_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @contact.save
        format.html { redirect_to contact_url(@contact), notice: "Contact was successfully created." }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to contact_url(@contact), notice: "Contact was successfully updated." }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1 or /contacts/1.json
  def destroy
    @contact = current_user.contacts.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url, notice: "Contact was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
      @contact = current_user.contacts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:name, :relationship, :email, :phone, :city, :state, :country)
    end

    def authenticate_user!
      unless current_user == @contact.user
        redirect_to root_url, alert: "You must be logged in to access this page.", status: :forbidden
      end
    end
end
