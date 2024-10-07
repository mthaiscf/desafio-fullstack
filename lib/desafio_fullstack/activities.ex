defmodule DesafioFullstack.Activities do

  @moduledoc """
    Módulo responsável por gerenciar as atividades.
    Faz criação, selecão por id e seleção aleatória.
  """

  alias DesafioFullstack.Activities.{Activity, ActivityQueries}
  alias DesafioFullstack.Repo

  @type create_activity_attrs :: %{
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
    tags: map()
  }

  @doc """

    Função para criar uma Activity

  ### Exemplos :

  iex> import DesafioFullstack.ActivityFactory
  iex>
  iex> params = insert(:activity)
  iex>
  iex> DesafioFullstack.create_activity(params)
  {:ok, %Activity{}}

  iex> DesafioFullstack.create_activity(invalid_params)
  {:error, %Ecto.Changeset{}}

  """
  @spec create_activity(create_activity_attrs()) ::
      {:ok, Activity.t()} | {:error, Ecto.Changeset.t()}
  def create_activity(params) do
    %Activity{}
    |> Activity.changeset(params)
    |> Repo.insert()
  end

  @doc """

    Recupera as atividades registradas por cidade

  ## Exemplo:

    iex> import DesafioFullstack.ActivityFactory
    iex>
    iex> params = insert(:activity, city: "Maceió")
    iex>
  	iex> Activities.get_by_city("Maceió")
    [%Activity{}]
    iex > Activities.get_by_city(["")
    []
  """
  @spec get_by_city(city: String.t()) :: [Activity.t()] | []
  def get_by_city(city) do
    city
    |> ActivityQueries.get_by_city()
    |> Repo.all()
  end

    @doc """

    Recupera as atividades registradas por tags

  ## Exemplo:

    iex> import DesafioFullstack.ActivityFactory
    iex>
    iex> params = insert(:activity, tags: ["gratuito"])
    iex>
  	iex> Activities.get_by_tags(["gratuito"])
    [%Activity{}]
    iex > Activities.get_by_tags([""])
    []
  """
  @spec get_by_tags(tags: map()) :: [Activity.t()] | []
  def get_by_tags(tags) do
    tags
    |> ActivityQueries.get_by_tags()
    |> Repo.all()
  end

  @doc """

    Recupera as atividades registradas pelo título

  ## Exemplo:

    iex> import DesafioFullstack.ActivityFactory
    iex>
    iex> params = insert(:activity, title: "Parque Botânico")
    iex>
  	iex> Activities.get_by_title("Parque Botânico")
    [%Activity{}]
    iex > Activities.get_by_title(["")
    []
  """
  @spec get_by_title(title: String.t()) :: [Activity.t()] | []
  def get_by_title(title) do
    title
    |> ActivityQueries.get_by_title()
    |> Repo.all()
  end

  @doc """

    Recupera uma atividade registrada no banco aleatoriamente

  ## Exemplo :
    iex> import DesafioFullstack.ActivityFactory
    iex>
    iex> insert_pair(:activity)
    iex>
  	iex> Activities.get_random()
    [%Activity{}]
  """
  @spec get_random() :: Activity.t()
  def get_random() do
    ActivityQueries.get_random()
    |> Repo.one()
  end

end
