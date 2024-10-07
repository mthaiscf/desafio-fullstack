defmodule DesafioFullstack.Activities.Activity do

  @moduledoc """
  Esse schema representa uma atividade.

  Cada atividade deve ter :

    - título,
    - descrição,
    - Instagram,
    - local no Google Maps,
    - e tags (como "esportes", "museus", "parques", "gratuito", "bom para crianças", "bom para casais", etc).


    * Além dos itens mencionados inseri mais algumas características que identificam a atividade.

  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
    title: String.t(),
    photo: String.t(),
    description: String.t(),
    instagram_account: String.t(),
    google_place: String.t(),
    url: String.t(),
    address: String.t(),
    address_complement: String.t(),
    email: String.t(),
    phone_number: String.t(),
    city: String.t(),
    tags: [String.t()]
  }

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "activities" do
    field(:title, :string)
    field(:photo, :string)
    field(:description, :string)
    field(:instagram_account, :string)
    field(:google_place, :string)
    field(:url, :string)
    field(:address, :string)
    field(:address_complement, :string)
    field(:email, :string)
    field(:phone_number, :string)
    field(:city, :string)
    field(:tags, {:array, :string})
    timestamps()
  end

  @required_fields ~w(title photo description google_place address city tags)a

  @optional_fields ~w(instagram_account url address_complement email phone_number)a

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

end
