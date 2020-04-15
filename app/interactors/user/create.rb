class User::Create
  include Interactor

  def call
    params = context.params
    user = User.create(params)
    if user.valid?
      context.resource = user
    else
      context.fail! errors: user.errors
    end
  end
end
