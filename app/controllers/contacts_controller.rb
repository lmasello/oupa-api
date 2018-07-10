class ContactsController < ApplicationController
  def index
    render json: current_user.contacts, status: :ok
  end

  def create
    contact = Contact.new(contact_param)
    if current_user.type == 'ElderlyUser'
      contact.assign_attributes(elderly_user: current_user)
    else
      contact.assign_attributes(elderly_user: current_user.elderly_user)
    end
    if contact.save
      render json: contact, status: :ok
    else
      render json: { errors: contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_param)
      render json: contact, status: :ok
    else
      render json: { errors: contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def contact_param
    params.require(:contact).permit(:name, :phone_number, :picture)
  end
end
