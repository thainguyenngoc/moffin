
defmodule Mofiin.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :mofiin,
    error_handler: Mofiin.Auth.ErrorHandler,
    module: Mofiin.Auth.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
