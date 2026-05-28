class Users::SessionsController < Devise::SessionsController
  respond_to :html, :json

  private

  def respond_with(resource, _opts = {})
    respond_to do |format|
      format.html { super }
      format.json do
        render json: {
          message: "Logged in Successfully",
          user: {
            id: resource.id,
            email: resource.email
          }
        }, status: :ok
      end
    end
  end

  def respond_to_on_destroy
    respond_to do |format|
      format.html { super }
      format.json { render json: { message: "Logged out successfully" }, status: :ok }
    end
  end
end
