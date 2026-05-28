class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :html, :json

  private

  def respond_with(resource, _opts = {})
    respond_to do |format|
      format.html { super }
      format.json do
        if resource.persisted?
          render json: {
            message: "User created successfully",
            user: {
              id: resource.id,
              email: resource.email
            }
          }, status: :ok
        else
          render json: {
            error: resource.errors.full_messages
          }, status: :unprocessable_entity
        end
      end
    end
  end
end
