class ProfileController < ApplicationController
  def index; end

  def edit; end

  def update
    current_user.update!(profile_params)

    render turbo_stream: [
      turbo_stream.replace(:toast, partial: "shared/toast", locals: { notice: 'Account updated' }),
      turbo_stream.replace(:edit_profile, template: "profile/index")
    ]
  end

  private

  def profile_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end