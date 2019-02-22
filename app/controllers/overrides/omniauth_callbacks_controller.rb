module Overrides
  class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
    def assign_provider_attrs(user, auth_hash)
      all_attrs = auth_hash['info'].slice(*user.attributes.keys)
      orig_val = ActionController::Parameters.permit_all_parameters
      ActionController::Parameters.permit_all_parameters = true
      permitted_attrs = ActionController::Parameters.new(all_attrs)
      permitted_attrs.permit({})
      user.assign_attributes(permitted_attrs)
      ActionController::Parameters.permit_all_parameters = orig_val
      user
    end

    def omniauth_success
      get_resource_from_auth_hash
      set_token_on_resource
      create_auth_params

      sign_in(:user, @resource, store: false, bypass: false)

      provider = auth_hash.provider
      token = auth_hash.credentials.token
      @resource.social_access_tokens = Hash[provider, token]
      @resource.save!

      redirect_to "#{ENV['callback_url']}?#{@auth_params.to_query}"
    end
  end
end
