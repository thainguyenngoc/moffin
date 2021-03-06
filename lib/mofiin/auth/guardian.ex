defmodule Mofiin.Auth.Guardian do
  use Guardian, otp_app: :mofiin
  alias Mofiin.Auth

  @spec subject_for_token(atom() | %{id: any()}, any()) :: {:ok, any()}
  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(claims) do
    user = claims["sub"]
    |> Auth.get_user!
    {:ok, user}
    # If something goes wrong here return {:error, reason}
  end
end
