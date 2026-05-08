class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resources, _opts = {})
    render json: {
      messgae: "Logged in Successfully",
      user: {
        id: resources.id,
        email: resources.email
      }
    }, status: :ok
  end

  # more redable now arguement is passed in class method
  def respond_to_on_destroy
    self.render(json: { message: "Logged out successfully" }, status: :ok)
  end
end
