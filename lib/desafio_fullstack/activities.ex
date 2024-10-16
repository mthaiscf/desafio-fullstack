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
    tags: list()
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
  @spec get_by_city(String.t()) :: [Activity.t()] | []
  def get_by_city(city) do
    city
    |> ActivityQueries.get_by_city()
    |> Repo.all()
  end

  @doc """

    Recupera as atividades registradas por tag

  ## Exemplo:

    iex> import DesafioFullstack.ActivityFactory
    iex>
    iex> params = insert(:activity, tags: ["gratuito"])
    iex>
  	iex> Activities.get_by_tags("gratuito")
    [%Activity{}]
    iex > Activities.get_by_tags("")
    []
  """
  @spec get_by_tags(String.t()) :: [Activity.t()] | []
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
  @spec get_by_title(String.t()) :: [Activity.t()] | []
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

  @doc """

    Recupera as atividades registradas pelo título e tags selecionadas

  ## Exemplo:

    iex> import DesafioFullstack.ActivityFactory
    iex>
    iex> params = insert(:activity, title: "Parque Botânico",  tags: ["gratuito"])
    iex>
  	iex> Activities.search_activities("Parque Botânico", ["gratuito"])
    [%Activity{}]
    iex > Activities.search_activities("", [""])
    []
  """
  @spec search_activities(String.t(), [String.t()]) :: [Activity.t()] | []
  def search_activities(title, tags) do
    search_activities_private(title, tags)
  end

  defp search_activities_private(title, tags) when (tags != [] and title != "") do
    tags
    |> ActivityQueries.get_by_tags()
    |> ActivityQueries.get_by_title(title)
    |> Repo.all()
  end

  defp search_activities_private(_title, tags) when (tags != []) do
    get_by_tags(tags)
  end

  defp search_activities_private(title, _tags) when (title != "") do
    get_by_title(title)
  end

  defp search_activities_private(_title, _tags)do
    get_by_city("Maceió")
  end
end
