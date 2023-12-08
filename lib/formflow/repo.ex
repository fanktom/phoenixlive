defmodule Formflow.Repo do
  use Ecto.Repo,
    otp_app: :formflow,
    adapter: Ecto.Adapters.Postgres
end
