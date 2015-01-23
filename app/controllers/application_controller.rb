class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :application_controller_ui_filter

  def application_controller_ui_filter


    if request.fullpath.start_with? '/kanaui'
      #
      # - If we have a cookie that looks valid we just verify with Kill Bill the session is still valid.
      # - If we don't, or if the session is not valid any longer, we redirect to Kaui LoginProxyController so that
      #   Kaui specific filtering logic for authentication and multi-tenancy can kick-in...
      #
      if session &&
          session['warden.user.user.key'] &&
          session['kb_tenant_id']

        session_id = session['warden.user.user.key'][0][0]
        user = Kaui::User.find(session_id) if session_id
        if user
          begin
            KillBillClient::Model::Security.find_permissions :session_id => user.kb_session_id
            # Yeah, done !!!
            return
          rescue KillBillClient::API::Unauthorized => e
          end
        end
      end

      redirect_to Kaui::Engine.routes.url_helpers.check_login_path(:path => request.fullpath), {}
    end

  end
end
