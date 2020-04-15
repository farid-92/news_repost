class User::Update
  include Interactor

  def call
    params = context.params
    user = context.user
    if user.update(params)
      context.resource = user
    else
      context.fail! errors: user.errors
    end
  end
end
