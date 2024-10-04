defmodule DesafioFullstack.Repo do
  use Ecto.Repo,
    otp_app: :desafio_fullstack,
    adapter: Ecto.Adapters.Postgres
end
